extends Node2D

signal catched_player

var period = 2

var current_folder

# Called when the node enters the scene tree for the first time.
func place_in_folder(folder):
	current_folder = folder
	set_global_position(Global.folder_references[folder].get_enemy_position())


func start_visual_timer():
	$VisualTimer.reset_timer()

func _ready():
	$Timer.start(period)
	$VisualTimer.set_period(period)

func start_moving():
	$Timer.start()


func move():
	var next_position = Global.available_connections[current_folder].pick_random()
	position = Global.folder_references[next_position].get_enemy_position()
	current_folder = next_position
	return
	

func _process(delta):
	if Global.player.current_folder == current_folder:
		catched_player.emit()
	pass


func _on_timer_timeout():
	move()

