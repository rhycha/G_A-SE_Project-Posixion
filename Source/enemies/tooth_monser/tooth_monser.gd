extends Node2D

signal catched_player

@onready var direction_arrow = $DirectionArrow

var period = 2
var current_folder
var next_folder
var previous_angle = 0

# Called when the node enters the scene tree for the first time.
func place_in_folder(folder_name):
	current_folder = Global.folder_references[folder_name]
	next_folder = get_next_position()
	set_global_position(current_folder.get_enemy_position())


func start_visual_timer():
	$VisualTimer.reset_timer()

func _ready():
	$Timer.start(period)
	$VisualTimer.set_period(period)
	point_arrow()

func start_moving():
	$Timer.start()

func get_next_position():
	var next_position_name = Global.available_connections[current_folder.name].pick_random()
	return Global.folder_references[next_position_name]

func move():
	position = next_folder.get_enemy_position()
	current_folder = next_folder
	return
	
func point_arrow():
	var angle = global_position.angle_to_point(next_folder.position) 
	direction_arrow.rotation = -1 * PI + angle
	#direction_arrow.rotate = angle

func _process(delta):
	if Global.player.current_folder == current_folder.name:
		catched_player.emit()
	pass


func _on_timer_timeout():
	move()
	next_folder = get_next_position()
	point_arrow()

