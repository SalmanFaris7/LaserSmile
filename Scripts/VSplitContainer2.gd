#Vsplit container has the untitled class which is inherited from the untitled class of Node2d
#reference: https://docs.godotengine.org/en/3.1/getting_started/workflow/best_practices/what_are_godot_classes.html
extends VSplitContainer

signal finish_game
var do=0
var cont = 0
var finish = 0

func _ready():
	$"../../BoxContainer".set_visible(false)


func _on_texture_button_toggled(button_pressed):
	pass


func _on_texture_button_button_up():
	var line = $Laser/CollisionShape2d/Line2d
	line.clear_points()

func _on_texture_button_pressed():
	pass

func _on_texture_button_button_down():
#func _process(delta):	
	var ray = $RayCast2d
	var line = $Laser/CollisionShape2d/Line2d
	var max_bounces = 5
	var M1angle = $Mirror1.rotation
	var M2angle = $Mirror2.rotation
	var hit
	line.clear_points()
	
	line.add_point(Vector2.ZERO)
	ray.global_position = line.global_position
	ray.target_position = Vector2.from_angle(220.6).normalized()*1000
	ray.force_raycast_update()
	
	var prev = null
	var bounces = 0
	
	while true:
		if not ray.is_colliding():
			var pt = ray.global_position + ray.target_position
			line.add_point(line.to_local(pt))
			break
			
		var coll = ray.get_collider()
		var pt = ray.get_collision_point()	
		
		line.add_point(line.to_local(pt))
		
		if not coll.is_in_group("Mirror"):
			break
			
		var normal = ray.get_collision_normal()	
		
		
		if normal == Vector2.ZERO:
			break
			
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3
			
		prev = coll	
		prev.collision_mask = 0
		prev.collision_layer = 0
		
		
		
		ray.global_position = pt
		ray.target_position = ray.target_position.bounce(normal)
		ray.force_raycast_update()
		
		bounces += 1
		if bounces >= max_bounces:
			break
		
		if coll.is_in_group("A1"):
			hit=1
			cont += 1
			break
		if coll.is_in_group("A2"):
			hit=2
			cont += 1	
			break
					
	if prev != null:
		prev.collision_mask = 3
		prev.collision_layer = 3

	if cont > 0:
		cont = 0
		# test is variable created from the object of untitled class in Node2d
		if $"../../..".test == hit:
			var string1 = ($RichTextLabel.get_text())
			var time = string1.to_int()
			var points = 100/time
			$"../../BoxContainer/TextureRect/RichTextLabel".set_text("You Won")
			$"../../BoxContainer/TextureRect/RichTextLabel2".set_text(str("time taken: ",time, "seconds"))
			$"../../BoxContainer/TextureRect/RichTextLabel3".set_text(str("Final points: ", points))			
			do +=1
		else:
			$"../../BoxContainer/TextureRect/RichTextLabel".set_text("Wrong Answer: You Loss")
			$"../../BoxContainer/TextureRect/RichTextLabel2".set_text(str("time taken: ", 0))
			$"../../BoxContainer/TextureRect/RichTextLabel3".set_text(str("Final points: ", 0))
			do +=1
			
const TIME_PERIOD = 1
	
func _process(delta):
	if(do>0):
		finish += delta
		if finish > TIME_PERIOD:
			do = 0
			finish = 0
			emit_signal("finish_game")

func _on_v_split_container_2_finish_game():
	var string1 = ($RichTextLabel.get_text())
	var time = string1.to_int()
	var points = 100/time
	var line = $Laser/CollisionShape2d/Line2d
	line.clear_points()
	
	$"../../Timer".stop()	
	$"../../BoxContainer".set_visible(true)
	$"../VSplitContainer".set_visible(false)
	$".".set_visible(false)


func _on_stop_button_pressed():
	emit_signal("finish_game")
