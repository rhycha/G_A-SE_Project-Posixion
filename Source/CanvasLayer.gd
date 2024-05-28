extends CanvasLayer

var text_visible = false

@onready var help_text = $PanelContainer/MarginContainer/HelpText
@onready var small_hint = $ConstantText



func setup(help_text_path : String):
	var file = FileAccess.open(help_text_path, FileAccess.READ)
	help_text.text = file.get_as_text()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if text_visible:
				$PanelContainer.hide()
				text_visible = false
				get_tree().paused = false
				small_hint.text = "Press escape for help"
			else:
				get_tree().paused = true
				$PanelContainer.show()
				text_visible = true
				small_hint.text = "Press escape to close"
			
