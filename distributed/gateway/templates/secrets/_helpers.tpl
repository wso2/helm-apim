{{/*
# -------------------------------------------------------------------------------------
#
# Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

{{- define "dockerconfigjson" -}}
{{- $auth := printf "%s:%s" .Values.wso2.deployment.image.imagePullSecrets.username .Values.wso2.deployment.image.imagePullSecrets.password | b64enc -}}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .Values.wso2.deployment.image.registry .Values.wso2.deployment.image.imagePullSecrets.username .Values.wso2.deployment.image.imagePullSecrets.password $auth | b64enc -}}
{{- end -}}
