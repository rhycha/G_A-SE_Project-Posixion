extends Node2D

@export var starting_folder : String
@onready var console = $HUD/CLI
@onready var folders = $Folders
@onready var player = $Player


var available_connections = {
	"usr": ["bin", "root"],
	"bin": ["usr", "root"],
	"root": ["usr", "bin"],
}

var monsers_spawn_positions = ["bin"]

func setup_folder_connections(folder):
	folder.connected_folders = available_connections[folder.name]
	

func _ready():
	Global.setup_folder_references(folders)
	Global.available_connections = available_connections
	console.setup_console(available_connections[starting_folder], starting_folder)
	spawn_monsers()
	player.setup(starting_folder)
	
	for folder in folders.get_children():
		setup_folder_connections(folder)
	

func interpret_command_result(result):
	if len(result[0]) == 1:
		return
	var command_and_arguments = result[0]
	match command_and_arguments[0]:
		"cd":
			player.move(command_and_arguments[1])
			console.setup_console(available_connections[command_and_arguments[1]], command_and_arguments[1])
			

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			var result = console.parse_text()
			interpret_command_result(result)
			console.clear()
		if event.keycode == KEY_TAB:
			console.autocomplete()
			

func spawn_monsers():
	var monster_scene = preload("res://enemies/tooth_monser/tooth_monser.tscn")
	for spawn_position in monsers_spawn_positions:
		var instance = monster_scene.instantiate()
		instance.place_in_folder(spawn_position)
		instance.connect("catched_player", _on_tooth_monser_catched_player)
		$Monsers.add_child(instance)
		

func _on_tooth_monser_catched_player():
	print("encounter")
