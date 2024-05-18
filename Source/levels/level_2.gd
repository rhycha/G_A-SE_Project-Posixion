extends Node2D

var folder_connections = {
	"etc": ["usr"],
	"logs": [],
	"usr": ["logs", "packages"],
	"packages": [],
	"data": [],
	"tools": [],
	"http": [],
	"sys": [],
	"modules": [],
	"kernel": [],
	"temp": [],
	"cache": [],
}

var monsers_spawn_positions = ["data"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$BaseLevel.setup(folder_connections, monsers_spawn_positions)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_root_player_entered():
	$BaseLevel.end_game(true)
