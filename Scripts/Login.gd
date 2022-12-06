extends Control

var webApiKey = "AIzaSyBeuDBZk2H7DoeafeZJPMAW3n9V2H2ZhjM"
var loginUrl  = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="


func _login(url: String, email: String, password: String):
	var http = $HttpRequest
	var jsonObject = JSON.new()
	var body = jsonObject.stringify({'email' : email, 'password' : password})
	var headers = ['Content-Type: application/json']
	var error = await http.request(url, headers, false, HTTPClient.METHOD_POST, body)

func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	#if request is ok
	if (response_code == 200):
		print(response)
		print("You are logged in")
		get_tree().change_scene_to_file("res://GameUI.tscn")
	else:
		print(response.error)


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://SignUP.tscn")

func _on_texture_button_2_pressed():
	var url = loginUrl + webApiKey
	var email = $CanvasLayer/VBoxContainer/txt_Email.text
	var password = $CanvasLayer/VBoxContainer/txt_password.text
	_login(url, email, password)
	$CanvasLayer/VBoxContainer/txt_Email.text = ""
	$CanvasLayer/VBoxContainer/txt_password.text = ""
