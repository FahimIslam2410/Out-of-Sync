extends CanvasLayer

# OptionMenu Scene

# Default timer duration in minutes
var timer_duration_lb: int = 2

# Converts minutes to seconds and sets the global timer
func convert_minutes_seconds(minutes: int) -> void:
	var seconds: int = minutes * 60
	# Sets Global timer to what user selected
	Globals.DiscussionCountdownTimer = seconds

func _on_minus_pressed() -> void:
	# Disable the minus button if timer duration is already at its minimum
	if timer_duration_lb <= 2:
		%Minus.disabled = true
	else:
		timer_duration_lb -= 1
		%PlusMinusDisplay.text = str(timer_duration_lb) + " Minutes"
		%Plus.disabled = false
	# Update the global timer based on the new duration
	convert_minutes_seconds(timer_duration_lb)

func _on_plus_pressed() -> void:
	# Disable the plus button if timer duration is already at its maximum
	if timer_duration_lb >= 8:
		%Plus.disabled = true
	else:
		timer_duration_lb += 1
		%PlusMinusDisplay.text = str(timer_duration_lb) + " Minutes"
		%Minus.disabled = false
	# Update the global timer based on the new duration
	convert_minutes_seconds(timer_duration_lb)


func _on_on_off_button_toggled(toggled_on):
	if toggled_on:
		%MainPlusMinusContainer.visible = true
		%VisualOnOff.text = "ON"
	else:
		%VisualOnOff.text = "OFF"
		%MainPlusMinusContainer.visible = false
		Globals.OnOffDiscussionTimer = false

func _on_shop_checkbutton_toggled(toggled_on):
		if toggled_on:
			print("Shop ON")
		else:
			print("Shop OFF")

func _on_music_checkbutton_toggled(toggled_on):
		if toggled_on:
			print("Music ON")
		else:
			print("Music OFF")

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
