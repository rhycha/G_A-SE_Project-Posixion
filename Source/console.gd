extends Control

#@onready var command_history_field = $PanelContainer/VBoxContainer/CommandHistory
@onready var current_directory = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/CurrentDirectory
@onready var input_field = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/TextEdit
@onready var command_history_field = $Background/MarginContainer/VBoxContainer/CommandHistory/History

var command_history : Array

func set_current_directory(text):
	current_directory.text = text

func initHistory(n: int):
	command_history = []
	for i in range(n):
		command_history.append("")
	
func clear():
	input_field.text = ""

# Called when the node enters the scene tree for the first time.
func _ready(history_size = 5, text = ">"):
	input_field.grab_focus()
	initHistory(history_size)
	set_current_directory(text)

func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += String(i) + "\n"
	return s


func addToHistory(text):
	command_history.pop_front()
	command_history.append(text)
	command_history_field.text = array_to_string(command_history)



func changeDirectory(text : String, possible_directions : Array):
	if len(text.split(" ")) == 1:
		return ["error", "No argument for function"]
	
	if len(text.split(" ")) > 2:
		return ["error", "Too many arguments"]
	
	var argument = text.split(" ")[1]	 
	
	for direction in possible_directions:
		if argument == direction:
			return ["cd", direction]
	return ["error","Unknown path"]
	
	
	

func parseText():
	var first_word = input_field.text.split(" ")[0]
	match first_word:
		"cd":
			var result = changeDirectory(input_field.text, ["/"])
			addToHistory(result[1])
			return result
		_:
			addToHistory("Unrecognized command")
			return ["error", ""]

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
	
	
	
