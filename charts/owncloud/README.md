# owncloud

![Helm Version](https://img.shields.io/github/v/release/owncloud-docker/helm-charts?label=Version)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat)
![AppVersion: 10.11.0](https://img.shields.io/badge/AppVersion-10.11.0-informational?style=flat)

ownCloud Server Helm chart

**Homepage:** <https://owncloud.com/>

## Source Code

* <https://github.com/owncloud-docker/helm-charts>
* <https://github.com/owncloud-docker/server>
* <https://github.com/owncloud/core>

## Requirements

Kubernetes: `~1.21.0 || ~1.22.0 || ~1.23.0 || ~1.24.0 || ~1.25.0`

## Usage

### Get Repo Info

```Shell
helm repo add owncloud https://owncloud-docker.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

### Installing the Chart

To install the chart with the release name `my-release`:

```Shell
helm install my-release owncloud/owncloud
```

### Uninstalling the Chart

To uninstall/delete the my-release deployment:

```Shell
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

### Upgrading an existing Release to a new major version

A major chart version change (like v1.2.3 -> v2.0.0) indicates that there is an incompatible breaking change needing manual actions.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Node affinity selection constraint. |
| autoscaling.enabled | bool | `false` | Enables autoscaling. When set to `true`, `replicas` is no longer applied. |
| autoscaling.maxReplicas | int | `10` | Sets maximum replicas for autoscaling. |
| autoscaling.metrics | list | `[]` | Metrics to use for autoscaling. |
| autoscaling.minReplicas | int | `1` | Sets minimum replicas for autoscaling. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"docker.io/owncloud/server"` | Image repository |
| image.sha | string | `""` | Image sha/digest (optional). |
| image.tag | string | The `appVersion` of the Chart. | Image tag. |
| imagePullSecrets | object | `{}` | List of references to secrets in the same namespace to use for pulling images from a private registry. |
| ingress.annotations | object | `{}` | Ingress annotations. |
| ingress.enabled | bool | `false` | Enables the Ingress. |
| ingress.ingressClassName | string | `""` | Ingress class to use. Uses the default ingress class if not set. |
| ingress.labels | object | `{}` | Labels for the ingress. |
| ingress.tls | list | `[]` | Ingress TLS configuration. |
| initResources | object | `{}` | Resources to apply to all init containers. |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Simple node selection constraint. |
| owncloud.accesslogLocation | string | /dev/stdout | Location of the access log. |
| owncloud.accountsEnableMedialSearch | string | `""` | Allow medial search on user account properties (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#allow-medial-search-on-user-account-properties)). |
| owncloud.adminPassword | string | admin | ownCloud admin password. |
| owncloud.adminUsername | string | admin | ownCloud admin username. |
| owncloud.allowUserToChangeDisplayName | string | `""` | Allow or disallow users to change their display names (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#allow-or-disallow-users-to-change-their-display-names)). |
| owncloud.apps.deprecated | string | `""` | List of deprecated apps that must be removed (automatically) before performing an ownCloud upgrade to avoid upgrade issues. |
| owncloud.apps.disable | string | `""` | List of apps to disable on container startup. |
| owncloud.apps.enable | string | `{{ .Values.owncloud.apps.install }}` | List of apps to enable on container startup. |
| owncloud.apps.install | string | `""` | List of apps to install on container startup. |
| owncloud.apps.installMajor | string | false | By default ownCloud will not install a new major version of an already installed app. To enforce major updates for apps this option need to be set to `true`. |
| owncloud.apps.uninstall | string | `""` | List of apps to remove on container startup. |
| owncloud.appstoreEnabled | string | `""` |  |
| owncloud.backgroundMode | string | `"cron"` | Service to execute ownCloud backgrouns jobs. It is recommended to keep the default (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/background_jobs_configuration.html)). |
| owncloud.blacklistedFiles | string | `""` | Define blacklisted files (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-blacklisted-files)). |
| owncloud.cacheChunkGcTtl | string | `""` | Define the TTL for garbage collection (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-ttl-for-garbage-collection)). |
| owncloud.cachePath | string | `""` | Define the location of the cache folder (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-location-of-the-cache-folder)). |
| owncloud.checkForWorkingWellknownSetup | string | `""` | Check for a .well-known setup (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#check-for-a-well-known-setup)). |
| owncloud.cipher | string | `""` | Define the default cipher for encrypting files (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-default-cipher-for-encrypting-files)). |
| owncloud.commentsManagerFactory | string | `""` | Define an alternative Comments Manager (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-an-alternative-comments-manager)). |
| owncloud.configExtra | object | `{}` |  |
| owncloud.corsAllowedDomains | string | `""` | Define global list of CORS domains (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-global-list-of-cors-domains)). |
| owncloud.cronLog | string | `""` | Define logging if cron ran successfully(see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-logging-if-cron-ran-successfully)) |
| owncloud.crondEnabled | string | `"true"` | Enable or disable the system cron service. Required for `.Values.owncloud.backgroundMode: "cron"`. |
| owncloud.crondSchedule | string | `"*/1 * * * *"` | Cron schedule to run ownCloud background jobs. |
| owncloud.csrfDisabled | string | `""` | Enable or disable ownCloud’s built-in CSRF protection mechanism (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-ownclouds-built-in-csrf-protection-mechanism)). |
| owncloud.davChunkBaseDir | string | `""` | Define the DAV chunk base directory (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-dav-chunk-base-directory)). |
| owncloud.davEnableAsync | string | `""` | Enable or disable async DAV extensions (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-async-dav-extensions)). |
| owncloud.db.fail | string | `"true"` | Exit container if the database can't reached during the startup. |
| owncloud.db.host | string | `""` | Define the database server host name (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-database-server-host-name)). |
| owncloud.db.name | string | `"owncloud"` | Define the ownCloud database name (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-owncloud-database-name)). |
| owncloud.db.password | string | `""` | Define the password for the database user (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-password-for-the-database-user)). |
| owncloud.db.prefix | string | `"oc_"` | Define the prefix for the ownCloud tables in the database (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-prefix-for-the-owncloud-tables-in-the-database)). |
| owncloud.db.timeout | string | `"180"` | Time to wait for a successful connection to the database on container startup. |
| owncloud.db.type | string | `"sqlite"` | Identify the database used with this installation (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#identify-the-database-used-with-this-installation)). |
| owncloud.db.username | string | `""` | Define the ownCloud database user (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-owncloud-database-user)). |
| owncloud.debug | bool | `false` | Place this ownCloud instance into debugging mode (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#place-this-owncloud-instance-into-debugging-mode)). |
| owncloud.defaultApp | string | `""` | Define the default app to open on user login (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-default-app-to-open-on-user-login)). |
| owncloud.defaultLanguage | string | `"en"` | Define the default language of your ownCloud instance (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-default-language-of-your-owncloud-instance)). |
| owncloud.domain | string | `"owncloud.chart.example"` | Base domain used in `{{ .Values.owncloud.overwriteCliUrl }}` by default. |
| owncloud.enableAvatars | string | `""` | Enable or disable avatars or user profile photos (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-avatars-or-user-profile-photos)). |
| owncloud.enableCertificateManagement | string | `""` | Allow the configuration of system-wide trusted certificates (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#allow-the-configuration-of-system-wide-trusted-certificates)). |
| owncloud.enableOidcRewriteUrl | string | `"false"` | Rewrites OpenID Connect wellknown URL `.well-known/openid-configuration` to the ownCloud OIDC configuration endpoint (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/user/oidc/oidc.html#set-up-service-discovery)). |
| owncloud.enablePreviews | string | `""` | Enable preview generation (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-preview-generation)). |
| owncloud.enabledPreviewProviders | string | `""` | Define preview providers (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-preview-providers)). |
| owncloud.entrypointInitialized | string | `"true"` | Enable or disable loading of files from `/etc/entrypoint.d`. It is recommended to keep the default. |
| owncloud.errorlogLocation | string | `"/dev/stderr"` | Output location for the Apache error log. |
| owncloud.excludedDirectories | string | `""` | Define excluded directories (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-excluded-directories)). |
| owncloud.filelockingEnabled | string | `"true"` | Enable transactional file locking (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-transactional-file-locking)). |
| owncloud.filelockingTtl | string | `""` | Define the TTL for file locking (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-ttl-for-file-locking)). |
| owncloud.filesExternalAllowNewLocal | string | `""` | Enable or disable the files_external local mount option (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-the-files_external-local-mount-option)). |
| owncloud.filesystemCacheReadonly | string | `""` | Prevent cache changes due to changes in the filesystem (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#prevent-cache-changes-due-to-changes-in-the-filesystem)). |
| owncloud.filesystemCheckChanges | string | `""` | Define how often filesystem changes are detected (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-how-often-filesystem-changes-are-detected)). |
| owncloud.forwardedForHeaders | string | `""` | Define forwarded_for_headers (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-forwarded_for_headers)). |
| owncloud.hasInternetConnection | string | `""` | Check for an internet connection (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#check-for-an-internet-connection)). |
| owncloud.hashingCost | string | `""` | Define the hashing cost (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-hashing-cost)). |
| owncloud.htaccessRewriteBase | string | `{{ .Values.owncloud.subUrl }}` | Define clean URLs without /index.php (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-clean-urls-without-index-php)). |
| owncloud.httpCookieSamesite | string | `""` | Define how to relax same site cookie settings (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-how-to-relax-same-site-cookie-settings)). |
| owncloud.integrityExcludedFiles | string | `""` | Define files that are excluded from integrity checking (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-files-that-are-excluded-from-integrity-checking)). |
| owncloud.integrityIgnoreMissingAppSignature | string | `""` | Define apps or themes that are excluded from integrity checking (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-apps-or-themes-that-are-excluded-from-integrity-checking)). |
| owncloud.knowledgebaseEnabled | string | `""` |  |
| owncloud.licenseClass | string | `""` |  |
| owncloud.licenseKey | string | `""` | ownCloud Enterprise License Key (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/enterprise/installation/install.html#license-keys)). |
| owncloud.log.dateFormat | string | `""` | Define the log date format (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-log-date-format)). |
| owncloud.log.file | string | `{{ .Values.owncloud.volume.files }}/owncloud.log` | Define the log path (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-log-path)). |
| owncloud.log.level | string | `""` | Define the log level (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-log-level)). |
| owncloud.log.rotateSize | string | `""` | Define the maximum log rotation file size (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-log-rotation-file-size)). |
| owncloud.log.timezone | string | `""` | Define the log timezone (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-log-timezone)). |
| owncloud.loginAlternatives | string | `""` | Define additional login buttons on the logon screen (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-additional-login-buttons-on-the-logon-screen)). |
| owncloud.lostPasswordLink | string | `""` | Define a custom link to reset passwords (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-a-custom-link-to-reset-passwords)). |
| owncloud.mail.domain | string | `""` | Define the email RETURN address (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-email-return-address)). |
| owncloud.mail.fromAddress | string | `""` | Define the email FROM address (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-email-from-address)). |
| owncloud.mail.smtp.auth | string | `""` | Define the SMTP authentication (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-authentication)). |
| owncloud.mail.smtp.authType | string | `""` | Define the SMTP authentication type (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-authentication-type)). |
| owncloud.mail.smtp.debug | string | `""` | Enable or disable SMTP class debugging (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-smtp-class-debugging)). |
| owncloud.mail.smtp.host | string | `""` | Define the IP address of your mail server host (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-ip-address-of-your-mail-server-host)). |
| owncloud.mail.smtp.mode | string | `""` | Define the mode for sending an email (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-mode-for-sending-an-email)). |
| owncloud.mail.smtp.name | string | `""` | Define the SMTP authentication username (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-authentication-username)). |
| owncloud.mail.smtp.password | string | `""` | Define the SMTP authentication password (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-authentication-password)). |
| owncloud.mail.smtp.port | string | `""` | Define the port for sending an email (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-port-for-sending-an-email)). |
| owncloud.mail.smtp.secure | string | `""` | Define the SMTP security style (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-security-style)). |
| owncloud.mail.smtp.timeout | string | `""` | Define the SMTP server timeout (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-smtp-server-timeout)). |
| owncloud.maintenance | string | `""` | Enable maintenance mode to disable ownCloud (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-maintenance-mode-to-disable-owncloud)). |
| owncloud.marketplace.ca | string | `""` | Developer option to connect to Marketplace testing instances. |
| owncloud.marketplace.key | string | `""` | Developer option to get access to unreleased Apps in your Marketplace account. |
| owncloud.maxExecutionTime | string | `"3600"` | Sets PHP option `max_execution_time`. It is recommended to keep the default (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/big_file_upload_configuration.html#configuring-via-php-global-settings)). |
| owncloud.maxFilesizeAnimatedGifsPublicSharing | string | `""` | Define the maximum filesize for animated GIF´s (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-filesize-for-animated-gifs)). |
| owncloud.maxInputTime | string | `"3600"` | Sets PHP option `max_input_time`. It is recommended to keep the default (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/big_file_upload_configuration.html#configuring-via-php-global-settings)). |
| owncloud.maxUpload | string | `"20G"` | Sets PHP option `upload_max_filesize` and `post_max_size`. It is recommended to keep the default (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/big_file_upload_configuration.html#configuring-via-php-global-settings)). |
| owncloud.memcacheLocal | string | `"\\OC\\Memcache\\APCu"` | Memory caching backend for locally stored data (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#memory-caching-backend-for-locally-stored-data)). |
| owncloud.memcacheLocking | string | `""` | Define the memory caching backend for file locking (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-memory-caching-backend-for-file-locking)). |
| owncloud.memcachedEnabled | string | `"false"` | Enabled memory caching via memcached (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#memory-caching-backend-for-distributed-data)). |
| owncloud.memcachedHost | string | `"memcached"` | Defines the hosts for memcached (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-server-details-for-memcached-servers-to-use-for-memory-caching)). |
| owncloud.memcachedOptions | string | `""` | Define connection options for memcached (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-connection-options-for-memcached)). |
| owncloud.memcachedPort | string | `"11211"` | Defines the ports for memcached (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-server-details-for-memcached-servers-to-use-for-memory-caching)). |
| owncloud.memcachedStartupTimeout | string | `"180"` | Time to wait for a successful connection to the memcached service on container startup. |
| owncloud.minimumSupportedDesktopVersion | string | `""` | Define the minimum supported ownCloud desktop client version (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-minimum-supported-owncloud-desktop-client-version)). |
| owncloud.mountFile | string | `""` |  |
| owncloud.mysqlUtf8Mb4 | string | `""` | Define MySQL 3/4 byte character handling (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-mysql-34-byte-character-handling)). |
| owncloud.objectstore.bucket | string | `"owncloud"` | Bucket name to store data. |
| owncloud.objectstore.class | string | `"OCA\\Files_Primary_S3\\S3Storage"` | Class to use for the objectstore. It is recommended to keep the default (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.enabled | bool | `false` | Enabled or disables the objectstore configuration. |
| owncloud.objectstore.endpoint | string | `s3-{{ .Values.owncloud.objectstore.region }}.amazonaws.com` | Endpoint of the objectstore provider (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.key | string | `""` | Access key for the objectstore (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.pathstyle | string | `"false"` | Enabled or disables path style for the objectstore (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.region | string | `"us-east-1"` | Objectstore region to use (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.secret | string | `""` | Secret key for the objectstore (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.objectstore.version | string | `"2006-03-01"` | Objectstore version to use (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/files/external_storage/s3_compatible_object_storage_as_primary.html)). |
| owncloud.operationMode | string | `""` | Define ownCloud operation modes (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-owncloud-operation-modes)). |
| owncloud.overwriteCliUrl | string | `{{ .Values.owncloud.protocol }}://{{ .Values.owncloud.domain }}{{ .Values.owncloud.subUrl }}` | Override cli URL (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#override-cli-url)). |
| owncloud.overwriteCondAddr | string | `""` | Override condition for the remote IP address with a regular expression (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#override-condition-for-the-remote-ip-address-with-a-regular-expression)). |
| owncloud.overwriteHost | string | `""` | Override automatic proxy detection (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#override-automatic-proxy-detection)). |
| owncloud.overwriteProtocol | string | `""` | Override protocol (http/https) usage (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#override-protocol-httphttps-usage)). |
| owncloud.overwriteWebroot | string | `""` | Override ownClouds webroot (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#override-ownclouds-webroot)). |
| owncloud.partFileInStorage | string | `""` | Define where part files are located (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-where-part-files-are-located)). |
| owncloud.postCronjobPath | string | `"/etc/post_cronjob.d"` | Path to custom scripts that need to be executed after a cron run. |
| owncloud.postInstallPath | string | `"/etc/post_install.d"` | Path to custom scripts that need to be executed after an ownCoud installation command. |
| owncloud.postServerPath | string | `"/etc/post_server.d"` | Path to custom scripts that need to be executed after an ownCloud server startup. |
| owncloud.preCronjobPath | string | `"/etc/pre_cronjob.d"` | Path to custom scripts that need to be executed before a cron run. |
| owncloud.preInstallPath | string | `"/etc/pre_install.d"` | Path to custom scripts that need to be executed before an ownCoud installation command. |
| owncloud.preServerPath | string | `"/etc/pre_server.d"` | Path to custom scripts that need to be executed before an ownCloud server startup. |
| owncloud.preview.libreofficePath | string | `""` | Define the custom path for the LibreOffice / OpenOffice binary (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-custom-path-for-the-libreoffice-openoffice-binary)). |
| owncloud.preview.maxFilesizeImage | string | `""` | Define the maximum preview filesize limit (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-preview-filesize-limit)). |
| owncloud.preview.maxScaleFactor | string | `""` | Define the maximum preview scale factor (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-preview-scale-factor)). |
| owncloud.preview.maxX | string | `""` | Define the maximum x-axis width for previews (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-x-axis-width-for-previews)). |
| owncloud.preview.maxY | string | `""` | Define the maximum y-axis width for previews (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-maximum-y-axis-width-for-previews)). |
| owncloud.preview.officeClParameters | string | `""` | Define additional arguments for LibreOffice / OpenOffice (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-additional-arguments-for-libreoffice-openoffice)). |
| owncloud.protocol | string | http | Protocol used in `{{ .Values.owncloud.overwriteCliUrl }}` by default. |
| owncloud.proxy | string | `""` | Define the URL of your proxy server (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-url-of-your-proxy-server)). |
| owncloud.proxyUserpwd | string | `""` | Define proxy authentication (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-proxy-authentication)). |
| owncloud.quotaIncludeExternalStorage | string | `""` | Define whether to include external storage in quota calculation (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-whether-to-include-external-storage-in-quota-calculation)). |
| owncloud.redis.db | string | `""` | Define Redis connection details sets the dbindex (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-connection-details)). |
| owncloud.redis.enabled | bool | `false` | Sets memcache to Redis (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#memory-caching-backend-for-distributed-data)). |
| owncloud.redis.failoverMode | string | `""` | Sets redis failover mode (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-cluster-connection-details)). |
| owncloud.redis.host | string | `"redis"` | Sets redis host (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-connection-details)). |
| owncloud.redis.password | string | `""` | Set redis password (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-connection-details)). |
| owncloud.redis.port | string | `"6379"` | Set redis port (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-connection-details)). |
| owncloud.redis.readTimeout | string | `""` | Sets redis read timeout (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-cluster-connection-details)). |
| owncloud.redis.seeds | string | `""` | Sets the redis cluster servers (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-cluster-connection-details)). |
| owncloud.redis.sessionLockRetries | string | `"750"` | Sets PHP option `redis.session.lock_retries` if `owncloud.session.saveHandler=redis`. |
| owncloud.redis.sessionLockWaitTime | string | `"20000"` | Sets PHP option `redis.session.lock_wait_time` if `owncloud.session.saveHandler=redis`. |
| owncloud.redis.sessionLockingEnabled | string | `"1"` | Sets PHP option `redis.session.locking_enabled` if `owncloud.session.saveHandler=redis`. |
| owncloud.redis.startupTimeout | string | `"180"` | Time to wait for a successful connection to the redis service on container startup. |
| owncloud.redis.timeout | string | `""` | Sets the redis timeout value (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-redis-cluster-connection-details)). |
| owncloud.rememberLoginCookieLifetime | string | `""` | Define the lifetime of the remember-login cookie (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-lifetime-of-the-remember-login-cookie)). |
| owncloud.secret | string | `""` | Define ownClouds internal secret (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-ownclouds-internal-secret)). |
| owncloud.session.forcedLogoutTimeout | string | `""` | Force the user to get logged out after the specified number of seconds when the tab or browser gets closed. Please read the documentation carefully before changing this option. (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-to-force-user-logout)). |
| owncloud.session.keepalive | string | `""` | Enable or disable session keep-alive when a user is logged in to the Web UI (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-session-keep-alive-when-a-user-is-logged-in-to-the-web-ui)). |
| owncloud.session.lifetime | string | `""` | Define the lifetime of a session after inactivity (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-lifetime-of-a-session-after-inactivity)). |
| owncloud.session.saveHandler | string | `"files"` | Sets PHP option `session.save_handler`. |
| owncloud.session.savePath | string | `{{ .Values.owncloud.volume.sessions }}` | Sets PHP option `session.save_path`. Only used if `owncloud.session.saveHandler=file`. |
| owncloud.shareFolder | string | `""` | Define a default folder for shared files and folders other than root (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-a-default-folder-for-shared-files-and-folders-other-than-root)). |
| owncloud.sharingFederationAllowHttpFallback | string | `""` | Allow schema fallback for federated sharing servers (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#allow-schema-fallback-for-federated-sharing-servers)). |
| owncloud.sharingManagerFactory | string | `""` | Define an alternative Share Provider (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-an-alternative-share-provider)). |
| owncloud.showServerHostname | string | `""` | Show or hide the server hostname in status.php (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#show-or-hide-the-server-hostname-in-status-php)). |
| owncloud.singleuser | string | `""` | Enable or disable single user mode (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-single-user-mode)). |
| owncloud.skeletonDirectory | string | `""` | Define the directory where the skeleton files are located (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-directory-where-the-skeleton-files-are-located)). |
| owncloud.skipChmod | string | `"true"` | Enable or disable automatic file permissions correction on container startup. |
| owncloud.skipChown | string | `"true"` | Enable or disable automatic file ownership correction on container startup. |
| owncloud.smbLoggingEnable | string | `""` | Enable or disable debug logging for SMB access (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-debug-logging-for-smb-access)). |
| owncloud.sqliteJournalMode | string | `""` | Define sqlite3 journal mode (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-sqlite3-journal-mode)). |
| owncloud.subUrl | string | `"/"` | URL path if ownCloud is deployed to a URL sub-path of a domain. |
| owncloud.systemtagsManagerFactory | string | `""` | Define an alternative System Tags Manager (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-an-alternative-system-tags-manager)). |
| owncloud.tempDirectory | string | `""` | Define the location for temporary files (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-location-for-temporary-files)). |
| owncloud.tokenAuthEnforced | string | `""` | Enforce token only authentication for apps and clients connecting to ownCloud (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enforce-token-only-authentication-for-apps-and-clients-connecting-to-owncloud)). |
| owncloud.trashbin.purgeLimit | string | `""` | Define the trashbin purge limit (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-trashbin-purge-limit)). |
| owncloud.trashbin.retentionObligation | string | `""` | Define the trashbin retention obligation (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-trashbin-retention-obligation)). |
| owncloud.trustedDomains | list | `["localhost"]` | List of trusted domains to prevent host header poisoning (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-list-of-trusted-domains-that-users-can-log-into)). The value from `{{ .Values.owncloud.overwriteCliUrl }}` is added to the list automatically. |
| owncloud.trustedProxies | string | `""` | Define list of trusted proxy servers (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-list-of-trusted-proxy-servers)). |
| owncloud.updateChecker | string | `""` | Enable or disable updatechecker (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#enable-or-disable-updatechecker)). |
| owncloud.updaterServerUrl | string | `""` | Define the updatechecker URL (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-updatechecker-url)). |
| owncloud.upgradeAutomaticAppUpdates | string | `""` | Define whether or not to enable automatic update of market apps (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-whether-or-not-to-enable-automatic-update-of-market-apps)). |
| owncloud.userSearchMinLength | string | `""` | Define minimum characters entered before a search returns results (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-minimum-characters-entered-before-a-search-returns-results)). |
| owncloud.versionHide | string | `""` | Show or hide the ownCloud version information in status.php (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#show-or-hide-the-owncloud-version-information-in-status-php)). |
| owncloud.versionsRetentionObligation | string | `""` | Define the files versions retention obligation (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-files-versions-retention-obligation)). |
| owncloud.volume.apps | string | `{{ .Values.owncloud.volume.root }}/apps` | Base directory used to store custom installed apps. |
| owncloud.volume.config | string | `{{ .Values.owncloud.volume.root }}/config` | Base directory used to store the ownCloud configuration. |
| owncloud.volume.files | string | `{{ .Values.owncloud.volume.root }}/files` | Define the directory where user files are stored (see [documentation](https://doc.owncloud.com/server/latest/admin_manual/configuration/server/config_sample_php_parameters.html#define-the-directory-where-user-files-are-stored)). |
| owncloud.volume.root | string | `"/mnt/data"` | Base data directory for ownCloud. |
| owncloud.volume.sessions | string | `{{ .Values.owncloud.volume.root }}/sessions` | Base directory to store session files. Only used if `OWNCLOUD_SESSION_SAVE_HANDLER=file`. |
| persistence.enabled | bool | `true` | Enables persistence. |
| persistence.owncloud.accessMode[0] | string | `"ReadWriteOnce"` |  |
| persistence.owncloud.nfs | object | `{}` |  |
| persistence.owncloud.size | string | `"20Gi"` |  |
| persistence.owncloud.storageClassName | string | `""` | owncloud data Persistent Volume Storage Class. If defined, `storageClassName` of the PVC is set to the value defined here. If set to "-", `storageClassName`of the PVC is set to `""`, which disables dynamic provisioning. If undefined (the default) or set to null, no `storageClassName` spec is set, choosing the default provisioner. |
| podAnnotations | object | `{}` | Annotations to attach metadata to the Pod. |
| podSecurityContext | object | `{}` | Security settings for the Pod. |
| replicas | int | `1` | Number of replicas for each scalable service. Has no effect when `autoscaling.enabled` is set to `true`. |
| resources | object | `{}` | Resources to apply to all services. |
| securityContext | object | `{"readOnlyRootFilesystem":false}` | Security settings for the Container. |
| securityContext.readOnlyRootFilesystem | bool | `false` | Mounts the container's root filesystem as read-only. Currently only `false` is supported by ownCloud 10. |
| service.port | int | `8080` |  |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created or not. |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and `create` is set to `true`, a name is generated using the fullname template. |
| tolerations | list | `[]` | Tolerations are applied to pods and allow the scheduler to schedule pods with matching taints. One or more taints need to be applied to a node to instruct this node to not accept any pods that do not tolerate the taints. |

## Examples

### Configure OpenID Connect

To configure OpenID Connect the configExtra object can be used.

```YAML
configExtra:
  openid-connect:
    auto-provision:
      enabled: true
      email-claim: "email"
      display-name-claim: "given_name"
      picture-claim: "picture"
    provider-url: "https://example.com"
    client-id: "myclientid"
    client-secret: "mysecret"
    autoRedirectOnLoginPage: false
    mode: "email"
    scopes: []
    use-access-token-payload-for-user-info: false
```
