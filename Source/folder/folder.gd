extends Node2D

@onready var folder_name = $Name
@onready var player_position = $PlayerPosition
@onready var enemy_position = $EnemyPosition

var connected_folders : Array
var entities_inside : Array
var hidden_folder = false
var bugged = false
var please_work  : bool

signal monster_cached_player
signal player_entered
signal bug_removed


func check_in(entity_name : String):
	entities_inside.append(entity_name)
	if "Player" in entities_inside and "Monster" in entities_inside:
		monster_cached_player.emit()
		
	if "Player" in 	entities_inside:
		player_entered.emit()


func unlock_hidden_connections():
	for folder in connected_folders:
		folder.make_visible()

func make_visible():
	$Sprite2D.modulate.a8 = 255
	$Name.visible = true
	hidden_folder = false

func make_hidden():
	$Sprite2D.modulate.a8 = 50
	$Name.visible = false
	hidden_folder = true

func make_bugged():
	bugged = true
	$BugIcon.show()
	
func remove_bug():
	if bugged == true:
		bugged = false
		$BugIcon.hide()
		bug_removed.emit()
	

func get_connected_folders_names() -> Array:
	var output = []
	for folder in connected_folders:
		if !folder.hidden_folder:
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
	$BugIcon.hide()



#func draw_lines():
	#for connected_folder in connected_folders:
		#var number = randi_range(1, 5)
		#print($arrow.texture)
		#
		##texture.create_from_image(load("res://icon.svg"))
		##texture.create_from_image(load("res://UI/folder_lines/Paths/Path1.png"))
		#
		#$arrow.scale = Vector2(10,10)
		#$arrow.position = Vector2(0,0) 
		##$arrow.texture
		#$arrow.rotation = global_position.angle_to_point(connected_folder.position)
		##print(sprite)
	
func set_to_draw(new_to_draw : bool):
	please_work = new_to_draw
func _process(delta):
	queue_redraw()

func _draw():
	var starting_point = global_position
	for connected_folder in connected_folders:
		var end_point = connected_folder.global_position
		if please_work == true:
			draw_line(Vector2(0,0), end_point - starting_point, Color.BLUE, 10)
