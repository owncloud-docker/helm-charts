config = {
    "branches": [
        "main",
    ],
    # if this changes, also the kubeVersion in the Chart.yaml needs to be changed
    "kubernetes_versions": [
        "1.21.0",
        "1.22.0",
        "1.23.0",
        "1.24.0",
        "1.25.0",
    ],
}

def main(ctx):
    pipeline_starlark = starlark(ctx)

    pipeline_kubernetes = kubernetes(ctx, config)
    pipeline_kubernetes[0]["depends_on"].append(pipeline_starlark[0]["name"])

    pipeline_deployments = deployments(ctx)
    for pipeline in pipeline_deployments:
        pipeline["depends_on"].append(pipeline_kubernetes[0]["name"])

    return pipeline_starlark + pipeline_kubernetes + pipeline_deployments

def starlark(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "starlark",
        "steps": [
            {
                "name": "starlark-format",
                "image": "owncloudci/bazel-buildifier",
                "commands": [
                    "buildifier --mode=check .drone.star",
                ],
            },
            {
                "name": "starlark-diff",
                "image": "owncloudci/bazel-buildifier",
                "commands": [
                    "buildifier --mode=fix .drone.star",
                    "git diff",
                ],
                "when": {
                    "status": [
                        "failure",
                    ],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/main",
                "refs/pull/**",
            ],
        },
    }]

def kubernetes(ctx, config):
    pipeline = {
        "kind": "pipeline",
        "type": "docker",
        "name": "kubernetes",
        "steps": [
            {
                "name": "helm-lint",
                "image": "owncloudci/alpine:latest",
                "commands": [
                    "helm lint --strict charts/owncloud",
                ],
            },
            {
                "name": "helm-template",
                "image": "owncloudci/alpine:latest",
                "commands": [
                    "helm template charts/owncloud -f ci/ci-values.yaml > ci/owncloud-ci-templated.yaml",
                ],
                "depends_on": ["helm-lint"],
            },
            {
                "name": "kube-lint",
                "image": "stackrox/kube-linter:latest",
                "entrypoint": [
                    "/kube-linter",
                    "lint",
                    "ci/owncloud-ci-templated.yaml",
                ],
                "depends_on": ["helm-template"],
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/main",
                "refs/pull/**",
            ],
        },
    }

    for version in config["kubernetes_versions"]:
        pipeline["steps"].append(
            {
                "name": "kubeconform-%s" % version,
                "image": "ghcr.io/yannh/kubeconform:master",
                "entrypoint": [
                    "/kubeconform",
                    "-kubernetes-version",
                    "%s" % version,
                    "-summary",
                    "-strict",
                    "ci/owncloud-ci-templated.yaml",
                ],
                "depends_on": ["kube-lint"],
            },
        )

    return [pipeline]

def deployments(ctx):
    pipeline = {
        "kind": "pipeline",
        "type": "docker",
        "name": "k3d",
        "steps": wait(ctx) + install(ctx),
        "services": [
            {
                "name": "k3d",
                "image": "ghcr.io/k3d-io/k3d:5.4.6-dind",
                "privileged": True,
                "commands": [
                    "nohup dockerd-entrypoint.sh &",
                    "until docker ps 2>&1 > /dev/null; do sleep 1s; done",
                    "k3d cluster create --config k3d-drone.yaml --api-port k3d:6445",
                    "until kubectl get deployment coredns -n kube-system -o go-template='{{.status.availableReplicas}}' | grep -v -e '<no value>'; do sleep 1s; done",
                    "k3d kubeconfig get drone > kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
                    "chmod 0600 kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
                    "printf '@@@@@@@@@@@@@@@@@@@@@@@\n@@@@ k3d is ready @@@@\n@@@@@@@@@@@@@@@@@@@@@@@\n'",
                    "kubectl get events -Aw",
                ],
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/main",
                "refs/pull/**",
            ],
        },
    }

    return [pipeline]

def install(ctx):
    return [{
        "name": "helm-install",
        "image": "owncloudci/alpine:latest",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "helm install -f ci/ci-values.yaml --atomic --timeout 5m0s owncloud charts/owncloud/",
        ],
    }]

def documentation(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "documentation",
        "steps": [
            {
                "name": "helm-docs-readme",
                "image": "jnorwood/helm-docs:v1.11.0",
                "commands": [
                    "/usr/bin/helm-docs",
                    "--template-files=README.md.gotmpl",
                    "--output-file=README.md",
                ],
            },
            {
                "name": "helm-docs-values-table-adoc",
                "image": "jnorwood/helm-docs:v1.11.0",
                "commands": [
                    "/usr/bin/helm-docs",
                    "--template-files=charts/owncloud/docs/templates/values-desc-table.adoc.gotmpl",
                    "--output-file=docs/values-desc-table.adoc",
                ],
            },
            {
                "name": "helm-docs-kube-versions-adoc",
                "image": "jnorwood/helm-docs:v1.11.0",
                "commands": [
                    "/usr/bin/helm-docs",
                    "--template-files=charts/owncloud/docs/templates/kube-versions.adoc.gotmpl",
                    "--output-file=kube-versions.adoc",
                ],
            },
            {
                "name": "gomplate-values-adoc",
                "image": "hairyhenderson/gomplate:v3.10.0-alpine",
                "enviornment": {
                    "ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH": "go1.18",
                },
                "commands": [
                    "/bin/gomplate",
                    "--file=charts/owncloud/docs/templates/values.adoc.yaml.gotmpl",
                    "--out=charts/owncloud/docs/values.adoc.yaml",
                ],
            },
            {
                "name": "check-unchanged",
                "image": "owncloudci/alpine",
                "commands": [
                    "git diff --exit-code",
                ],
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/main",
                "refs/pull/**",
            ],
        },
    }]

def wait(config):
    return [{
        "name": "wait",
        "image": "bitnami/kubectl:1.25",
        "user": "root",
        "commands": [
            "export KUBECONFIG=kubeconfig-$${DRONE_BUILD_NUMBER}.yaml",
            "until test -f $${KUBECONFIG}; do sleep 1s; done",
            "kubectl config view",
            "kubectl get pods -A",
        ],
    }]
