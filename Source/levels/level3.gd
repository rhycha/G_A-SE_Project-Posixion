extends Node2D

var folder_connections = {
	"when": [
		"you"
	],
	"you": [
		"when",
		"want",
		"try"
	],
	"want": [
		"you",
		"me",
		"to"
	],
	"me": [
		"want",
		"then"
	],
	"then": [
		"me",
		"show"
	],
	"to": [
		"want",
		"catch"
	],
	"catch": [
		"to",
		"the"
	],
	"the": [
		"catch",
		"bug"
	],
	"bug": [
		"the",
		"use"
	],
	"use": [
		"bug",
		"rm"
	],
	"rm": [
		"use",
		"command"
	],
	"command": [
		"rm",
		"with"
	],
	"with": [
		"command",
		"its",
	],
	"by": [
		"some",
		"love",
	],
	"its": [
		"with",
		"name"
	],
	"name": [
		"its"
	],
	"show": [
		"then",
		"your",
		"reason"
	],
	"your": [
		"show",
		"love"
	],
	"love": [
		"your",
		"by"
	],
	"some": [
		"by",
		"money"
	],
	"money": [
		"some"
	],
	"try": [
		"you",
		"best"
	],
	"best": [
		"try",
		"but"
	],
	"but": [
		"best",
		"dont"
	],
	"dont": [
		"but",
		"suck"
	],
	"suck": [
		"dont",
		"seed"
	],
	"reason": [
		"show",
		"why"
	],
	"why": [
		"reason",
		"we"
	],
	"we": [
		"why",
		"should"
	],
	"should": [
		"we",
		"have"
	],
	"have": [
		"should",
		"a"
	],
	"a": [
		"have",
		"relation"
	],
	"relation": [
		"a",
		"ship"
	],
	"ship": [
		"relation"
	],
	"seed": [
		"suck"
	]
}

# Preload your object or folder scene
var object_scene = preload("res://levels/level3.tscn")

# Positions and text values from the parsed XML
var elements = [
	Vector2(40.0, 50.0), "but",
	Vector2(240.0, 50.0), "best",
	Vector2(440.0, 50.0), "try",
	Vector2(640.0, 50.0), "some",
	Vector2(840.0, 50.0), "money",
	Vector2(40.0, 190.0), "dont",
	Vector2(240.0, 190.0), "seed",
	Vector2(440.0, 190.0), "when",
	Vector2(640.0, 190.0), "by",
	Vector2(840.0, 190.0), "love",
	Vector2(40.0, 330.0), "suck",
	Vector2(240.0, 330.0), "relation",
	Vector2(440.0, 330.0), "want",
	Vector2(640.0, 330.0), "me",
	Vector2(840.0, 330.0), "your",
	Vector2(40.0, 470.0), "its",
	Vector2(240.0, 470.0), "name",
	Vector2(440.0, 470.0), "to",
	Vector2(640.0, 470.0), "then",
	Vector2(840.0, 470.0), "show",
	Vector2(40.0, 610.0), "with",
	Vector2(240.0, 610.0), "command",
	Vector2(440.0, 610.0), "catch",
	Vector2(640.0, 610.0), "the",
	Vector2(840.0, 610.0), "reason",
	Vector2(40.0, 750.0), "ship",
	Vector2(240.0, 750.0), "rm",
	Vector2(440.0, 750.0), "use",
	Vector2(640.0, 750.0), "bug",
	Vector2(840.0, 750.0), "why",
	Vector2(40.0, 890.0), "relation",
	Vector2(240.0, 890.0), "a",
	Vector2(440.0, 890.0), "have",
	Vector2(640.0, 890.0), "should",
	Vector2(840.0, 890.0), "we"
]

# Grid parameters
var grid_columns = 7
var grid_rows = 5
var grid_spacing = Vector2(800, 600) # Adjust spacing as needed



#var monsers_spawn_positions = []
var monsers_spawn_positions = ["bug", "seed", "why", "money"]

var hidden_folders = ["show", "your"]

var help_message_path = "res://messages/lvl3.txt"

var bugged_folders = ["relation", "rm", "want", "love", "best"]



func _ready():
	# Preload your object or folder scene
	var object_scene = preload("res://levels/level3.tscn")

	$BaseLevel.setup(folder_connections,help_message_path, monsers_spawn_positions, hidden_folders, bugged_folders,\
	 elements, grid_rows, grid_columns, grid_spacing, object_scene)
#
	#var count = 0
	#for y in range(grid_rows):
		#for x in range(grid_columns):
			#if count < elements.size():
				#var element = elements[count]
				#var pos = element[0]
				#var text = element[1]
				#var instance = object_scene.instance()
				#instance.position = Vector2(x * grid_spacing.x, y * grid_spacing.y)
				#
				## Add text label
				#var label = Label.new()
				#label.text = text
				#label.position = Vector2(10, -10) # Adjust label position relative to object
				#instance.add_child(label)
				#
				#add_child(instance)
				#count += 1
			#else:
				#break

	
func _process(delta):
	pass

