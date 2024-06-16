extends Control

var mensaje = true

var inicio = true

var textoCreditos = "GAME CREATED BY HUGO (PYRAMID HEAD) 

NES JAM 2024 (https://itch.io/jam/nes-jam2024)

SOFTWARE USED:
GODOT 4
ASEPRITE
AUDACITY
FAMITRACKER
JSFXR

ADDITIONAL THANKS:
TheWolfBunny64 (NES TEXT FONT)
P. BLEY (EMOTIONAL SUPPORT)
Doctor_Succubus (JAM AUTHOR)

ADDITIONAL LINKS:
GITHUB  (https://github.com/PyramidHead01/Pyramid_Survivor)
(ALL THE COMMITS ARE IN SPANISH)
ITCH.IO  (https://pyramidhead83.itch.io/)
(PRESS SPACE TO EXIT)"
var textoInstrucciones = "HOW TO PLAY?

DEFEAT AS MANY ENEMIES AS YOU CAN 
AND TRY NOT TO DIE ON THE ROAD

IF THE ENEMIES EXCEED THE MEMORY LIMIT, 
THE GAME WILL BE BROKEN AND YOU WILL LOSE.

YOU HAVE TO HOLD UNTIL YOU REACH 100% OF THE WAVE

EVERY WAVE IT WILL BE HARDER THAN THE PREVIOUS

CONTROLS:
KEYBOARD ARROWS -> MOVE
SPACE -> ATTACK AND OTHER OPTIONS

(PRESS SPACE TO EXIT)"

###########################
########FUNC_BASIC#########
###########################
func _ready():
	$inicioSon.play()
	$OpcionesInicio.hide()
func _process(delta):
	
	if Input.is_action_pressed('ui_accept') && mensaje:
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
	$Fondo.texture = load("res://Sprites/Final/portadaInicioQR.png")
