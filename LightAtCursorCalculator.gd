extends Node2D

var pos: Vector2
var light_pos: Vector2
var count:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	draw_line(pos, light_pos, Color.NAVAJO_WHITE, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var light: PointLight2D = get_node("/root/LightShadows/RedLight")
	pos = get_global_mouse_position()
	light_pos = light.get_position()
	
	var distance = pos.distance_squared_to(light_pos)
	
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(pos, light_pos, 1)
	var result = space_state.intersect_ray(query)
	
	count += 1
	if (count % 200) == 0:
		if result.is_empty():
			var light_intensity = light.energy / sqrt(distance)
			light_intensity *= 1000
			print("Light intensity = " + str(light_intensity))
		else:
			print("Hidden")
		
	queue_redraw() 
	
