{{/* Generate basic labels */}}
{{- define "webapp-color.labels" }}
    app: {{ .Values.name }}
    environment: {{ .Values.environment }}
    date: {{ now | htmlDate }}
{{- end }}