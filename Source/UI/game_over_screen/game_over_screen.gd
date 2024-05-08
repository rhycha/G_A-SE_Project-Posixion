extends CanvasLayer

@onready var title = $PanelContainer/MarginContainer/VBoxContainer/Title

func _ready():
	pass # Replace with function body.

func set_title(win : bool):
	if win:
		title.text = "You win"
		title.modulate = Color.GREEN
	else:
		title.text = "You loose"
		title.modulate = Color.RED
		


func _on_quit_button_pressed():
	get_tree().quit()

func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
