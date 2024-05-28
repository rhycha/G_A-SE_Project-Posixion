extends Node2D

@export var player_start : String
@onready var base_level = $BaseLevel

var connections = {
	"usr": ["bin"],
	"bin": ["usr", "win"],
	"win": ["bin"],
}
var monsers = []
var hidden_folders = ["win"]
var bugged_folders = ["usr"]
var help_message_path = "res://messages/lvl3.txt"

func _ready():
	base_level.setup(connections, help_message_path, monsers, hidden_folders, bugged_folders, true)
