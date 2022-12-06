extends Control

var url = "https://marcconrad.com/uob/smile/api.php?out=json&base64=yes"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	var img = json.parse_string(body.get_string_from_utf8())
	if (response_code == 200):
		var question = img.get("question")
		var solution = img.get("solution")
		var load_img = Image.new()
		load_img.load_png_from_buffer(Marshalls.base64_to_raw(question))
		var texture = ImageTexture.create_from_image(load_img)
		$TextureRect.texture = texture
	else:
		
		print(img.error)

func _on_button_pressed():
	$HttpRequest.request(url)
