extends Node2D

@export var player_start : String
@onready var base_level = $BaseLevel

var connections = {
	"usr": ["bin", "root"],
	"bin": ["usr", "root"],
	"root": ["usr", "bin"]
}
var help_message_path = "res://messages/lvl1.txt"

var monster_position = ["bin"]

var lines = false
var hidden_folders = []

func _ready():
	base_level.setup(connections, help_message_path,  monster_position, hidden_folders, [], lines)
