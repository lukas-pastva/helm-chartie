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

{{- define "helmChartie.checksum" -}}
{{- $files := .checksumLabelFiles }}
{{- $combined := "" -}}
{{- range $file := $files }}
{{- /* Construct the template path relative to the templates/ directory */ -}}
{{- $templatePath := printf "templates/%s" $file -}}
{{- /* Check if the template exists to avoid errors */ -}}
{{- if (lookup "template" $templatePath .) }}
{{- $combined = printf "%s%s" $combined (include $templatePath .) }}
{{- else }}
{{- fail (printf "Template '%s' not found." $templatePath) }}
{{- end }}
{{- end }}
{{- $combined | sha256sum | trunc 63 }}
{{- end }}
