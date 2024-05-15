extends Node2D

var current_folder = ""
@export var move_speed : int
@onready var move_timer = $MoveTimer

var dest_folder = ""

func setup(start_folder):
	move(start_folder)
	Global.player = self
	
func move(destination_folder):
	dest_folder = destination_folder
	current_folder = ""
	var tween = create_tween()
	tween.tween_property(self, "position", Global.folder_references[destination_folder].get_player_position(), 1)
	move_timer.start()

func _ready():
	move_timer.wait_time = move_speed

func _on_move_timer_timeout():
	current_folder = dest_folder
