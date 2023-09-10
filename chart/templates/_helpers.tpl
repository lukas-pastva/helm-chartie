{{/*
Check if a list contains a value
*/}}
{{- define "listContains" -}}
  {{- $value := .Get 1 -}}
  {{- $found := false -}}
  {{- range .Get 0 -}}
    {{- if eq . $value -}}
      {{- $found = true -}}
    {{- end -}}
  {{- end -}}
  {{- $found -}}
{{- end -}}
