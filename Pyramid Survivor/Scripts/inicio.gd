extends Control

var mensaje = false

###########################
########FUNC_BASIC#########
###########################
func _ready():
	$inicioSon.play()
	if mensaje:
		$OpcionesInicio.hide()
	else:
		$Mensaje.hide()
		$OpcionesInicio/VBoxContainer/play_bot.grab_focus()
func _process(delta):
	if Input.is_action_pressed('ui_cancel') && mensaje:
		$Mensaje.hide()
		$OpcionesInicio.show()
		$OpcionesInicio/VBoxContainer/play_bot.grab_focus()

###########################
########BOTONES############
###########################
func _on_play_bot_pressed():
	$inicioSon.stop()
	botSonido()
	var scene = load("res://Scenes/juego.tscn")
	var scene_instance = scene.instantiate()
	add_child(scene_instance)
	$OpcionesInicio.hide()
	$TimerRickRoll.stop()
func _on_cred_bot_pressed():
	botSonido()
	$TimerRickRoll.stop()
	print("CREDITOS")
func _on_instr_bot_pressed():
	botSonido()
	$TimerRickRoll.stop()
	print("INSTRUCCIONES")


func botSonido():
	$botonSon.play()


func _on_timer_timeout():
	$inicioSon.stop()
	$rickRollSon.play() 
	print("RICK ROLL")
