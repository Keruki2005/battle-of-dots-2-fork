extends Node2D


@export var radius := 5
@export var color := Color.BLACK

func _draw():
	draw_circle(Vector2.ZERO, radius, color)

func _ready():
	queue_redraw()
