extends Node2D

@export var move_speed : int

@onready var visual_timer = $VisualTimer

var current_folder : Node
var next_folder : Node
var period = 2

func setup(start_folder: Node):
	current_folder = start_folder
	current_folder.check_in("Monster")
	next_folder = get_next_folder()
	position = current_folder.get_enemy_position()
	point_arrow()

func _ready():
	$Timer.start(period)
	$VisualTimer.set_period(period)

func get_next_folder():
	return current_folder.connected_folders.pick_random()

func move():
	current_folder.check_out("Monster")
	current_folder = next_folder
	$Timer.stop()
	$MoveTimer.start(move_speed)
	visual_timer.hide()
	var tween = create_tween()
	tween.tween_property(self, "position", next_folder.get_enemy_position(), move_speed)
	
	
func point_arrow():
	var angle = global_position.angle_to_point(next_folder.position) 
	$DirectionArrow.rotation = -1 * PI + angle

func _on_timer_timeout():
	move()


func _on_move_timer_timeout():
	$MoveTimer.stop()
	current_folder.check_in("Monster")
	next_folder = get_next_folder()
	point_arrow()
	$Timer.start(period)
	$VisualTimer.show()
