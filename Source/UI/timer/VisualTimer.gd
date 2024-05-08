extends Control

var _time : float = 0
@export var radius : float
var period : float = 1

# Called when the node enters the scene tree for the first time.
func set_period(new_period):
	period = new_period

func reset_timer():
	_time = 0

func _draw():
	var godot_blue : Color = Color.RED
	draw_arc(Vector2(0, 0), radius, 0, (_time/2 * period) * PI, 100, godot_blue, radius * 2)



func _process(delta : float):
	_time += delta
	if _time > period:
		_time = 0
	queue_redraw()

