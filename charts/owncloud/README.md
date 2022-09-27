# owncloud

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat) ![AppVersion: 10.11.0](https://img.shields.io/badge/AppVersion-10.11.0-informational?style=flat)

ownCloud Server Helm chart

## Source Code

* <https://github.com/owncloud-docker/helm>
* <https://github.com/owncloud-docker/server>
* <https://github.com/owncloud/core>
## Requirements

Kubernetes: `~1.21.0 || ~1.22.0 || ~1.23.0 || ~1.24.0 || ~1.25.0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| externalDatabase.host | string | `""` |  |
| externalDatabase.name | string | `"owncloud"` |  |
| externalDatabase.password | string | `"owncloud"` |  |
| externalDatabase.port | int | `3306` |  |
| externalDatabase.type | string | `""` |  |
| externalDatabase.user | string | `"owncloud"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/owncloud/server"` |  |
| image.tag | string | `"10.11.0"` |  |
| imagePullSecrets | object | `{}` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"owncloud.chart.example"` |  |
| ingress.hosts[0].paths[0] | string | `"/*"` |  |
| ingress.hosts[0].servicePort | int | `80` |  |
| ingress.tls[0].hosts[0] | string | `"owncloud.chart.example"` |  |
| ingress.tls[0].secretName | string | `"owncloud"` |  |
| initResources | object | `{}` |  |
| mariadb.enabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| owncloud.configExtra | object | `{}` |  |
| owncloud.domain | string | `"owncloud.chart.example"` |  |
| owncloud.password | string | `"owncloud"` |  |
| owncloud.username | string | `"owncloud"` |  |
| owncloud.volume_apps | string | `"/mnt/data/apps"` |  |
| owncloud.volume_config | string | `"/mnt/data/config"` |  |
| owncloud.volume_files | string | `"/mnt/data/files"` |  |
| owncloud.volume_root | string | `"/mnt/data"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.owncloud.accessMode[0] | string | `"ReadWriteOnce"` |  |
| persistence.owncloud.nfs | object | `{}` |  |
| persistence.owncloud.size | string | `"20Gi"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| redis.enabled | bool | `false` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.port | int | `80` |  |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
