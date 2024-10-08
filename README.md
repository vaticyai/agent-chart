# Vaticy Agent Helm Chart

This helm chart allows an easy installation of the Vaticy's [Kubernetes templates agent](/README.md)!


## Deploying the agent

To deploy the agent using this helm chart please execute the following command:

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
| `image.tag` | `yes` | `v0.2.0` | The images tag to pull |
| `image.pullPolicy` | `no` | `Always` | Image policy for the agent |
| `resources` | `no` | `{}` | The resources to run the agent with |
| `variables.LOG_LEVEL` | `no` | `warning` | Log level to run the agent with |
| `variables.ORGANIZATION_ID` | `yes` | `` | Organization ID received from the Vaticy platform |
| `variables.GATEWAY_HOST` | `yes` | `` | Where to send the gathered Kubernetes templates |
| `variables.ENABLE_TUNNEL` | `no` | `true` | Should the agent create a secured tunnel with the `API Gateway` |
| `variables.AUTH0_TOKEN` | `yes` | `` | This token is used to authenticate the agent |

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

#### Important variables

```yaml
variables:
  LOG_LEVEL: "warning"
  CLUSTER_NAME: "k3d-local"
  CLIENT_NAME: "vaticy-test"
  GATEWAY_HOST: "http://192.168.3.24:8080"
```

#### Pulling the Image from the private GitHub registry

```yaml
secret:
  dockerServer: "https://ghcr.io"
  dockerUsername: "oauth2accesstoken"
  dockerPassword: "ghp_8QZHRHO7PxxxxxxxxxxxxxFz7t0g9JMW4"
  dockerEmail: "zigelboim.misha@gmail.com"
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
