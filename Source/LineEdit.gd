extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready(history_size = 5, text = "> "):
	grab_focus()
	set_caret_column(2)

func _input(event):
	return
	#if event is InputEventKey and event.is_pressed():
		#var key_text = OS.get_scancode_string(event.scancode)
		#if key_text == "BackSpace":
			#var new_text = $Label.text
			#new_text.erase($Label.text.length()-1,1)
			#$Label.text = new_text
		#elif key_text == "Space":
			#$Label.text += " "
		#elif key_text == "Enter":
			#$Label.text += "\n"
		#else:
			#$Label.text += key_text
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
