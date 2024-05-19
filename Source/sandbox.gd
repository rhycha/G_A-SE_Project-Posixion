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


func _ready():
	base_level.setup(connections, monsers, hidden_folders)
