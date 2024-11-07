{{/*
Define API Group Mapping
*/}}
{{- define "apiGroupMapping" -}}
{{- $apiGroupMapping := dict
  "pods" (list "")
  "pods/log" (list "")
  "nodes" (list "")
  "events" (list "")
  "secrets" (list "")
  "services" (list "")
  "endpoints" (list "")
  "namespaces" (list "")
  "configmaps" (list "")
  "serviceaccounts" (list "")
  "persistentvolumes" (list "")
  "persistentvolumeclaims" (list "")
  "replicationcontrollers" (list "")
  "daemonsets" (list "apps")
  "replicasets" (list "apps")
  "deployments" (list "apps")
  "statefulsets" (list "apps")
  "jobs" (list "batch")
  "cronjobs" (list "batch")
  "ingresses" (list "networking.k8s.io")
  "networkpolicies" (list "networking.k8s.io")
  "podsecuritypolicies" (list "policy")
  "roles" (list "rbac.authorization.k8s.io")
  "rolebindings" (list "rbac.authorization.k8s.io")
  "clusterroles" (list "rbac.authorization.k8s.io")
  "clusterrolebindings" (list "rbac.authorization.k8s.io")
  "storageclasses" (list "storage.k8s.io")
}}
{{- $apiGroupMapping | toJson -}}
{{- end -}}
