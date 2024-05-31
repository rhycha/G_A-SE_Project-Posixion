extends CanvasLayer

var text_visible = false

#@onready var help_text = $PanelContainer/MarginContainer/HelpText
@onready var small_hint = $ConstantText

var help_message : Node


func setup(help_text_path : String):
	help_message.setup(help_text_path)

func _ready():
	var scene = preload("res://UI/help_message.tscn")
	help_message = scene.instantiate()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if text_visible:
				text_visible = false
				get_tree().paused = false
				small_hint.text = "Press escape for help"
				remove_child(get_children()[-1])
				$CLI.focus()
				
			else:
				get_tree().paused = true
				$".".add_child(help_message)
				text_visible = true
				small_hint.text = "Press escape to close"
			
			
