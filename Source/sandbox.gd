extends Node2D

@export var player_start : String
@onready var base_level = $BaseLevel

var connections = {
	"usr": ["bin"],
	"bin": ["usr"]
}

func _ready():
	base_level.setup(connections)
