{{/* PIMS hostname */}}
{{- define "pims.hostname" -}}
{{- .Values.global.imsDomainName | default (printf "ims.%s" .Values.global.domainName )    }}
{{- end }}


{{/* PIMS url */}}
{{- define "pims.url" -}}
{{- printf "https://%s" (include "pims.hostname" .) }}
{{- end }}

{{/* URL Upload hostname */}}
{{- define "upload.hostname" -}}
{{- .Values.global.urlUpload | default (printf "upload.%s" .Values.global.domainName )    }}
{{- end }}

{{/* URL Upload url */}}
{{- define "upload.url" -}}
{{- printf "https://%s" (include "upload.hostname" .) }}
{{- end }}

{{/* Core hostname */}}
{{- define "core.hostname" -}}
{{- .Values.global.urlCore | default (printf "%s" .Values.global.domainName )    }}
{{- end }}

{{/* Core url */}}
{{- define "core.url" -}}
{{- printf "https://%s/server" (include "pims.hostname" .) }}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "cytomine.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this
(by the DNS naming spec). If release name contains chart name it will be used as
a full name.
*/}}
{{- define "cytomine.fullname" -}}
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
Common labels
*/}}
{{- define "cytomine.labels" -}}
{{ include "cytomine.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cytomine.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cytomine.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cytomine.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cytomine.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Simple function that returns 'http' or 'https' depending on wheather
.Values.global.use_tls is `true` or `false`
*/}}
{{- define "cytomine.protocol" -}}
{{ if .Values.global.use_tls | default false }}
{{- printf "https" }}
{{- else }}
{{- printf "http" }}
{{- end }}
{{- end }}

