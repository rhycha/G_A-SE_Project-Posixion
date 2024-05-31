extends PanelContainer


func setup(help_text_path : String):
	var file = FileAccess.open(help_text_path, FileAccess.READ)
	$MarginContainer/Label.text = file.get_as_text()
