{
  prometheusAlerts+:: {
    local componentName = $._config.components.sinker,
    groups+: [
      {
        name: 'sinker-missing',
        rules: [
          {
            alert: 'SinkerNotRemovingPods',
            expr: |||
              absent(sum(rate(sinker_pods_removed[3h]))) == 1
            |||,
            'for': '5m',
            labels: {
              severity: 'high',
              slo: componentName,
            },
            annotations: {
              message: 'Sinker has not removed any Pods in the last 3 hours, likely indicating an outage in the service.',
            },
          },
          {
            alert: 'SinkerNotRemovingProwJobs',
            expr: |||
              absent(sum(rate(sinker_prow_jobs_cleaned[3h]))) == 1
            |||,
            'for': '5m',
            labels: {
              severity: 'high',
              slo: componentName,
            },
            annotations: {
              message: 'Sinker has not removed any Prow jobs in the last 3 hours, likely indicating an outage in the service.',
            },
          }
        ],
      },
    ],
  },
}