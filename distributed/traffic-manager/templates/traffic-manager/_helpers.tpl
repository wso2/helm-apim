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
{{- define "apim-helm-tm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apim-helm-tm.fullname" -}}
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
{{- define "apim-helm-tm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apim-helm-tm.labels" -}}
app.kubernetes.io/name: {{ include "apim-helm-tm.name" . }}
helm.sh/chart: {{ include "apim-helm-tm.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Common prefix prepended to Kubernetes resources of this chart
*/}}
{{- define "apim-helm-tm.resource.prefix" -}}
{{- if eq .Values.kubernetes.resourceSuffix "${RESOURCE_SUFFIX}" }}
{{- "wso2am-gw" }}
{{- else }}
{{- "wso2am-gw-" }}{{ .Values.kubernetes.resourceSuffix }}
{{- end -}}
{{- end -}}

{{/*
Common prefix prepended to Kubernetes resources of CP chart
*/}}
{{- define "apim-helm-cp.resource.prefix" -}}
{{- "wso2am-cp" }}
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
