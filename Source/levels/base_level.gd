extends Node2D

@onready var player = $Player
@onready var console = $HUD/CLI
@onready var monsters = $Monsters

@export var player_start : String
@export var finish_folder : String

func setup(connections : Dictionary, monsters_spawn_positions : Array, hidden_folders : Array):
	setup_folder(connections, hidden_folders)
	player.setup(find_child(player_start))
	console.setup(find_child(player_start))
	place_monsters(monsters_spawn_positions)
	
func place_monsters(spawn_positions : Array):
	var monster_scene = preload("res://enemies/tooth_monser/tooth_monser.tscn")
	for spawn_position in spawn_positions:
		var instance = monster_scene.instantiate()
		instance.setup(find_child(spawn_position))
		monsters.add_child(instance)
		
func interpret_command_result(result):
	if len(result[0]) == 1:
		return
	var command_and_arguments = result[0]
	match command_and_arguments[0]:
		"cd":
			var destination_folder = find_child(command_and_arguments[1])
			player.move(destination_folder)
			console.setup(destination_folder)
			print("oo")
		"ls":
			print("siema")
			console.current_directory.unlock_hidden_connections()


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			var result = console.parse_text()
			interpret_command_result(result)
			console.clear()
		if event.keycode == KEY_TAB:
			console.autocomplete()
		
func get_connected_folders(folder_names : Array) -> Array:
	var output = []
	for folder_name in folder_names:
		output.append(find_child(folder_name))
	
	return output

func end_game(win: bool):
	var game_over_scene = preload("res://UI/game_over_screen/game_over_screen.tscn")
	var game_over_instance = game_over_scene.instantiate()
	add_child(game_over_instance)
	get_tree().paused = true
	game_over_instance.set_title(win)

func _on_monster_catched_player():
	end_game(false)

func _player_entered_winning_folder():
	end_game(true)

func setup_folder(connection_description : Dictionary, hidden_folders : Array):
	for folder_name in connection_description:
		var folder = find_child(folder_name)
		folder.connected_folders = get_connected_folders(connection_description[folder_name])
		folder.connect("monster_cached_player", _on_monster_catched_player)
	
	find_child(finish_folder).connect("player_entered", _player_entered_winning_folder)
	
	for folder in hidden_folders:
		find_child(folder).make_hidden()
