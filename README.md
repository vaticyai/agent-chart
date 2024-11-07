# Vaticy Agent Helm Chart

This helm chart allows an easy installation of the Vaticy's [Kubernetes templates agent](/README.md)!

## Deploying the agent

To deploy the agent using this helm chart please execute the following command:

```bash
helm upgrade --install agent oci://ghcr.io/vaticyai/charts/vaticy-agent --version 0.1.0 -n vaticy --set variables.ORGANIZATION_ID="lpaJKhHmdyzKCNaf" --set variables.TOKEN="E0TkUwhV+N...."
```

```bash
kubectl namespace create vaticy

helm upgrade --install vaticy-agent --namespace vaticy ./chart
```

## Values

| Key | Mandatory | Default Value | Description |
| --- | --- | --- | --- |
| `enabled` | `no` | `true` | Should the agent be installed |
| `name` | `yes` | `agent` | Prefix to use while naming different templates |
| `replicas` | `no` | `1` | How many replicas to install |
| `image.repository` | `yes` | `ghcr.io/vaticyai/agent` | The repository to pull the image from |
| `image.tag` | `yes` | `v0.4.0` | The images tag to pull |
| `image.pullPolicy` | `no` | `IfNotPresent` | Image policy for the agent |
| `resources` | `no` | `{}` | The resources to run the agent with |
| `variables.LOG_LEVEL` | `no` | `warning` | Log level to run the agent with |
| `variables.ORGANIZATION_ID` | `yes` | `` | Organization ID received from the Vaticy platform |
| `variables.GATEWAY_HOST` | `yes` | `` | Where to send the gathered Kubernetes templates |
| `variables.ENABLE_TUNNEL` | `no` | `true` | Should the agent create a secured tunnel with the `API Gateway` |
| `variables.TOKEN` | `yes` | `` | This token is used to authenticate the agent |
| `variables.PROMETHEUS_ALERTS_WATCH_INTERVAL` | `no` | `30s` | How often to update the Vaticy platform about `Prometheus` alerts |

### Permissions

To set up the permissions you have to populate the `permissions:` list:

```yaml
permissions:
  - namespace: "*"
    resources:
      pods: ["watch", "list"]
      configmaps: ["watch", "list"]
      replicasets: ["watch", "list"]
      deployments: ["watch", "list"]
```

> Using `*` will apply the given permissions on all `Namespaces`!

You can add custom permissions per `Namespace` by appending it to the list in the same way:

```yaml
permissions:
  - namespace: "*"
    resources:
      pods: ["watch", "list"]
  - namespace: "demo"
    resources:
      pods: ["update", "delete"]
  - namespace: "monitoring"
    resources:
      pods: ["update", "delete", "patch"]
```

### Examples

#### Enabling the agent

```yaml
enabled: true
name: agent
replicas: 1
image:
  registry: ghcr.io/vaticyai/agent
  tag: v0.3.0
  pullPolicy: IfNotPresent
```

#### Setting up permissions on the cluster

It is possible to set up cluster wide permissions using `namespace: "*"`:

```yaml
permissions:
  - namespace: "*"
    resources:
      pods: ["watch", "list"]
      configmaps: ["watch", "list"]
      replicasets: ["watch", "list"]
      deployments: ["watch", "list"]
```

Instead it is possible to set up permissions per `Namespace`:

```yaml
permissions:
  - namespace: "demo"
    resources:
      pods: ["patch", "create", "delete"]
      configmaps: ["patch", "create", "update"]
      deployments: ["patch", "create", "update"]
      replicasets: ["patch", "create", "update", "delete"]
```

It is possible to combine multiple permissions at the same time:

```yaml
permissions:
  - namespace: "*"
    resources:
      pods: ["watch", "list"]
  - namespace: "demo"
    resources:
      pods: ["patch", "create", "delete"]
      configmaps: ["watch", "list", "patch", "create", "update"]
```

> This will allow the agent to watch `pods` across the whole cluster.
> Additionally on the `Namespace` `demo`, the agent is able to watch `ConfigMaps` and modify both `ConfigMaps` and `Pods`.
