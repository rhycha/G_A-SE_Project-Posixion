extends Node2D

@export var player_start : String
@onready var base_level = $BaseLevel

var connections = {
	"usr": ["bin", "root"],
	"bin": ["usr", "root"],
	"root": ["usr", "bin"]
}

var monster_position = []

func _ready():
	base_level.setup(connections, monster_position)
