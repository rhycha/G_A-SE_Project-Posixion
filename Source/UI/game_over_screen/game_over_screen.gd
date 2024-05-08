extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_restart_button_pressed():
	pass # Replace with function body.
