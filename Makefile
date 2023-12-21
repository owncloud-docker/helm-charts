# renovate: datasource=github-releases depName=norwoodj/helm-docs
HELM_DOCS_PACKAGE_VERSION := v1.12.0
KUBE_LINTER_PACKAGE_VERSION := latest
KUBECONFORM_PACKAGE_VERSION := latest

SHELL := bash
DIST := dist
GO ?= go

HELM_DOCS_PACKAGE ?= github.com/norwoodj/helm-docs/cmd/helm-docs@$(HELM_DOCS_PACKAGE_VERSION)
KUBE_LINTER_PACKAGE ?= golang.stackrox.io/kube-linter/cmd/kube-linter@$(KUBE_LINTER_PACKAGE_VERSION)
KUBECONFORM_PACKAGE ?= github.com/yannh/kubeconform/cmd/kubeconform@$(KUBECONFORM_PACKAGE_VERSION)

all: docs lint api clean

.PHONY: docs
docs:
	$(GO) run $(HELM_DOCS_PACKAGE) --badge-style=flat --template-files ci/README.md.gotmpl --output-file=README.md

.PHONY: ci-template
ci-template:
	helm template charts/owncloud -f ci/ci-values.yaml > ci/owncloud-ci-templated.yaml

.PHONY: clean
clean:
	rm -rf ci/owncloud-ci-templated.yaml
	rm -rf $(DIST)

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

.PHONY: package
package:
	cr package charts/owncloud/
