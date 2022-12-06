extends Control

var webApiKey = "AIzaSyBeuDBZk2H7DoeafeZJPMAW3n9V2H2ZhjM"
var signupUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
var loginUrl  = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="


func _loginSignup(url: String, email: String, password: String):
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
		print("You are signed UP")
		get_tree().change_scene_to_file("res://login.tscn")
		
	else:
		print(response.error)


func _on_btn_login_pressed():
	$CanvasLayer/VBoxContainer/txt_Email.text = ""
	$CanvasLayer/VBoxContainer/txt_password.text = ""
	get_tree().change_scene_to_file("res://login.tscn")


func _on_btn_sign_up_pressed():
	var url = signupUrl + webApiKey
	var email = $CanvasLayer/VBoxContainer/txt_Email.text
	var password = $CanvasLayer/VBoxContainer/txt_password.text
	_loginSignup(url, email, password)
	$CanvasLayer/VBoxContainer/txt_Email.text = ""
	$CanvasLayer/VBoxContainer/txt_password.text = ""
	print("you are registered")
