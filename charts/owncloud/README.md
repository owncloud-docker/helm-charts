# owncloud

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat) ![AppVersion: 10.11.0](https://img.shields.io/badge/AppVersion-10.11.0-informational?style=flat)

ownCloud Server Helm chart
**Homepage:** <https://owncloud.com/>
## Source Code

* <https://github.com/owncloud-docker/helm-charts>
* <https://github.com/owncloud-docker/server>
* <https://github.com/owncloud/core>
## Requirements

Kubernetes: `~1.21.0 || ~1.22.0 || ~1.23.0 || ~1.24.0 || ~1.25.0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Node affinity selection constraint. |
| autoscaling.enabled | bool | `false` | Enables autoscaling. When set to `true`, `replicas` is no longer applied. |
| autoscaling.maxReplicas | int | `10` | Sets maximum replicas for autoscaling. |
| autoscaling.metrics | list | `[]` | Metrics to use for autoscaling. |
| autoscaling.minReplicas | int | `1` | Sets minimum replicas for autoscaling. |
| externalDatabase.host | string | `""` |  |
| externalDatabase.name | string | `"owncloud"` |  |
| externalDatabase.password | string | `"owncloud"` |  |
| externalDatabase.port | int | `3306` |  |
| externalDatabase.type | string | `""` |  |
| externalDatabase.user | string | `"owncloud"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"docker.io/owncloud/server"` | Image repository |
| image.sha | string | `""` | Image sha/digest (optional). |
| image.tag | string | The `appVersion` of the Chart. | Image tag. |
| imagePullSecrets | object | `{}` | List of references to secrets in the same namespace to use for pulling images from a priavte registry. |
| ingress.annotations | object | `{}` | Ingress annotations. |
| ingress.enabled | bool | `false` | Enables the Ingress. |
| ingress.ingressClassName | string | `""` | Ingress class to use. Uses the default ingress class if not set. |
| ingress.labels | object | `{}` | Labels for the ingress. |
| ingress.tls | list | `[]` | Ingress TLS configuration. |
| initResources | object | `{}` | Resources to apply to all init containers. |
| mariadb.enabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Simple node selection constraint. |
| owncloud.configExtra | object | `{}` |  |
| owncloud.domain | string | `"owncloud.chart.example"` |  |
| owncloud.password | string | `"owncloud"` |  |
| owncloud.username | string | `"owncloud"` |  |
| owncloud.volume_apps | string | `"/mnt/data/apps"` |  |
| owncloud.volume_config | string | `"/mnt/data/config"` |  |
| owncloud.volume_files | string | `"/mnt/data/files"` |  |
| owncloud.volume_root | string | `"/mnt/data"` |  |
| persistence.enabled | bool | `true` | Enables persistence. |
| persistence.owncloud.accessMode[0] | string | `"ReadWriteOnce"` |  |
| persistence.owncloud.nfs | object | `{}` |  |
| persistence.owncloud.size | string | `"20Gi"` |  |
| podAnnotations | object | `{}` | Annotations to attach metadata to the Pod. |
| podSecurityContext | object | `{}` | Security settings for the Pod. |
| redis.enabled | bool | `false` |  |
| replicas | int | `1` | Number of replicas for each scalable service. Has no effect when `autoscaling.enabled` is set to `true`. |
| resources | object | `{}` | Resources to apply to all services. |
| securityContext | object | `{"readOnlyRootFilesystem":false}` | Security settings for the Container. |
| securityContext.readOnlyRootFilesystem | bool | `false` | Mounts the container's root filesystem as read-only. Currently only `false` is supported by ownCloud. |
| service.port | int | `8080` |  |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created or not. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and `create` is set to `true`, a name is generated using the fullname template. |
| tolerations | list | `[]` | Tolerations are applied to pods and allow the scheduler to schedule pods with matching taints. One or more taints need to be applied to a node to instruct this node to not accept any pods that do not tolerate the taints. |
