{{/*
Check if a list contains a value
*/}}
{{- define "listContains" -}}
  {{- $value := .value -}}
  {{- $list := .list -}}
  {{- $found := false -}}
  {{- range $list -}}
    {{- if eq . $value -}}
      {{- $found = true -}}
    {{- end -}}
  {{- end -}}
  {{- $found -}}
{{- end -}}

{{- define "common.tplvalues.render" -}}
{{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
{{- if contains "{{" (toJson .value) }}
  {{- if .scope }}
      {{- tpl (cat "{{- with $.RelativeScope -}}" $value "{{- end }}") (merge (dict "RelativeScope" .scope) .context) }}
  {{- else }}
    {{- tpl $value .context }}
  {{- end }}
{{- else }}
    {{- $value }}
{{- end }}
{{- end -}}

{{/*
Compute a combined checksum from a list of template files.
Usage: {{ include "helmChartie.checksum" . }}
*/}}
{{- define "helmChartie.checksum" -}}
{{- $files := .checksumLabelFiles }}
{{- $combined := "" -}}
{{- range $file := $files }}
{{- $combined = printf "%s%s" $combined (include (print $.Template.BasePath "/" $file) .) }}
{{- end }}
{{- $combined | sha256sum | trunc 63 }}
{{- end }}
