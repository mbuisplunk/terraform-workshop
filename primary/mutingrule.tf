resource "signalfx_alert_muting_rule" "primary_mute_rule3" {
  description = "muting detector alert from primary instance"

  start_time = 1709006714
  stop_time  = 0 # Defaults to 0

  detectors = ["GHTb_D4AwAY"]
}