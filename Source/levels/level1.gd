extends Node2D

@export var starting_folder : String
@onready var console = $HUD/Control/CLI
@onready var folders = $Folders
@onready var player = $Player

var available_connections = {
	"usr": ["bin", "root"],
	"bin": ["usr", "root"],
	"root": ["usr", "bin"],
}

#var monsers_spawn_positions = []
var monsers_spawn_positions = ["bin"]

func setup_folder_connections(folder):
	folder.connected_folders = available_connections[folder.name]
	

func _ready():
	Global.setup_folder_references(folders)
	Global.available_connections = available_connections
	console.setup_console(available_connections[starting_folder], starting_folder)
	spawn_monsers()
	player.setup(starting_folder)
	Global.current_level = self
	
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

func end_game(win: bool):
	var game_over_scene = preload("res://UI/game_over_screen/game_over_screen.tscn")
	var game_over_instance = game_over_scene.instantiate()
	add_child(game_over_instance)
	get_tree().paused = true
	game_over_instance.set_title(win)

func _on_tooth_monser_catched_player():
	end_game(false)

func _on_bin_player_entered():
	end_game(true)

func _draw():
	for folder in Global.available_connections:
		var starting_point = Global.folder_references[folder].global_position
		for connected_folders in Global.available_connections[folder]:
			var end_point = Global.folder_references[connected_folders].global_position
			draw_line(starting_point, end_point, Color.BLUE, 10)
