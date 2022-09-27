# renovate: datasource=github-releases depName=norwoodj/helm-docs
HELM_DOCS_PACKAGE_VERSION := v1.10.0
# renovate: datasource=github-releases depName=/stackrox/kube-linter
KUBE_LINTER_PACKAGE_VERSION := v0.4.0
# renovate: datasource=github-releases depName=yannh/kubeconform
KUBECONFORM_PACKAGE_VERSION := v0.4.13


SHELL := bash

GO ?= go
CWD ?= $(shell pwd)

HELM_DOCS_PACKAGE ?= github.com/norwoodj/helm-docs/cmd/helm-docs@$(HELM_DOCS_PACKAGE_VERSION)
KUBE_LINTER_PACKAGE ?= golang.stackrox.io/kube-linter/cmd/kube-linter@$(KUBE_LINTER_PACKAGE_VERSION)
KUBECONFORM_PACKAGE ?= github.com/yannh/kubeconform/cmd/kubeconform@$(KUBECONFORM_PACKAGE_VERSION)

all: docs lint api clean

.PHONY: docs
docs:
	$(GO) run $(HELM_DOCS_PACKAGE) --badge-style=flat --template-files=README.md.gotmpl --output-file=README.md

.PHONY: ci-template
ci-template:
	helm template charts/owncloud -f ci/ci-values.yaml > ci/owncloud-ci-templated.yaml

.PHONY: clean
clean:
	@rm ci/owncloud-ci-templated.yaml

.PHONY: lint
lint: ci-template
	helm lint charts/owncloud
	$(GO) run $(KUBE_LINTER_PACKAGE) lint ci/owncloud-ci-templated.yaml

.PHONY: api
api: ci-template
	$(GO) run $(KUBECONFORM_PACKAGE) -kubernetes-version 1.21.0 -summary -strict ci/owncloud-ci-templated.yaml
	$(GO) run $(KUBECONFORM_PACKAGE) -kubernetes-version 1.22.0 -summary -strict ci/owncloud-ci-templated.yaml
	$(GO) run $(KUBECONFORM_PACKAGE) -kubernetes-version 1.23.0 -summary -strict ci/owncloud-ci-templated.yaml
	$(GO) run $(KUBECONFORM_PACKAGE) -kubernetes-version 1.24.0 -summary -strict ci/owncloud-ci-templated.yaml
