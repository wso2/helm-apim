{{/*
# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# --------------------------------------------------------------------------------------s
*/}}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "am-all-in-one.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "am-all-in-one.fullname" -}}
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
{{- define "am-all-in-one.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "am-all-in-one.labels" -}}
app.kubernetes.io/name: {{ include "am-all-in-one.name" . }}
helm.sh/chart: {{ include "am-all-in-one.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common prefix prepended to Kubernetes resources of this chart
*/}}
{{- define "am-all-in-one.resource.prefix" -}}
{{- "wso2am-all-in-one" }}
{{- end -}}

{{- define "image" }}
{{- $imageName := .deployment.imageName }}
{{- $imageTag := .deployment.imageTag | default "" }}
{{- if or (eq .Values.wso2.subscription.username "") (eq .Values.wso2.subscription.password "") -}}
{{- $dockerRegistry := .deployment.dockerRegistry | default "wso2" }}
image: {{ $dockerRegistry }}/{{ $imageName }}{{- if not (eq $imageTag "") }}{{- printf ":%s" $imageTag -}}{{- end }}
{{- else }}
{{- $dockerRegistry := .deployment.dockerRegistry | default "docker.wso2.com" }}
{{- $parts := len (split "." $imageTag) }}
{{- if eq $parts 3 }}
image: {{ $dockerRegistry }}/{{ $imageName }}{{- if not (eq $imageTag "") }}:{{ $imageTag }}.0{{- end }}
{{- else }}
image: {{ $dockerRegistry }}/{{ $imageName }}{{- if not (eq $imageTag "") }}:{{ $imageTag }}{{- end }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Check if all the governance.scheduler configuration values are empty.
*/}}
{{- define "scheduler.isEmpty" -}}
{{- $scheduler := .Values.wso2.apim.configurations.governance.scheduler -}}
{{- and 
    (empty $scheduler.thread_pool_size)
    (empty $scheduler.queue_size)
    (empty $scheduler.task_check_interval_minutes)
    (empty $scheduler.task_cleanup_interval_minutes)
-}}
{{- end -}}

{{- define "dockerconfigjson" -}}
{{- $auth := printf "%s:%s" .Values.wso2.deployment.image.imagePullSecrets.username .Values.wso2.deployment.image.imagePullSecrets.password | b64enc -}}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .Values.wso2.deployment.image.registry .Values.wso2.deployment.image.imagePullSecrets.username .Values.wso2.deployment.image.imagePullSecrets.password $auth | b64enc -}}
{{- end -}}

{{/*
Internal client authentication credentials (client app "dashboard") used by the authenticationendpoint and
accountrecoveryendpoint web apps. Renders the [identity.auth_framework.endpoint] and [account_recovery.endpoint.auth]
deployment.toml tables when custom credentials are configured, so that the default credentials are not used
(WSO2-2023-2617). The application password and its SHA-256 hash must always be changed together.
*/}}
{{- define "apim.clientAuth.config" -}}
{{- $conf := .Values.wso2.apim.configurations }}
{{- $clientAuth := $conf.security.clientAuth | default dict }}
{{- $existingSecret := $conf.existingSecret | default dict }}
{{- $passwordFromSecret := and $existingSecret.secretName $existingSecret.appPasswordKey }}
{{- $hashFromSecret := and $existingSecret.secretName $existingSecret.appPasswordHashKey }}
{{- $password := "" }}
{{- $plainPassword := false }}
{{- if and .Values.wso2.apim.secureVaultEnabled $clientAuth.appPassword }}
{{- $password = "$secret{app_password}" }}
{{- else if $passwordFromSecret }}
{{- $password = "$env{WSO2_APP_PASSWORD}" }}
{{- else if $clientAuth.appPassword }}
{{- $password = $clientAuth.appPassword }}
{{- $plainPassword = true }}
{{- end }}
{{- $hash := "" }}
{{- if $clientAuth.appPasswordHash }}
{{- $hash = lower $clientAuth.appPasswordHash }}
{{- if and $plainPassword (ne $hash (sha256sum $clientAuth.appPassword)) }}
{{- fail "wso2.apim.configurations.security.clientAuth.appPasswordHash must be the SHA-256 hash of clientAuth.appPassword. Remove appPasswordHash to derive it automatically." }}
{{- end }}
{{- else if $hashFromSecret }}
{{- $hash = "$env{WSO2_APP_PASSWORD_HASH}" }}
{{- else if $plainPassword }}
{{- $hash = sha256sum $clientAuth.appPassword }}
{{- end }}
{{- if and $password (not $hash) }}
{{- fail "The SHA-256 hash of the client authentication app password cannot be derived when the password is read from secure vault or existingSecret. Set wso2.apim.configurations.security.clientAuth.appPasswordHash or wso2.apim.configurations.existingSecret.appPasswordHashKey." }}
{{- end }}
{{- if and $hash (not $password) }}
{{- fail "wso2.apim.configurations.security.clientAuth.appPasswordHash is set without an app password. Set wso2.apim.configurations.security.clientAuth.appPassword or wso2.apim.configurations.existingSecret.appPasswordKey." }}
{{- end }}
{{- if and $password $conf.extraConfigs (regexMatch "(?m)^\\s*\\[(identity\\.auth_framework\\.endpoint|account_recovery\\.endpoint\\.auth)\\]" $conf.extraConfigs) }}
{{- fail "wso2.apim.configurations.extraConfigs must not define [identity.auth_framework.endpoint] or [account_recovery.endpoint.auth] when client authentication credentials are configured through wso2.apim.configurations.security.clientAuth or existingSecret." }}
{{- end }}
{{- if $password }}
[identity.auth_framework.endpoint]
app_password = {{ $password | quote }}

[account_recovery.endpoint.auth]
hash = {{ $hash | quote }}
{{- end }}
{{- end -}}
