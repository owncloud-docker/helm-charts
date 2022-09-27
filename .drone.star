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
    pipeline_release = release(ctx)

    pipeline_docs = documentation(ctx)
    pipeline_docs[0]["depends_on"].append(pipeline_starlark[0]["name"])

    pipeline_kubernetes = kubernetes(ctx, config)
    pipeline_kubernetes[0]["depends_on"].append(pipeline_docs[0]["name"])

    pipeline_deployments = deployments(ctx)
    for pipeline in pipeline_deployments:
        pipeline["depends_on"].append(pipeline_kubernetes[0]["name"])
        pipeline_release[0]["depends_on"].append(pipeline["name"])

    return pipeline_starlark + pipeline_docs + pipeline_kubernetes + pipeline_deployments + pipeline_release

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
                "refs/tags/**",
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
                "image": "owncloudci/alpine",
                "commands": [
                    "helm lint --strict charts/owncloud",
                ],
            },
            {
                "name": "helm-template",
                "image": "owncloudci/alpine",
                "commands": [
                    "helm template charts/owncloud -f ci/ci-values.yaml > ci/owncloud-ci-templated.yaml",
                ],
                "depends_on": ["helm-lint"],
            },
            {
                "name": "kube-lint",
                "image": "stackrox/kube-linter",
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
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }

    for version in config["kubernetes_versions"]:
        pipeline["steps"].append(
            {
                "name": "kubeconform-%s" % version,
                "image": "ghcr.io/yannh/kubeconform",
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
    return [{
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
                    "k3d cluster create --config ci/k3d-drone.yaml --api-port k3d:6445",
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
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def install(ctx):
    return [{
        "name": "helm-install",
        "image": "owncloudci/alpine",
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
                "image": "jnorwood/helm-docs",
                "commands": [
                    "/usr/bin/helm-docs --badge-style=flat --template-files=ci/README.md.gotmpl --output-file=README.md",
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
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }]

def release(ctx):
    return [{
        "kind": "pipeline",
        "type": "docker",
        "name": "release",
        "steps": [
            {
                "name": "changelog",
                "image": "thegeeklab/git-chglog",
                "commands": [
                    "git fetch -tq",
                    "git-chglog --no-color --no-emoji %s" % (ctx.build.ref.replace("refs/tags/", "") if ctx.build.event == "tag" else "--next-tag unreleased unreleased"),
                    "git-chglog --no-color --no-emoji -o charts/owncloud/CHANGELOG.md %s" % (ctx.build.ref.replace("refs/tags/", "") if ctx.build.event == "tag" else "--next-tag unreleased unreleased"),
                ],
            },
            {
                "name": "helmpack-package",
                "image": "quay.io/helmpack/chart-releaser",
                "commands": [
                    "sed -i 's/version: 0.0.0-devel/version: %s/g' charts/owncloud/Chart.yaml" % (ctx.build.ref.replace("refs/tags/", "").replace("v", "") if ctx.build.event == "tag" else "0.0.0-devel"),
                    "cr package charts/owncloud/",
                ],
            },
            {
                "name": "helmpack-upload",
                "image": "quay.io/helmpack/chart-releaser",
                "environment": {
                    "CR_TOKEN": {
                        "from_secret": "github_token",
                    },
                },
                "commands": [
                    "cr upload charts/owncloud/",
                ],
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
            {
                "name": "helmpack-index",
                "image": "quay.io/helmpack/chart-releaser",
                "commands": [
                    "mkdir -p dist/docs/",
                    "cp README.md dist/docs/README.md",
                    "cr index",
                ],
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
            {
                "name": "pages",
                "image": "plugins/gh-pages",
                "settings": {
                    "pages_directory": "dist/docs/",
                    "password": {
                        "from_secret": "github_token",
                    },
                    "target_branch": "gh_pages",
                    "username": {
                        "from_secret": "github_username",
                    },
                },
                "when": {
                    "ref": [
                        "refs/tags/**",
                    ],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/main",
                "refs/tags/**",
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
