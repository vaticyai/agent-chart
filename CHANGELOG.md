# Vaticy Agent Chart

## 0.1.4

### Enhancement 🏎️

- [#4](https://github.com/vaticyai/agent-chart/pull/4) Vaticy agent version bump-up

## 0.1.3

### Enhancement 🏎️

- [#3](https://github.com/vaticyai/agent-chart/pull/3) Adding 2 improvements to the chart:
  1. Allow the agent to fetch new resources:
        - `namespaces` from the `core API`
        - `storageclasses` from the `storage.k8s.io API`
  2. The ability to modify the `PROMETHEUS_ALERTS_WATCH_INTERVAL` entrainment variate
  3. New agent version

## 0.1.2

### Fixed 🔧

- [#2](https://github.com/vaticyai/agent-chart/pull/2) Agent to send Kubernetes Events **with** the event itself

## 0.1.1

### Fixed 🔧

- [#1](https://github.com/vaticyai/agent-chart/pull/1) Using Agent `v0.4.1` to allow fetching `logs` in the time of need without crashing the agent

## 0.1.0

Adding all basic capabilities to allow deploying the agent,
allowing to perform the following:

- Gathering data about the different objects in the Kubernetes cluster
- Executing mitigation commands when the correct permissions are set
