extends PanelContainer

func setup(help_text_path : String):
	var file = FileAccess.open(help_text_path, FileAccess.READ)
	$MarginContainer1/HelpText.text = file.get_as_text()
	
