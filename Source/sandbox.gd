extends Node2D

@onready var console = $Control

func _ready():
	console.setup_console(["usr", "bin"], "root")


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			console.parse_text()
			console.clear()
		if event.keycode == KEY_TAB:
			console.autocomplete()
		
