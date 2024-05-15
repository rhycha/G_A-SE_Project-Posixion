extends Node2D

@onready var folder_name = $Name
@onready var player_position = $PlayerPosition
@onready var enemy_position = $EnemyPosition

var connected_folders : Array

signal player_entered



func get_player_position():
	return player_position.global_position
	
func get_enemy_position():
	return enemy_position.global_position

func _ready():
	folder_name.text = name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.player.current_folder == name:
		player_entered.emit()
