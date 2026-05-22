extends Node2D

@export var unit: PackedScene

var waypoint_status := true

func _ready() -> void:
	for i in range(10):
		var obj = unit.instantiate()
		obj.global_position = Vector2(randi() % 1000 + 30, randi() % 600 + 30)
		add_child(obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	RenderingServer.set_default_clear_color(Color(0.105, 0.563, 0.869, 1.0))


func waypoint_on():
	waypoint_status = true

func waypoint_off():
	waypoint_status = false
