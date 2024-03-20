# signalfx_time_chart.simplecpu_dash_0_0:
resource "signalfx_time_chart" "simplecpu_dash_0_0" {
    axes_include_zero  = false
    axes_precision     = 0
    color_by           = "Dimension"
    disable_sampling   = false
    max_delay          = 0
    minimum_resolution = 0
    name               = "simple cpu"
    plot_type          = "LineChart"
    program_text       = <<-EOF
        A = data('cpu.utilization').publish(label='A')
        B = alerts(detector_id="${signalfx_detector.detector.id}").publish(label="B");
    EOF
    show_data_markers  = false
    show_event_lines   = false
    stacked            = false
    time_range         = 900
    unit_prefix        = "Metric"

    histogram_options {
        color_theme = "red"
    }

    viz_options {
        axis         = "left"
        display_name = "cpu.utilization"
        label        = "A"
    }
}
# signalfx_dashboard.simplecpu_dash_0:
resource "signalfx_dashboard" "simplecpu_dash_0" {
    charts_resolution = "default"
    dashboard_group   = signalfx_dashboard_group.simplecpu.id
    name              = "simple cpu dashboard"

    chart {
        chart_id = signalfx_time_chart.simplecpu_dash_0_0.id
        column   = 0
        height   = 1
        row      = 0
        width    = 6
    }
}