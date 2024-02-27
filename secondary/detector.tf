# signalfx_detector.detector:
resource "signalfx_detector" "detector" {
    disable_sampling  = false
    max_delay         = 0
    min_delay         = 0
    name              = "simple cpu Detector"
    program_text      = <<-EOF
        A = data('cpu.utilization').publish(label='A')
        detect(when(A > threshold(15))).publish('simple cpu Detector')
    EOF
    show_data_markers = true
    show_event_lines  = false
    teams             = []
    time_range        = 86400

    rule {
        description        = "The value of cpu.utilization is above 15."
        detect_label       = "simple cpu Detector"
        disabled           = false
        notifications      = []
        parameterized_body = <<-EOF
            {{#if anomalous}}
            	Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" triggered at {{dateTimeFormat timestamp format="full"}}.
            {{else}}
            	Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" cleared at {{dateTimeFormat timestamp format="full"}}.
            {{/if}}
            
            {{#if anomalous}}
            Triggering condition: {{{readableRule}}}
            {{/if}}
            
            {{#if anomalous}}Signal value for cpu.utilization: {{inputs.A.value}}
            {{else}}Current signal value for cpu.utilization: {{inputs.A.value}}
            {{/if}}
            
            {{#notEmpty dimensions}}
            Signal details:
            {{{dimensions}}}
            {{/notEmpty}}
            
            {{#if anomalous}}
            {{#if runbookUrl}}Runbook: {{{runbookUrl}}}{{/if}}
            {{#if tip}}Tip: {{{tip}}}{{/if}}
            {{/if}}
        EOF
        severity           = "Critical"
    }

    viz_options {
        display_name = "cpu.utilization"
        label        = "A"
    }
}