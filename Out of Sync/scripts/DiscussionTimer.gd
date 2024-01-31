extends Node

# Discussion Timer

var selected_time_seconds = Globals.DiscussionCountdownTimer # Default to 2 minutes


func _on_timer_timeout():
	if selected_time_seconds > 0:
		selected_time_seconds -= 1
		update_timer_label()
	else:
		# Timer reached zero
		$Timer.stop()
		Input.vibrate_handheld(500)		# Vibrates phone, Android vibration permission needs to enabled on export
		$TimerLabel.text = "Timer Finished"

func update_timer_label():		# Organise the minutes and seconds for display
	var minutes = selected_time_seconds / 60
	var seconds = selected_time_seconds % 60
	$TimerLabel.text = "%02d:%02d" % [minutes, seconds]

func _ready():
	if Globals.OnOffDiscussionTimer:
		update_timer_label()
	else:
		$Timer.stop()
		$Timer.autostart = false
		$TimerLabel.text = """Discussion Timer has been turned off.
		(This won't be visible in end development)"""

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
