{{/*
Expand the name of the chart.
*/}}
{{- define "owncloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "owncloud.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "owncloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
ownCloud trusted domains list.
*/}}
{{- define "owncloud.trustedDomains" -}}
{{- $domains := list -}}
{{- with .Values.owncloud.domain -}}
{{- $domains = append $domains . -}}
{{- end -}}
{{- with .Values.owncloud.trustedDomains -}}
{{- $domains = concat $domains . -}}
{{- end -}}
{{- $domains | join "," }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "owncloud.labels" -}}
helm.sh/chart: {{ include "owncloud.chart" . }}
{{ include "owncloud.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "owncloud.selectorLabels" -}}
app.kubernetes.io/name: {{ include "owncloud.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "owncloud.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "owncloud.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ownCloud image logic
*/}}
{{- define "owncloud.image" -}}
  {{- $tag := default .Chart.AppVersion .Values.image.tag -}}
  {{- if $.Values.image.sha -}}
"{{ $.Values.image.repository }}:{{ $tag }}@sha256:{{ $.Values.image.sha }}"
  {{- else -}}
"{{ $.Values.image.repository }}:{{ $tag }}"
  {{- end -}}
{{- end -}}

{{/*
ownCloud environment settings
*/}}
{{- define "owncloud.environment" -}}
- name: OWNCLOUD_ACCESSLOG_LOCATION
  value: {{ .Values.owncloud.accesslogLocation | quote }}
- name: OWNCLOUD_ACCOUNTS_ENABLE_MEDIAL_SEARCH
  value: {{ .Values.owncloud.accountsEnableMedialSearch | quote }}
- name: OWNCLOUD_ADMIN_PASSWORD
  value: {{ .Values.owncloud.adminPassword | quote }}
- name: OWNCLOUD_ADMIN_USERNAME
  value: {{ .Values.owncloud.adminUsername | quote }}
- name: OWNCLOUD_ALLOW_USER_TO_CHANGE_DISPLAY_NAME
  value: {{ .Values.owncloud.allowUserToChangeDisplayName | quote }}
- name: OWNCLOUD_APPS_DEPRECATED
  value: {{ .Values.owncloud.apps.deprecated | quote }}
- name: OWNCLOUD_APPS_DISABLE
  value: {{ .Values.owncloud.apps.disable | quote }}
- name: OWNCLOUD_APPS_ENABLE
  value: {{ .Values.owncloud.apps.enable | quote }}
- name: OWNCLOUD_APPS_INSTALL
  value: {{ .Values.owncloud.apps.install | quote }}
- name: OWNCLOUD_APPS_INSTALL_MAJOR
  value: {{ .Values.owncloud.apps.installMajor | quote }}
- name: OWNCLOUD_APPS_UNINSTALL
  value: {{ .Values.owncloud.apps.uninstall | quote }}
- name: OWNCLOUD_BACKGROUND_MODE
  value: {{ .Values.owncloud.backgroundMode | quote }}
- name: OWNCLOUD_BLACKLISTED_FILES
  value: {{ .Values.owncloud.blacklistedFiles | quote }}
- name: OWNCLOUD_CACHE_CHUNK_GC_TTL
  value: {{ .Values.owncloud.cacheChunkGcTtl | quote }}
- name: OWNCLOUD_CACHE_PATH
  value: {{ .Values.owncloud.cachePath | quote }}
- name: OWNCLOUD_CHECK_FOR_WORKING_WELLKNOWN_SETUP
  value: {{ .Values.owncloud.checkForWorkingWellknownSetup | quote }}
- name: OWNCLOUD_CIPHER
  value: {{ .Values.owncloud.cipher | quote }}
- name: OWNCLOUD_COMMENTS_MANAGER_FACTORY
  value: {{ .Values.owncloud.commentsManagerFactory | quote }}
- name: OWNCLOUD_CORS_ALLOWED_DOMAINS
  value: {{ .Values.owncloud.corsAllowedDomains | quote }}
- name: OWNCLOUD_CROND_ENABLED
  value: "false" # Disable ownCloud container's cronJob in Kubernetes in favor of Kubernetes' own CronJob
- name: OWNCLOUD_CSRF_DISABLED
  value: {{ .Values.owncloud.csrfDisabled | quote }}
- name: OWNCLOUD_DAV_CHUNK_BASE_DIR
  value: {{ .Values.owncloud.davChunkBaseDir | quote }}
- name: OWNCLOUD_DAV_ENABLE_ASYNC
  value: {{ .Values.owncloud.davEnableAsync | quote }}
- name: OWNCLOUD_DB_FAIL
  value: {{ .Values.owncloud.db.fail | quote }}
- name: OWNCLOUD_DB_HOST
  value: {{ .Values.owncloud.db.host | quote }}
- name: OWNCLOUD_DB_NAME
  value: {{ .Values.owncloud.db.name | quote }}
- name: OWNCLOUD_DB_PASSWORD
  value: {{ .Values.owncloud.db.password | quote }}
- name: OWNCLOUD_DB_PREFIX
  value: {{ .Values.owncloud.db.prefix | quote }}
- name: OWNCLOUD_DB_TIMEOUT
  value: {{ .Values.owncloud.db.timeout | quote }}
- name: OWNCLOUD_DB_TYPE
  value: {{ .Values.owncloud.db.type | quote }}
- name: OWNCLOUD_DB_USERNAME
  value: {{ .Values.owncloud.db.username | quote }}
- name: OWNCLOUD_DEBUG
  value: {{ .Values.owncloud.debug | quote }}
- name: OWNCLOUD_DEFAULT_APP
  value: {{ .Values.owncloud.defaultApp | quote }}
- name: OWNCLOUD_DEFAULT_LANGUAGE
  value: {{ .Values.owncloud.defaultLanguage | quote }}
- name: OWNCLOUD_DOMAIN
  value: {{ .Values.owncloud.domain | quote }}
- name: OWNCLOUD_TRUSTED_DOMAINS
  value: {{ include "owncloud.trustedDomains" . }}
- name: OWNCLOUD_ENABLED_PREVIEW_PROVIDERS
  value: {{ .Values.owncloud.enabledPreviewProviders | quote }}
- name: OWNCLOUD_ENABLE_AVATARS
  value: {{ .Values.owncloud.enableAvatars | quote }}
- name: OWNCLOUD_ENABLE_CERTIFICATE_MANAGEMENT
  value: {{ .Values.owncloud.enableCertificateManagement | quote }}
- name: OWNCLOUD_ENABLE_PREVIEWS
  value: {{ .Values.owncloud.enablePreviews | quote }}
- name: OWNCLOUD_ENABLE_OIDC_REWRITE_URL
  value: {{ .Values.owncloud.enableOidcRewriteUrl | quote }}
- name: OWNCLOUD_ENTRYPOINT_INITIALIZED
  value: {{ .Values.owncloud.entrypointInitialized | quote }}
- name: OWNCLOUD_ERRORLOG_LOCATION
  value: {{ .Values.owncloud.errorlogLocation | quote }}
- name: OWNCLOUD_EXCLUDED_DIRECTORIES
  value: {{ .Values.owncloud.excludedDirectories | quote }}
- name: OWNCLOUD_FILELOCKING_ENABLED
  value: {{ .Values.owncloud.filelockingEnabled | quote }}
- name: OWNCLOUD_FILELOCKING_TTL
  value: {{ .Values.owncloud.filelockingTtl | quote }}
- name: OWNCLOUD_FILESYSTEM_CACHE_READONLY
  value: {{ .Values.owncloud.filesystemCacheReadonly | quote }}
- name: OWNCLOUD_FILESYSTEM_CHECK_CHANGES
  value: {{ .Values.owncloud.filesystemCheckChanges | quote }}
- name: OWNCLOUD_FILES_EXTERNAL_ALLOW_NEW_LOCAL
  value: {{ .Values.owncloud.filesExternalAllowNewLocal | quote }}
- name: OWNCLOUD_FORWARDED_FOR_HEADERS
  value: {{ .Values.owncloud.forwardedForHeaders | quote }}
- name: OWNCLOUD_HASHING_COST
  value: {{ .Values.owncloud.hashingCost | quote }}
- name: OWNCLOUD_HAS_INTERNET_CONNECTION
  value: {{ .Values.owncloud.hasInternetConnection | quote }}
- name: OWNCLOUD_HTACCESS_REWRITE_BASE
  value: {{ .Values.owncloud.htaccessRewriteBase | quote }}
- name: OWNCLOUD_HTTP_COOKIE_SAMESITE
  value: {{ .Values.owncloud.httpCookieSamesite | quote }}
- name: OWNCLOUD_INTEGRITY_EXCLUDED_FILES
  value: {{ .Values.owncloud.integrityExcludedFiles | quote }}
- name: OWNCLOUD_INTEGRITY_IGNORE_MISSING_APP_SIGNATURE
  value: {{ .Values.owncloud.integrityIgnoreMissingAppSignature | quote }}
- name: OWNCLOUD_KNOWLEDGEBASE_ENABLED
  value: {{ .Values.owncloud.knowledgebaseEnabled | quote }}
- name: OWNCLOUD_APPSTORE_ENABLED
  value: {{ .Values.owncloud.appstoreEnabled | quote }}
- name: OWNCLOUD_LICENSE_KEY
  value: {{ .Values.owncloud.licenseKey | quote }}
- name: OWNCLOUD_LICENSE_CLASS
  value: {{ .Values.owncloud.licenseClass | quote }}
- name: OWNCLOUD_LOGIN_ALTERNATIVES
  value: {{ .Values.owncloud.loginAlternatives | quote }}
- name: OWNCLOUD_LOG_DATE_FORMAT
  value: {{ .Values.owncloud.log.dateFormat | quote }}
- name: OWNCLOUD_LOG_FILE
  value: {{ .Values.owncloud.log.file | quote }}
- name: OWNCLOUD_LOG_LEVEL
  value: {{ .Values.owncloud.log.level | quote }}
- name: OWNCLOUD_LOG_ROTATE_SIZE
  value: {{ .Values.owncloud.log.rotateSize | quote }}
- name: OWNCLOUD_LOG_TIMEZONE
  value: {{ .Values.owncloud.log.timezone | quote }}
- name: OWNCLOUD_LOST_PASSWORD_LINK
  value: {{ .Values.owncloud.lostPasswordLink | quote }}
- name: OWNCLOUD_MAIL_DOMAIN
  value: {{ .Values.owncloud.mail.domain | quote }}
- name: OWNCLOUD_MAIL_FROM_ADDRESS
  value: {{ .Values.owncloud.mail.fromAddress | quote }}
- name: OWNCLOUD_MAIL_SMTP_AUTH
  value: {{ .Values.owncloud.mail.smtp.auth | quote }}
- name: OWNCLOUD_MAIL_SMTP_AUTH_TYPE
  value: {{ .Values.owncloud.mail.smtp.authType | quote }}
- name: OWNCLOUD_MAIL_SMTP_DEBUG
  value: {{ .Values.owncloud.mail.smtp.debug | quote }}
- name: OWNCLOUD_MAIL_SMTP_HOST
  value: {{ .Values.owncloud.mail.smtp.host | quote }}
- name: OWNCLOUD_MAIL_SMTP_MODE
  value: {{ .Values.owncloud.mail.smtp.mode | quote }}
- name: OWNCLOUD_MAIL_SMTP_NAME
  value: {{ .Values.owncloud.mail.smtp.name | quote }}
- name: OWNCLOUD_MAIL_SMTP_PASSWORD
  value: {{ .Values.owncloud.mail.smtp.password | quote }}
- name: OWNCLOUD_MAIL_SMTP_PORT
  value: {{ .Values.owncloud.mail.smtp.port | quote }}
- name: OWNCLOUD_MAIL_SMTP_SECURE
  value: {{ .Values.owncloud.mail.smtp.secure | quote }}
- name: OWNCLOUD_MAIL_SMTP_TIMEOUT
  value: {{ .Values.owncloud.mail.smtp.timeout | quote }}
- name: OWNCLOUD_MAINTENANCE
  value: {{ .Values.owncloud.maintenance | quote }}
- name: OWNCLOUD_MARKETPLACE_CA
  value: {{ .Values.owncloud.marketplace.ca | quote }}
- name: OWNCLOUD_MARKETPLACE_KEY
  value: {{ .Values.owncloud.marketplace.key | quote }}
- name: OWNCLOUD_MAX_EXECUTION_TIME
  value: {{ .Values.owncloud.maxExecutionTime | quote }}
- name: OWNCLOUD_MAX_FILESIZE_ANIMATED_GIFS_PUBLIC_SHARING
  value: {{ .Values.owncloud.maxFilesizeAnimatedGifsPublicSharing | quote }}
- name: OWNCLOUD_MAX_INPUT_TIME
  value: {{ .Values.owncloud.maxInputTime | quote }}
- name: OWNCLOUD_MAX_UPLOAD
  value: {{ .Values.owncloud.maxUpload | quote }}
- name: OWNCLOUD_MEMCACHED_ENABLED
  value: {{ .Values.owncloud.memcachedEnabled | quote }}
- name: OWNCLOUD_MEMCACHED_HOST
  value: {{ .Values.owncloud.memcachedHost | quote }}
- name: OWNCLOUD_MEMCACHED_OPTIONS
  value: {{ .Values.owncloud.memcachedOptions | quote }}
- name: OWNCLOUD_MEMCACHED_PORT
  value: {{ .Values.owncloud.memcachedPort | quote }}
- name: OWNCLOUD_MEMCACHED_STARTUP_TIMEOUT
  value: {{ .Values.owncloud.memcachedStartupTimeout | quote }}
- name: OWNCLOUD_MEMCACHE_LOCAL
  value: {{ .Values.owncloud.memcacheLocal | quote }}
- name: OWNCLOUD_MEMCACHE_LOCKING
  value: {{ .Values.owncloud.memcacheLocking | quote }}
- name: OWNCLOUD_MINIMUM_SUPPORTED_DESKTOP_VERSION
  value: {{ .Values.owncloud.minimumSupportedDesktopVersion | quote }}
- name: OWNCLOUD_MOUNT_FILE
  value: {{ .Values.owncloud.mountFile | quote }}
- name: OWNCLOUD_MYSQL_UTF8MB4
  value: {{ .Values.owncloud.mysqlUtf8Mb4 | quote }}
{{- if .Values.owncloud.objectstore.enabled }}
- name: OWNCLOUD_OBJECTSTORE_BUCKET
  value: {{ .Values.owncloud.objectstore.bucket | quote }}
- name: OWNCLOUD_OBJECTSTORE_CLASS
  value: {{ .Values.owncloud.objectstore.class | quote }}
- name: OWNCLOUD_OBJECTSTORE_ENABLED
  value: {{ .Values.owncloud.objectstore.enabled | quote }}
- name: OWNCLOUD_OBJECTSTORE_ENDPOINT
  value: {{ .Values.owncloud.objectstore.endpoint | quote }}
- name: OWNCLOUD_OBJECTSTORE_KEY
  value: {{ .Values.owncloud.objectstore.key | quote }}
- name: OWNCLOUD_OBJECTSTORE_PATHSTYLE
  value: {{ .Values.owncloud.objectstore.pathstyle | quote }}
- name: OWNCLOUD_OBJECTSTORE_REGION
  value: {{ .Values.owncloud.objectstore.region | quote }}
- name: OWNCLOUD_OBJECTSTORE_SECRET
  value: {{ .Values.owncloud.objectstore.secret | quote }}
- name: OWNCLOUD_OBJECTSTORE_VERSION
  value: {{ .Values.owncloud.objectstore.version | quote }}
{{- end }}
- name: OWNCLOUD_OPERATION_MODE
  value: {{ .Values.owncloud.operationMode | quote }}
- name: OWNCLOUD_OVERWRITE_CLI_URL
  value: {{ .Values.owncloud.overwriteCliUrl | quote }}
- name: OWNCLOUD_OVERWRITE_COND_ADDR
  value: {{ .Values.owncloud.overwriteCondAddr | quote }}
- name: OWNCLOUD_OVERWRITE_HOST
  value: {{ .Values.owncloud.overwriteHost | quote }}
- name: OWNCLOUD_OVERWRITE_PROTOCOL
  value: {{ .Values.owncloud.overwriteProtocol | quote }}
- name: OWNCLOUD_OVERWRITE_WEBROOT
  value: {{ .Values.owncloud.overwriteWebroot | quote }}
- name: OWNCLOUD_PART_FILE_IN_STORAGE
  value: {{ .Values.owncloud.partFileInStorage | quote }}
- name: OWNCLOUD_POST_CRONJOB_PATH
  value: {{ .Values.owncloud.postCronjobPath | quote }}
- name: OWNCLOUD_POST_INSTALL_PATH
  value: {{ .Values.owncloud.postInstallPath | quote }}
- name: OWNCLOUD_POST_SERVER_PATH
  value: {{ .Values.owncloud.postServerPath | quote }}
- name: OWNCLOUD_PREVIEW_LIBREOFFICE_PATH
  value: {{ .Values.owncloud.preview.libreofficePath | quote }}
- name: OWNCLOUD_PREVIEW_MAX_FILESIZE_IMAGE
  value: {{ .Values.owncloud.preview.maxFilesizeImage | quote }}
- name: OWNCLOUD_PREVIEW_MAX_SCALE_FACTOR
  value: {{ .Values.owncloud.preview.maxScaleFactor | quote }}
- name: OWNCLOUD_PREVIEW_MAX_X
  value: {{ .Values.owncloud.preview.maxX | quote }}
- name: OWNCLOUD_PREVIEW_MAX_Y
  value: {{ .Values.owncloud.preview.maxY | quote }}
- name: OWNCLOUD_PREVIEW_OFFICE_CL_PARAMETERS
  value: {{ .Values.owncloud.preview.officeClParameters | quote }}
- name: OWNCLOUD_PRE_CRONJOB_PATH
  value: {{ .Values.owncloud.preCronjobPath | quote }}
- name: OWNCLOUD_PRE_INSTALL_PATH
  value: {{ .Values.owncloud.preInstallPath | quote }}
- name: OWNCLOUD_PRE_SERVER_PATH
  value: {{ .Values.owncloud.preServerPath | quote }}
- name: OWNCLOUD_PROTOCOL
  value: {{ .Values.owncloud.protocol | quote }}
- name: OWNCLOUD_PROXY
  value: {{ .Values.owncloud.proxy | quote }}
- name: OWNCLOUD_PROXY_USERPWD
  value: {{ .Values.owncloud.proxyUserpwd | quote }}
- name: OWNCLOUD_QUOTA_INCLUDE_EXTERNAL_STORAGE
  value: {{ .Values.owncloud.quotaIncludeExternalStorage | quote }}
{{- if .Values.owncloud.redis.enabled }}
- name: OWNCLOUD_REDIS_DB
  value: {{ .Values.owncloud.redis.db | quote }}
- name: OWNCLOUD_REDIS_ENABLED
  value: "true"
- name: OWNCLOUD_REDIS_FAILOVER_MODE
  value: {{ .Values.owncloud.redis.failoverMode | quote }}
- name: OWNCLOUD_REDIS_HOST
  value: {{ .Values.owncloud.redis.host | quote }}
- name: OWNCLOUD_REDIS_PASSWORD
  value: {{ .Values.owncloud.redis.password | quote }}
{{- end }}
- name: OWNCLOUD_REDIS_PORT
  value: {{ .Values.owncloud.redis.port | quote }}
- name: OWNCLOUD_REDIS_READ_TIMEOUT
  value: {{ .Values.owncloud.redis.readTimeout | quote }}
- name: OWNCLOUD_REDIS_SEEDS
  value: {{ .Values.owncloud.redis.seeds | quote }}
- name: OWNCLOUD_REDIS_SESSION_LOCKING_ENABLED
  value: {{ .Values.owncloud.redis.sessionLockingEnabled | quote }}
- name: OWNCLOUD_REDIS_SESSION_LOCK_RETRIES
  value: {{ .Values.owncloud.redis.sessionLockRetries | quote }}
- name: OWNCLOUD_REDIS_SESSION_LOCK_WAIT_TIME
  value: {{ .Values.owncloud.redis.sessionLockWaitTime | quote }}
- name: OWNCLOUD_REDIS_STARTUP_TIMEOUT
  value: {{ .Values.owncloud.redis.startupTimeout | quote }}
- name: OWNCLOUD_REDIS_TIMEOUT
  value: {{ .Values.owncloud.redis.timeout | quote }}
- name: OWNCLOUD_REMEMBER_LOGIN_COOKIE_LIFETIME
  value: {{ .Values.owncloud.rememberLoginCookieLifetime | quote }}
- name: OWNCLOUD_SECRET
  value: {{ .Values.owncloud.secret | quote }}
- name: OWNCLOUD_SESSION_KEEPALIVE
  value: {{ .Values.owncloud.session.keepalive | quote }}
- name: OWNCLOUD_SESSION_LIFETIME
  value: {{ .Values.owncloud.session.lifetime | quote }}
- name: OWNCLOUD_SESSION_FORCED_LOGOUT_TIMEOUT
  value: {{ .Values.owncloud.session.forcedLogoutTimeout | quote }}
- name: OWNCLOUD_SESSION_SAVE_HANDLER
  value: {{ .Values.owncloud.session.saveHandler | quote }}
- name: OWNCLOUD_SESSION_SAVE_PATH
  value: {{ .Values.owncloud.session.savePath | quote }}
- name: OWNCLOUD_SHARE_FOLDER
  value: {{ .Values.owncloud.shareFolder | quote }}
- name: OWNCLOUD_SHARING_FEDERATION_ALLOW_HTTP_FALLBACK
  value: {{ .Values.owncloud.sharingFederationAllowHttpFallback | quote }}
- name: OWNCLOUD_SHARING_MANAGER_FACTORY
  value: {{ .Values.owncloud.sharingManagerFactory | quote }}
- name: OWNCLOUD_SHOW_SERVER_HOSTNAME
  value: {{ .Values.owncloud.showServerHostname | quote }}
- name: OWNCLOUD_SINGLEUSER
  value: {{ .Values.owncloud.singleuser | quote }}
- name: OWNCLOUD_SKELETON_DIRECTORY
  value: {{ .Values.owncloud.skeletonDirectory | quote }}
- name: OWNCLOUD_SKIP_CHMOD
  value: {{ .Values.owncloud.skipChmod | quote }}
- name: OWNCLOUD_SKIP_CHOWN
  value: "true"
- name: OWNCLOUD_SMB_LOGGING_ENABLE
  value: {{ .Values.owncloud.smbLoggingEnable | quote }}
- name: OWNCLOUD_SQLITE_JOURNAL_MODE
  value: {{ .Values.owncloud.sqliteJournalMode | quote }}
- name: OWNCLOUD_SUB_URL
  value: {{ .Values.owncloud.subUrl | quote }}
- name: OWNCLOUD_SYSTEMTAGS_MANAGER_FACTORY
  value: {{ .Values.owncloud.systemtagsManagerFactory | quote }}
- name: OWNCLOUD_TEMP_DIRECTORY
  value: {{ .Values.owncloud.tempDirectory | quote }}
- name: OWNCLOUD_TOKEN_AUTH_ENFORCED
  value: {{ .Values.owncloud.tokenAuthEnforced | quote }}
- name: OWNCLOUD_TRASHBIN_PURGE_LIMIT
  value: {{ .Values.owncloud.trashbin.purgeLimit | quote }}
- name: OWNCLOUD_TRASHBIN_RETENTION_OBLIGATION
  value: {{ .Values.owncloud.trashbin.retentionObligation | quote }}
- name: OWNCLOUD_TRUSTED_PROXIES
  value: {{ .Values.owncloud.trustedProxies | quote }}
- name: OWNCLOUD_UPDATER_SERVER_URL
  value: {{ .Values.owncloud.updaterServerUrl | quote }}
- name: OWNCLOUD_UPDATE_CHECKER
  value: {{ .Values.owncloud.updateChecker | quote }}
- name: OWNCLOUD_UPGRADE_AUTOMATIC_APP_UPDATES
  value: {{ .Values.owncloud.upgradeAutomaticAppUpdates | quote }}
- name: OWNCLOUD_USER_SEARCH_MIN_LENGTH
  value: {{ .Values.owncloud.userSearchMinLength | quote }}
- name: OWNCLOUD_VERSIONS_RETENTION_OBLIGATION
  value: {{ .Values.owncloud.versionsRetentionObligation | quote }}
- name: OWNCLOUD_VERSION_HIDE
  value: {{ .Values.owncloud.versionHide | quote }}
- name: OWNCLOUD_VOLUME_APPS
  value: {{ .Values.owncloud.volumeApps | quote }}
- name: OWNCLOUD_VOLUME_CONFIG
  value: {{ .Values.owncloud.volumeConfig | quote }}
- name: OWNCLOUD_VOLUME_FILES
  value: {{ .Values.owncloud.volumeFiles | quote }}
- name: OWNCLOUD_VOLUME_ROOT
  value: {{ .Values.owncloud.volumeRoot | quote }}
- name: OWNCLOUD_VOLUME_SESSIONS
  value: {{ .Values.owncloud.volumeSessions | quote }}
{{- end -}}
