{{/*
# -------------------------------------------------------------------------------------
#
# Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 LLC. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained 
# herein is strictly forbidden, unless permitted by WSO2 in accordance with the 
# WSO2 Commercial License available at https://wso2.com/licenses/eula/3.2
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
Combines a rendered deployment.toml with wso2.apim.configurations.extraConfigs.
A table in extraConfigs that the chart already renders (for example [secrets] when secure vault is enabled,
or [server]) is not appended as a second table, which would make the server fail to start. Its keys are
added to the end of the existing table instead. Rendering fails if such a key is already set in that table.
Tables the chart does not render, arrays of tables ([[...]]) and keys before the first table header are
appended at the end, as before. Without extraConfigs the rendered file is returned unchanged.
*/}}
{{- define "apim.toml.withExtraConfigs" -}}
{{- $toml := .toml -}}
{{- $extra := .extra | default "" | toString -}}
{{- if not $extra -}}
{{- $toml -}}
{{- else -}}
{{- $headerRe := "^\\s*\\[\\[?[^\\[\\]]+\\]\\]?\\s*(#.*)?$" -}}
{{- $keyRe := "^\\s*([^=\\s#\\[][^=]*?)\\s*=" -}}
{{- /* tables (not arrays of tables) that the rendered chart defines */ -}}
{{- $chartTables := dict -}}
{{- range $line := splitList "\n" $toml -}}
{{- if and (regexMatch $headerRe $line) (not (hasPrefix "[[" (trim $line))) -}}
{{- $_ := set $chartTables (regexFind "\\[[^\\]]+\\]" $line | trimAll "[]" | trim) true -}}
{{- end -}}
{{- end -}}
{{- /* split extraConfigs into sections; those for chart tables are merged, the rest are kept in order */ -}}
{{- $merge := dict -}}
{{- $rest := list -}}
{{- $target := "" -}}
{{- range $line := splitList "\n" $extra -}}
{{- if regexMatch $headerRe $line -}}
{{- $name := regexFind "\\[[^\\]]+\\]" $line | trimAll "[]" | trim -}}
{{- if and (not (hasPrefix "[[" (trim $line))) (hasKey $chartTables $name) -}}
{{- $target = $name -}}
{{- if not (hasKey $merge $name) -}}{{- $_ := set $merge $name (list) -}}{{- end -}}
{{- else -}}
{{- $target = "" -}}
{{- $rest = append $rest $line -}}
{{- end -}}
{{- else if $target -}}
{{- $_ := set $merge $target (append (get $merge $target) $line) -}}
{{- else -}}
{{- $rest = append $rest $line -}}
{{- end -}}
{{- end -}}
{{- if not $merge -}}
{{- $toml -}}{{- $extra -}}{{- "\n" -}}
{{- else -}}
{{- /* insert merged keys at the end of each existing table, checking for keys the chart already sets */ -}}
{{- $out := list -}}
{{- $current := "" -}}
{{- $keys := dict -}}
{{- $lines := splitList "\n" $toml -}}
{{- range $i, $line := $lines -}}
{{- $isHeader := regexMatch $headerRe $line -}}
{{- if or $isHeader (eq (add1 $i) (len $lines)) -}}
{{- if eq (add1 $i) (len $lines) -}}{{- if not $isHeader -}}{{- $out = append $out $line -}}{{- end -}}{{- end -}}
{{- if hasKey $merge $current -}}
{{- $body := list -}}
{{- range $l := get $merge $current -}}
{{- $k := regexReplaceAll "\\s*=$" (regexFind $keyRe $l) "" | trim -}}
{{- if and $k (hasKey $keys $k) -}}
{{- fail (printf "wso2.apim.configurations.extraConfigs: [%s] %s is already set by the chart. Remove it from extraConfigs or set it through the chart value." $current $k) -}}
{{- end -}}
{{- if trim $l -}}{{- $body = append $body $l -}}{{- end -}}
{{- end -}}
{{- /* keep the table's trailing blank lines after the inserted keys */ -}}
{{- $blanks := 0 -}}
{{- range $n := until (len $out) -}}
{{- if and (gt (len $out) 0) (eq (trim (last $out)) "") (eq $blanks $n) -}}
{{- $out = initial $out -}}{{- $blanks = add1 $blanks -}}
{{- end -}}
{{- end -}}
{{- range $l := $body -}}{{- $out = append $out $l -}}{{- end -}}
{{- range $n := until (int $blanks) -}}{{- $out = append $out "" -}}{{- end -}}
{{- $_ := unset $merge $current -}}
{{- end -}}
{{- if $isHeader -}}
{{- $out = append $out $line -}}
{{- $current = ternary "" (regexFind "\\[[^\\]]+\\]" $line | trimAll "[]" | trim) (hasPrefix "[[" (trim $line)) -}}
{{- $keys = dict -}}
{{- end -}}
{{- else -}}
{{- $out = append $out $line -}}
{{- $k := regexReplaceAll "\\s*=$" (regexFind $keyRe $line) "" | trim -}}
{{- if $k -}}{{- $_ := set $keys $k true -}}{{- end -}}
{{- end -}}
{{- end -}}
{{- join "\n" $out -}}
{{- $restText := join "\n" $rest | trim -}}
{{- if $restText -}}{{- join "\n" $rest -}}{{- "\n" -}}{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}
