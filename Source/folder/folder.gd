extends Node2D

@onready var folder_name = $Name
@onready var player_position = $PlayerPosition
@onready var enemy_position = $EnemyPosition

var connected_folders : Array

var entities_inside : Array

signal monster_cached_player
signal player_entered

func check_in(entity_name : String):
	entities_inside.append(entity_name)
	print(entities_inside)
	if "Player" in entities_inside and "Monster" in entities_inside:
		monster_cached_player.emit()
		
	if "Player" in 	entities_inside:
		player_entered.emit()


func get_connected_folders_names() -> Array:
	var output = []
	for folder in connected_folders:
		output.append(String(folder.name))
	return output


func check_out(entity_name : String):
	entities_inside.erase(entity_name)	

func get_player_position():
	return player_position.global_position
	
func get_enemy_position():
	return enemy_position.global_position

func _ready():
	folder_name.text = name

func _draw():
	var starting_point = global_position
	for connected_folder in connected_folders:
		var end_point = connected_folder.global_position
		draw_line(Vector2(0,0), end_point - starting_point, Color.BLUE, 10)
