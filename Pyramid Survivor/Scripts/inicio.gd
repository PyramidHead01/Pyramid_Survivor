extends Control

var mensaje = true
var rickRoll = false

var inicio = true

var textoCreditos = "CREDITOS"
var textoInstrucciones = "INSTRUCCIONES"

###########################
########FUNC_BASIC#########
###########################
func _ready():
	$inicioSon.play()
	$OpcionesInicio.hide()
func _process(delta):
	
	if Input.is_action_pressed('ui_accept'):
		if rickRoll:
			$inicioSon.play()
			$rickRollSon.stop() 
			$OpcionesInicio.show()
			$OpcionesInicio/VBoxContainer/play_bot.grab_focus()
			rickRoll = false
		if mensaje:
			$Mensaje.hide()
			$OpcionesInicio.show()
			$OpcionesInicio/VBoxContainer/play_bot.grab_focus()
			mensaje = false
			if inicio:
				inicio = false
				$TimerRickRoll.start()

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
	aparecerMensaje(textoCreditos)
func _on_instr_bot_pressed():
	botSonido()
	aparecerMensaje(textoInstrucciones)

func aparecerMensaje(texto):
	$OpcionesInicio.hide()
	$TimerRickRoll.stop()
	$Mensaje/Label.text = texto
	$Mensaje.show()
	mensaje = true

func botSonido():
	$botonSon.play()

func _on_timer_timeout():
	$inicioSon.stop()
	$rickRollSon.play() 
	$OpcionesInicio.hide()
	rickRoll = true
	print("RICK ROLL")
