extends Control




func _draw():
	for folder in Global.available_connections:
		var starting_point = Global.folder_references[folder].global_position
		for connected_folders in Global.available_connections[folder]:
			var end_point = Global.folder_references[connected_folders].global_position
			print(starting_point, end_point)
			draw_line(starting_point, end_point, Color.BLUE, 10)
	
