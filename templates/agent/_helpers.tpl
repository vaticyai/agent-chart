{{/* _helpers.tpl */}}
{{- define "getWatchResources" -}}
{{- $permissions := .Values.permissions -}}
{{- $wildcardResources := dict -}}
{{- $namespaceResources := dict -}}

{{- /* Step 1: Collect resources from the wildcard namespace ("*") */ -}}
{{- range $perm := $permissions -}}
  {{- if eq $perm.namespace "*" -}}
    {{- range $resource, $actions := $perm -}}
      {{- if ne $resource "namespace" -}}  {{/* Skip the "namespace" key */}}
        {{- range $action := $actions -}}  {{/* Iterate over actions since $actions is a slice */}}
          {{- if eq $action "watch" -}}  {{/* Only consider resources with "watch" permissions */}}
            {{- $wildcardResources = merge $wildcardResources (dict $resource (list "watch")) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- /* Step 2: Collect resources from other namespaces and avoid duplication from wildcard namespace ("*") */ -}}
{{- range $perm := $permissions -}}
  {{- if ne $perm.namespace "*" -}}
    {{- $ns := $perm.namespace -}}
    {{- $resources := list -}}
    {{- range $resource, $actions := $perm -}}
      {{- if ne $resource "namespace" -}}  {{/* Skip the "namespace" key */}}
        {{- range $action := $actions -}}  {{/* Iterate over actions */}}
          {{- if eq $action "watch" -}}  {{/* Only consider resources with "watch" permissions */}}
            {{- if not (hasKey $wildcardResources $resource) -}}  {{/* Avoid duplicates from wildcard */}}
              {{- $resources = append $resources $resource -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if not (empty $resources) -}}
      {{- $namespaceResources = merge $namespaceResources (dict $ns $resources) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- $result := merge (dict "*" (keys $wildcardResources)) $namespaceResources -}}
{{- $result | toJson -}}
{{- end -}}
