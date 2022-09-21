# ownCloud: Helm Charts

[![Build Status](https://img.shields.io/drone/build/owncloud-docker/helm?logo=drone&server=https%3A%2F%2Fdrone.owncloud.com)](https://drone.owncloud.com/owncloud-docker/helm)
[![GitHub contributors](https://img.shields.io/github/contributors/owncloud-docker/helm)](https://github.com/owncloud-docker/helm/graphs/contributors)
[![Source: GitHub](https://img.shields.io/badge/source-github-blue.svg?logo=github&logoColor=white)](https://github.com/owncloud-docker/helm)
[![License: MIT](https://img.shields.io/github/license/owncloud-docker/helm)](https://github.com/owncloud-docker/helm/blob/master/LICENSE)

The code is provided as-is with no warranties.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

This chart repository and it's charts are still in an experimental phase, and it has not yet been published.
For instructions on how to run it anyways the the respective chart's readme.

[//]: # "Once Helm is set up properly, add the repo as follows:"
[//]: # "```console"
[//]: # "helm repo add ocis https://owncloud.dev/ocis/helm-charts"
[//]: # "```"
[//]: # "You can then run `helm search repo ocis` to see the charts."

Chart documentation is available in [oCIS directory](https://github.com/owncloud/ocis-charts/blob/master/charts/ocis/README.md).

## Values

| Key                                        | Type   | Default                       | Description |
| ------------------------------------------ | ------ | ----------------------------- | ----------- |
| affinity                                   | object | `{}`                          |             |
| autoscaling.enabled                        | bool   | `false`                       |             |
| autoscaling.maxReplicas                    | int    | `100`                         |             |
| autoscaling.minReplicas                    | int    | `1`                           |             |
| autoscaling.targetCPUUtilizationPercentage | int    | `80`                          |             |
| externalDatabase.host                      | string | `""`                          |             |
| externalDatabase.name                      | string | `"owncloud"`                  |             |
| externalDatabase.password                  | string | `"owncloud"`                  |             |
| externalDatabase.port                      | int    | `3306`                        |             |
| externalDatabase.type                      | string | `""`                          |             |
| externalDatabase.user                      | string | `"owncloud"`                  |             |
| fullnameOverride                           | string | `""`                          |             |
| image.pullPolicy                           | string | `"IfNotPresent"`              |             |
| image.repository                           | string | `"docker.io/owncloud/server"` |             |
| image.tag                                  | float  | `10.6`                        |             |
| imagePullSecrets                           | list   | `[]`                          |             |
| ingress.annotations                        | string | `nil`                         |             |
| ingress.enabled                            | bool   | `true`                        |             |
| ingress.hosts[0].host                      | string | `"owncloud.chart.example"`    |             |
| ingress.hosts[0].paths[0]                  | string | `"/*"`                        |             |
| ingress.hosts[0].servicePort               | int    | `80`                          |             |
| ingress.tls[0].hosts[0]                    | string | `"owncloud.chart.example"`    |             |
| ingress.tls[0].secretName                  | string | `"owncloud"`                  |             |
| mariadb.enabled                            | bool   | `false`                       |             |
| nameOverride                               | string | `""`                          |             |
| nodeSelector                               | object | `{}`                          |             |
| owncloud.domain                            | string | `"owncloud.chart.example"`    |             |
| owncloud.password                          | string | `"owncloud"`                  |             |
| owncloud.username                          | string | `"owncloud"`                  |             |
| persistence.enabled                        | bool   | `true`                        |             |
| persistence.owncloud.accessMode            | string | `"ReadWriteOnce"`             |             |
| persistence.owncloud.nfs                   | string | `nil`                         |             |
| persistence.owncloud.size                  | string | `"8Gi"`                       |             |
| podAnnotations                             | object | `{}`                          |             |
| podSecurityContext                         | object | `{}`                          |             |
| redis.enabled                              | bool   | `false`                       |             |
| replicaCount                               | int    | `1`                           |             |
| resources                                  | object | `{}`                          |             |
| securityContext                            | object | `{}`                          |             |
| service.port                               | int    | `80`                          |             |
| service.type                               | string | `"LoadBalancer"`              |             |
| serviceAccount.annotations                 | object | `{}`                          |             |
| serviceAccount.create                      | bool   | `true`                        |             |
| serviceAccount.name                        | string | `""`                          |             |
| tolerations                                | list   | `[]`                          |             |

---

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-docker/helm/blob/master/LICENSE) file for details.

## Copyright

```Text
Copyright (c) 2022 ownCloud GmbH
```
