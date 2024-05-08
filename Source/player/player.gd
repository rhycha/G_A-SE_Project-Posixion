extends Node2D

## Called when the node enters the scene tree for the first time.

var current_folder = ""

func setup(start_folder):
	move(start_folder)
	Global.player = self

func move(destination_folder):
	current_folder = destination_folder
	set_global_position(Global.folder_references[destination_folder].get_player_position())


#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

