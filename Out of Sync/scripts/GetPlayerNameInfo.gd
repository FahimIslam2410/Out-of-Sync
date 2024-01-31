extends CanvasLayer
# GetPlayerNameInfo scene

# Load the InputPlayerName scene
@onready var InputPlayerName = preload("res://Scenes/PlayerNameBoxComponent.tscn")

# Sets the amount of players/player names that can be entered into the game
var player_limit = 14

# Array to store children instances of InputPlayerName components
var InputPlayerName_childScenes_array = []

# Array to store the names of local players
var LocalPlayerNamesSet : Array

# Variable to store the last added child instance
var lastChild = null

func _process(delta):
	# Show or hide the "Next" button based on the number of player name boxes added
	if InputPlayerName_childScenes_array.size() >= 4:
		%NextButton.visible = true
		%MorePlayersLabel.visible = false
	else:
		%NextButton.visible = false
		%MorePlayersLabel.visible = true

func _ready():
	# Call function to add initial player name box
	add_input_player_name_child()
	print("Added new player name box.")	# Not need but just for continuity

# Function to add a new player name box
func add_input_player_name_child():
	# Instantiate InputPlayerName scene
	var newChild = InputPlayerName.instantiate()

	# Set a unique name for the new instance
	newChild.name = "InputPlayerNameUnique" + str(InputPlayerName_childScenes_array.size())

	# Add the new instance to the array and the scene
	InputPlayerName_childScenes_array.append(newChild)
	%PlayerEnterVBox.add_child(newChild)

# Function called when the "Add" button is pressed
func _on_add_button_pressed():
	# Check if the maximum player name boxes limit is reached
	if InputPlayerName_childScenes_array.size() == (player_limit - 1):
		%AddButton.disabled = true
		print("Reached maximum player name boxes.")
	else:
		# Get the last added child if there are any children
		if InputPlayerName_childScenes_array.size() > 0:
			lastChild = InputPlayerName_childScenes_array[-1]

	# Check if the last added child exists and if its player name is not entered
	if lastChild != null and lastChild.retrieve_player_name()[1] == true:
		print("Please enter a name!")  # Add animation that shakes the player name box if name is not entered
	else:
		# Enable the "Remove" button
		%RemoveButton.disabled = false

		# Add a new player name box
		var newChild = InputPlayerName.instantiate()
		newChild.name = "InputPlayerNameUnique" + str(InputPlayerName_childScenes_array.size())
		InputPlayerName_childScenes_array.append(newChild)
		%PlayerEnterVBox.add_child(newChild)
		print("Added new player name box.")

# Function called when the "Remove" button is pressed
func _on_remove_button_pressed():
	if InputPlayerName_childScenes_array.size() == 1:
		print("Cannot remove last player name box.")
	else:
		# Remove the last player name box
		var lastChild = InputPlayerName_childScenes_array.pop_back()
		if LocalPlayerNamesSet.size() == 1:
			pass
		else:
			LocalPlayerNamesSet.pop_back()
		if lastChild != null:
			lastChild.retrieve_player_name()
			lastChild.queue_free()
			%AddButton.disabled = false
			print("Removed last player name box.")

			# Disable the "Remove" button if there's only one player name box left
			if InputPlayerName_childScenes_array.size() == 1:
				%RemoveButton.disabled = true
		else:
			print("Last player name box instance is null.")

# Function called when the "Next" button is pressed
func _on_next_button_pressed():
	# Iterate through each child scene to retrieve the player names
	for child in InputPlayerName_childScenes_array:
		# Check if the player name is entered and not empty
		if (child.retrieve_player_name()[0].is_empty()):
			pass
		else:
			# Add the player name to the LocalPlayerNamesSet array
			LocalPlayerNamesSet.append(child.retrieve_player_name()[0])

	# Check if at least 4 player names are entered
	if (LocalPlayerNamesSet.size() >= 4):
		Globals.GlobalPlayerNamesSet = LocalPlayerNamesSet
		get_tree().change_scene_to_file("res://Scenes/Category.tscn")
	else:
		print("Please enter at least 4 player names!")	# Add animation that shakes the player name box if name is 		not entered
		# Clear the LocalPlayerNamesSet array if the condition is not met
		LocalPlayerNamesSet = []
