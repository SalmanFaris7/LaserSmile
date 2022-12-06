extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
		
		
func _input(event):
	var i=0
	if modulate == Color.BLUE:
		
		modulate = Color.DEEP_SKY_BLUE
	
	var line = $"../../Laser/CollisionShape2d/Line2d"
	var ray = $"../../RayCast2d"
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		if get_rect().has_point(get_local_mouse_position()):	
			$"..".rotate(.4)
			
			modulate = Color.BLUE
