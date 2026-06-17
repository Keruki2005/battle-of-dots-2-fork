extends Node2D

@export var unit: PackedScene

var waypoint_status := true

func _ready() -> void:
	# spawn players
	for i in range(6):
		var obj = unit.instantiate()
		obj.global_position = Vector2(randi() % 1000 + 30, randi() % 600 + 30)
		obj.team = "red"
		obj.bot = false
		add_child(obj)
		
	# spown bots
	for i in range(6):
		var obj = unit.instantiate()
		obj.global_position = Vector2(randi() % 1000 + 30, randi() % 600 + 30)
		obj.team = "green"
		add_child(obj)

func _process(delta: float) -> void:
	# background color
	RenderingServer.set_default_clear_color(Color(0.105, 0.563, 0.869, 1.0))


func waypoint_on():
	waypoint_status = true

func waypoint_off():
	waypoint_status = false
