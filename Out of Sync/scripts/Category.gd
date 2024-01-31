extends Node
# Cateogory scene


# Temp code - Just to see if the player names saved to global var
func _ready():
	var local_playerset = Globals.GlobalPlayerNamesSet
	for i in local_playerset:
		print("Printed out Player Names: " + i)
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/DiscussionTimer.tscn")
