#Node2d Contains the parent untitled class of the sub nodes
#reference:https://www.javatpoint.com/godot-classes-in-gdscript#:~:text=The%20body%20of%20a%20script,contain%20member%20variables%20or%20functions.
extends Node2D
var runtime = 0
var url = "https://marcconrad.com/uob/smile/api.php?out=json&base64=yes"
var end = $Control/BoxContainer/TextureRect/RichTextLabel
var MaxTime = $Control/BoxContainer/TextureRect/RichTextLabel
var Final_Points = $Control/BoxContainer/TextureRect/RichTextLabel
# Encapsulation has been done to following variable as the varible will used by outside classes
var test = 0 : get = test_get

func test_get():
	return test


func _ready():
	pass

func _process(delta):
	$Control/Timer.set_wait_time(1)
	if runtime == 60:
		$Control/Timer.stop()
		$Control/BoxContainer.set_visible(true)	
		runtime = 0

func _on_http_request_request_completed(result, response_code, headers, body):
	var lab1 = $Control/VBoxContainer/VSplitContainer2/Answer1/Sprite2d/Label
	var lab2 = $Control/VBoxContainer/VSplitContainer2/Answer2/Sprite2d/Label
	var lab_pas = $Control/lbl_pass
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randi_range(0,9)
	var randLabel = rng.randi_range(0,9)
	var json = JSON.new()
	var img = json.parse_string(body.get_string_from_utf8())
	if (response_code == 200):
		var question = img.get("question")
		var solution = img.get("solution")
		
		while int(solution) == random:
			random = rng.randi_range(0,9)
		if (randLabel%2==0):
			lab1.set_text(str(solution))
			lab2.set_text(str(random))
			test = 1
		else:
			lab1.set_text(str(random))
			lab2.set_text(str(solution))
			test = 2
		var load_img = Image.new()
		load_img.load_png_from_buffer(Marshalls.base64_to_raw(question))
		var texture = ImageTexture.create_from_image(load_img)
		$Control/VBoxContainer/VSplitContainer/TextureRect.texture = texture
		#		OS.alert('thisis the', 'this')
	else:
		
		print(img.error)

func _on_button_pressed():
	$HttpRequest.request(url)
	$Control/VBoxContainer/VSplitContainer2.set_visible(true)
	$Control/VBoxContainer/VSplitContainer/TextureRect/Button.set_visible(false)
	$Control/Timer.start()
	$Control/VBoxContainer/VSplitContainer/TextureRect/STOP_BUTTON.set_visible(true)

func _on_texture_button_pressed():
	$HttpRequest.request(url)
	$Control/BoxContainer.set_visible(false)
	$Control/VBoxContainer/VSplitContainer.set_visible(true)
	$Control/VBoxContainer/VSplitContainer2.set_visible(true)
	$Control/VBoxContainer/VSplitContainer/TextureRect/STOP_BUTTON.set_visible(true)
	runtime = 0
	$Control/Timer.start()

func _on_timer_timeout():
	runtime += 1
	$Control/VBoxContainer/VSplitContainer2/RichTextLabel.set_text(str("TIME: ",runtime))

