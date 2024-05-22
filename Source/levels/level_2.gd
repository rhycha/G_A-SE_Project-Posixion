extends Node2D

var folder_connections = {
	"cry": [
		"I"
	],
	"I": [
		"cry",
		"am",
		"home"
	],
	"home": [
		"I",
		"you",
		"bug"
	],
	"bug": [
		"home"
	],
	"am": [
		"I",
		"fool"
	],
	"fool": [
		"am"
	],
	"crushed": [
		"by_car",
		"my_car",
		"you"
	],
	"my_car": [
		"crushed"
	],
	"by_car": [
		"crushed"
	],
	"you": [
		"home",
		"crushed",
		"and"
	],
	"and": [
		"you",
		"your"
	],
	"your": [
		"and",
		"brother"
	],
	"brother": [
		"your"
	]
}

#var monsers_spawn_positions = []
var monsers_spawn_positions = ["bug"]
var help_message_path = "res://messages/lvl2.txt"

var hidden_folders = ["my_car"]

func _ready():
	$BaseLevel.setup(folder_connections, help_message_path, monsers_spawn_positions, hidden_folders)
	pass # Replace with function body.

func _process(delta):
	pass
