extends CharacterBody2D

@export var waypoint: PackedScene

@export var radius := 20.0 # circle texture radius
@export var color_unselected := Color(1, 0, 0, 1)
@export var color_selected := Color(0.833, 0.0, 0.0, 1.0)
var waypoints := [] # waypoind Vector2 coords
var selected := false # apply new waypoints if true
var target: Vector2 # next waypoint
var target_num := 0 # index of next target
var path_end := false # true when troupe reached last waypoint
var waypoint_objs := [] # collects waypoint game objects
var moving := false

static var selected_troupe: Array[CharacterBody2D] = []

var color = color_unselected
func _draw():
	draw_circle(Vector2.ZERO, radius, color)

func _ready():
	queue_redraw()
	add_to_group("troupes")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("waypoint_on_cursor"):
		# spawn waypoint on mouse click
		if self in selected_troupe:
			var obj = waypoint.instantiate()
			waypoint_objs.append(obj)
			obj.global_position = get_global_mouse_position()
			print(obj.global_position)
			get_tree().get_current_scene().add_child(obj)
			waypoints.append(obj.global_position)
	elif event.is_action_pressed("select"):
		var troupes = get_tree().get_nodes_in_group("troupes")
		for troupe in troupes:
			if troupe.moving:
				selected_troupe.erase(troupe)
				troupe.toggle_color()
		if self in selected_troupe:
			return
		if global_position.distance_to(get_global_mouse_position()) <= 10: # select troupe with mouse click
			reset()
			selected_troupe.append(self)
			toggle_color()
			get_viewport().set_input_as_handled()
			return
	elif event.is_action_pressed("cancel") and self in selected_troupe:
		reset()
			
func _process(delta: float) -> void:
	if waypoints:
		path_end = false
		if global_position.distance_to(waypoints[-1]) < 1.0: # when last waypoint is reached
			reset()
		if not path_end: # Move to next waypoint
			if target_num >= waypoints.size():
				moving = false
				return
			moving = true
			target = waypoints[target_num]
			if global_position.distance_to(waypoints[target_num]) < 1.0:
				target_num += 1
			global_position = global_position.move_toward(target, 50*delta)
func reset():
	# reset everything eg when last waypoint is reached
	path_end = true
	moving = false
	waypoints.clear()
	print("Path ended")
	target_num = 0
	if self in selected_troupe:
		selected_troupe.erase(self)
		toggle_color()
	for obj in waypoint_objs:
		obj.queue_free()
	waypoint_objs.clear()
	
func toggle_color():
	if self in selected_troupe:
		color = color_selected
	else:
		color = color_unselected
	queue_redraw()
	
