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
		"love",
		"some"
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
		"with"
	],
	"some": [
		"with",
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
		"don't"
	],
	"don't": [
		"but",
		"suck"
	],
	"suck": [
		"don't",
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

#var monsers_spawn_positions = []
var monsers_spawn_positions = ["bug", "send", "why", "money"]

var hidden_folders = ["show", "your"]

var bugged_folders = ["relation", "rm", "want", "love", "best"]

func _ready():
	$BaseLevel.setup(folder_connections, monsers_spawn_positions, hidden_folders)
	pass # Replace with function body.

func _process(delta):
	pass

