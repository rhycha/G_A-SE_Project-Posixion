extends Control

@onready var current_directory = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/CurrentDirectory
@onready var input_field = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/TextEdit
@onready var command_history_field = $Background/MarginContainer/VBoxContainer/CommandHistory/History

@onready var command_history = []
var child_folder_names

func array_to_string(arr: Array, linker : String = '\n') -> String:
	var s = ""
	for i in arr.slice(0,-1):
		s += String(i) + linker
	return s + String(arr[-1])

func set_current_directory(text):
	current_directory.text = text + "> "
	
func clear():
	input_field.clear()

# Called when the node enters the scene tree for the first time.
func _ready(history_size = 5, text = ">"):
	input_field.grab_focus()
	set_current_directory(text)
	pass

func add_to_history(text):
	command_history.append(text)
	if len(command_history) > 9:
		command_history.pop_front()
	command_history_field.text = array_to_string(command_history)


func check_for_autocomplete() -> bool:
	var text = input_field.text.split(" ")
	if text[0] == "cd" && len(text) > 1:
		return true
	return false

func finish_path():
	var text_array = input_field.text.split(" ")
	var regex = RegEx.new()
	regex.compile(text_array[-1] + ".")
	for direction in child_folder_names:
		if regex.search(direction):
			text_array[-1] = direction
			input_field.clear()
			input_field.text = array_to_string(text_array, " ")
			input_field.caret_column =len(input_field.text)

func autocomplete():
	if check_for_autocomplete():
		finish_path()


func change_directory():
	var text = input_field.text.split(" ")
	if len(text) == 1:
		return ["error", "No argument for function"]
	
	if len(text) > 2:
		return ["error", "cd: too many arguments"]
	
	var argument = text[1]	 
	for direction in child_folder_names:
		if argument == direction:
			return [["cd", direction], input_field.text]
	return ["error","cd: no such file or directory: " + argument]

func set_child_folder_names(names : Array):
	child_folder_names = names



func setup_console(child_folders : Array, current_directory : String):
	set_child_folder_names(child_folders)
	set_current_directory(current_directory)

func parse_text():
	var first_word = input_field.text.split(" ")[0]
	match first_word:
		"cd":
			var result = change_directory()
			add_to_history(result[1])
			return result
		_:
			add_to_history("bash: command not found: " + first_word)
			return ["error", ""]
