extends Node2D

var current_folder : Node
@export var move_speed : int
@onready var move_timer = $MoveTimer

func setup(start_folder : Node):
	current_folder = start_folder
	current_folder.check_in("Player")
	position = start_folder.get_player_position()
	
func move(destination_folder : Node):
	current_folder.check_out("Player")
	current_folder = destination_folder
	var tween = create_tween()
	tween.tween_property(self, "position", destination_folder.get_player_position(), move_speed)
	move_timer.start()

func _ready():
	move_timer.wait_time = move_speed

func _on_move_timer_timeout():
	move_timer.stop()
	current_folder.check_in("Player")
