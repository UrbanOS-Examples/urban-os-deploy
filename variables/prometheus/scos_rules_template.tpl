monitoring:
  prometheus:
    serverFiles:
      alerts:
        groups:
          - name: dataset_alerts
            rules:
%{for rule in datasetRules ~}
              - alert: ${rule.title}
                expr: 'sum(rate(kafka_topic_partition_current_offset{topic="transformed-${rule.id}"}[${ rule.interval }])) by (topic) == 0'
                labels:
                  severity: error
                annotations:
                  description: '${rule.title} has not had any input in the last ${rule.interval}. ID: ${rule.id}'
                  summary: 'The latest ${rule.title} data has not loaded'
%{ endfor }
          - name: tracer_alerts
            rules:
              - alert: MessageThroughput
                expr: sum(rate(kafka_topic_partition_current_offset{topic=~"raw-00000000-7e77-4b1c-92a4-36e09db56173|transformed-00000000-7e77-4b1c-92a4-36e09db56173|streaming-persisted|scos__sample_streaming_dataset"}[5m])) by (topic) == 0
                labels:
                  severity: error
                annotations:
                  summary: "{{ $labels.topic }} has no input for at least 5 minutes"
          - name: joomla_backup
            rules:
              - alert: JoomlaBackupNotCompleted
                expr: >
                  time() - max(kube_job_status_start_time{job_name=~"joomla-backup.*"}) > 1800 and
                  max(kube_job_status_completion_time{job_name=~"joomla-backup.*"}) < max(kube_job_status_start_time{job_name=~"joomla-backup.*"})
                labels:
                  severity: error
                annotations:
                  summary: "Joomla Backup Not Completed"
                  description: "Most recent Joomla backup did not complete"
              - alert: JoomlaBackupOverdue
                expr: >
                  time() - max(kube_job_status_completion_time{job_name=~"joomla-backup.*"}) > 172800
                labels:
                  severity: error
                annotations:
                  summary: "Joomla Backup Overdue"
                  description: "Joomla backup has not run in over 24 hours"
          - name: model_variance
            rules:
              - alert: ModelVarianceLarger
                expr: parking_model_variance{job='variance'} > 0.10
                labels:
                  severity: warning
                annotations:
                  summary: "Parking model variance exceeds 0.10"
                  description: "Parking prediction variance for zone {{ $labels.zone }} is {{ $value }}."