extends Node2D

signal catched_player

var period = 2

var current_folder

# Called when the node enters the scene tree for the first time.
func place_in_folder(folder, folder_position):
	current_folder = folder
	
	set_global_position(folder_position)


func start_visual_timer():
	$VisualTimer.reset_timer()

func _ready():
	$Timer.start(period)
	$VisualTimer.set_period(period)

func start_moving():
	$Timer.start()


func move(destination_folder, player_folder_name):
	
	return
	

func _process(delta):
	pass


func _on_timer_timeout():
	catched_player.emit()
