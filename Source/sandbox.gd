extends Node2D

@onready var console = $Control

func _ready():
	console.set_child_folder_names(["usr", "bin"])


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			console.parse_text()
			console.clear()
		if event.keycode == KEY_TAB:
			console.autocomplete()
		
