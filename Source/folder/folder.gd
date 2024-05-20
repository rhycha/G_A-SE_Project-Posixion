extends Node2D

@onready var folder_name = $Name
@onready var player_position = $PlayerPosition
@onready var enemy_position = $EnemyPosition

var connected_folders : Array
var entities_inside : Array
var hidden_folder = false
var bugged = false


signal monster_cached_player
signal player_entered
signal bug_removed


func check_in(entity_name : String):
	entities_inside.append(entity_name)
	if "Player" in entities_inside and "Monster" in entities_inside:
		print(entities_inside)
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
	print(entities_inside)

func get_player_position():
	return player_position.global_position
	
func get_enemy_position():
	return enemy_position.global_position

func _ready():
	folder_name.text = name
	$BugIcon.hide()

func _draw():
	var starting_point = global_position
	for connected_folder in connected_folders:
		var end_point = connected_folder.global_position
		draw_line(Vector2(0,0), end_point - starting_point, Color.BLUE, 10)
