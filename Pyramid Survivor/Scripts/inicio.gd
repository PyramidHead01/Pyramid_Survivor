extends Control

var mensaje = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if mensaje:
		$OpcionesInicio.hide()
	else:
		$Mensaje.hide()
		$OpcionesInicio/VBoxContainer/play_bot.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('ui_cancel') && mensaje:
		$Mensaje.hide()
		$OpcionesInicio.show()
		$OpcionesInicio/VBoxContainer/play_bot.grab_focus()

func _on_play_bot_pressed():
	print("JUGAR")
	var scene = load("res://Scenes/juego.tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
	$OpcionesInicio.hide()
func _on_cred_bot_pressed():
	print("CREDITOS")
func _on_instr_bot_pressed():
	print("INSTRUCCIONES")

func _on_timer_timeout():
	print("RICK ROLL")
