{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- define "zato.postgresql.fullname" -}}
{{- .Values.postgresql.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "zato.redis.fullname" -}}
{{- .Values.redis.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "zato.zatoscheduler.fullname" -}}
{{- .Values.zatoscheduler.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "zato.zatobootstrap.fullname" -}}
{{- .Values.zatobootstrap.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "zato.zatowebadmin.fullname" -}}
{{- .Values.zatowebadmin.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "zato.zatoserver.fullname" -}}
{{- .Values.zatoserver.fullname | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "helm.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "zato.postgresql.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "zato.redis.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.redis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "zato.zatoscheduler.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.zatoscheduler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{- define "zato.zatobootstrap.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.zatobootstrap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "zato.zatowebadmin.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.zatowebadmin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "zato.zatoserver.labels" -}}
helm.sh/chart: {{ include "helm.chart" . }}
{{ include "zato.zatoserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.postgresql.selectorLabels" -}}
app: {{ include "zato.postgresql.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.redis.selectorLabels" -}}
app: {{ include "zato.redis.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.zatoscheduler.selectorLabels" -}}
app: {{ include "zato.zatoscheduler.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.zatobootstrap.selectorLabels" -}}
app: {{ include "zato.zatobootstrap.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.zatowebadmin.selectorLabels" -}}
app: {{ include "zato.zatowebadmin.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "zato.zatoserver.selectorLabels" -}}
app: {{ include "zato.zatoserver.fullname" . }}
app.kubernetes.io/name: {{ include "helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "zato.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "helm.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "zato.variables" -}}
- name: LB_HOSTNAME
  value: "{{ .Values.zatoserver.fullname }}.{{ .Release.Namespace }}.svc.cluster.local"
- name: LB_PORT
  value: {{ default 80 .Values.lb_port | quote }}
- name: LB_AGENT_PORT
  value: {{ default 20151 .Values.lb_agent_port | quote }}
- name: CLUSTER_NAME
  value: {{ default "zato" .Values.cluster_name | quote  }}
- name: REDIS_HOSTNAME
  value: "{{ .Values.redis.fullname }}.{{ .Release.Namespace }}.svc.cluster.local"
- name: REDIS_PORT
  value: {{ default 6379 .Values.redis_port | quote }}
- name: ODB_TYPE
  value: {{ default "postgresql" .Values.odb_type | quote }}
- name: ODB_HOSTNAME
  value: "{{ .Values.postgresql.fullname }}.{{ .Release.Namespace }}.svc.cluster.local"
- name: ODB_PORT
  value: {{ default 5432 .Values.postgresql.service.port | quote }}
- name: ODB_NAME
  value: {{ default "zato" .Values.odb_name | quote }}
- name: ODB_USERNAME
  value: {{ default "zato" .Values.odb_username | quote }}
- name: "SECRET_KEY"
  valueFrom:
    secretKeyRef:
      key:  secret_key
      name: {{ .Release.Name }}-auth
- name: "JWT_SECRET_KEY"
  valueFrom:
    secretKeyRef:
      key:  jwt_secret_key
      name: {{ .Release.Name }}-auth
- name: "zato_web_admin_password"
  valueFrom:
    secretKeyRef:
      key:  zato_web_admin_password
      name: {{ .Release.Name }}-auth
- name: "ZATO_IDE_PUBLISHER_PASSWORD"
  valueFrom:
    secretKeyRef:
      key:  zato_ide_publisher_password
      name: {{ .Release.Name }}-auth
- name: "ZATO_ADMIN_INVOKE_PASSWORD"
  valueFrom:
    secretKeyRef:
      key:  zato_admin_invoke_password
      name: {{ .Release.Name }}-auth
- name: "ODB_PASSWORD"
  valueFrom:
    secretKeyRef:
      key:  odb_password
      name: {{ .Release.Name }}-auth
{{- end -}}
