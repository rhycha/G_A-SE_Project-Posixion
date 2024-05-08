extends Node


static var folder_references = {}

static var available_connections = {}

static var player


func setup_folder_references(folder_node):
	var nodes = folder_node.get_children()
	for node in nodes:
		Global.folder_references[node.name] = node
