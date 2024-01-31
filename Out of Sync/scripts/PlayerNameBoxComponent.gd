extends MarginContainer
# PlayerNameBoxComponent Scene

# Variable to store the player name
var player_name : String

# Called when text in the line edit changes
func _on_line_edit_text_changed(new_text):
	player_name = new_text

# Function to retrieve the player name
func retrieve_player_name():
	if player_name == "" or player_name.is_empty():
		return ["", true]  # Return an empty string and true if the player name is empty
	else:
		return [player_name, false]  # Return the player name and false if it's not empty

# Called when the button is pressed
func _on_button_pressed():
	print(player_name)  # Print the player name when the button is pressed
