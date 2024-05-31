extends Control

@onready var current_directory_text_field = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/CurrentDirectory
@onready var input_field = $Background/MarginContainer/VBoxContainer/InputArea/HBoxContainer/TextEdit
@onready var command_history_field = $Background/MarginContainer/VBoxContainer/CommandHistory/History
@onready var command_history = []

var current_directory : Node

func array_to_string(arr: Array, linker : String = '\n') -> String:
	var s = ""
	for i in arr.slice(0,-1):
		s += String(i) + linker
	return s + String(arr[-1])

	
func clear():
	input_field.clear()

func _ready():
	input_field.grab_focus.call_deferred()

func unfocus():
	input_field.release_focus()

func focus():
	print("here")
	input_field.grab_focus.call_deferred()


func add_to_history(text):
	command_history.append(text)
	if len(command_history) > 9:
		command_history.pop_front()
	command_history_field.text = array_to_string(command_history)

func check_for_autocomplete() -> bool:
	var text = input_field.text.split(" ")
	if text[0] == "cd" && len(text) > 1:
		return true
	if text[0] == "rm" && len(text) > 1:
		return true
	return false
#
func finish_path():
	var text_array = input_field.text.split(" ")
	var regex = RegEx.new()
	regex.compile(text_array[-1] + ".")
	
	var options = current_directory.get_connected_folders_names()
	if current_directory.bugged && text_array[0] == "rm":
		options.append("bug")	
	for direction in options:
		if regex.search(direction):
			text_array[-1] = direction
			input_field.clear()
			input_field.text = array_to_string(text_array, " ")
			input_field.caret_column =len(input_field.text)

func autocomplete():
	if check_for_autocomplete():
		finish_path()
		
func change_directory(input_text : String) -> Array:
	var text = input_text.split(" ")
	if len(text) == 1:
		return ["error", "No argument for function"]
	
	if len(text) > 2:
		return ["error", "cd: too many arguments"]
	
	var argument = text[1]	 
	for direction in current_directory.get_connected_folders_names():
		if argument == direction:
			return [["cd", direction], input_text]
	return ["error","cd: no such file or directory: " + argument]

func list(input_text : String) -> Array:
	var text = input_text.split(" ")
	if len(text) != 1:
		return ["error", "ls: too many arguments"]
	return [["ls", current_directory], input_text]
	

func setup(start_directory : Node):
	current_directory_text_field.text = start_directory.name + "> "
	current_directory = start_directory

func remove(input_text : String):
	var text = input_text.split(" ")
	if len(text) < 2:
		return ["error", "rm: too few arguments"]
	if len(text) > 2:
		return ["error", "rm: too many arguments"]	
			
	if text[0] == "rm" and text[1] == "bug":
		if current_directory.bugged == true:
			return  [["rm", current_directory], input_text]
		else:
			return ["error", "rm: no such file as bug"]
	return ["error", "rm: no such file as " + text[1]]
	

	

func parse_text() -> Array:
	var input_text = input_field.text
	var first_word = input_text.split(" ")[0]
	
	var result : Array
	match first_word:
		"cd":
			result = change_directory(input_text)
			add_to_history(result[1])			
		"ls":
			result = list(input_text)
			add_to_history(result[1])
		"rm":
			print(result)
			result = remove(input_text)
			add_to_history(result[1])
		_:
			add_to_history("bash: command not found: " + first_word)
			result =  ["error", ""]
	return result
