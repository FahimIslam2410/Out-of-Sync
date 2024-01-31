extends CanvasLayer
# Main Menu Scene

func _ready():
	pass # Play menu music

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/GetPlayerNameInfo.tscn")

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HowToPlay.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/OptionsMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
