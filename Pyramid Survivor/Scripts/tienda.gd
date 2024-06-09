extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_entre_oleadas_hover_boton_tienda():
	$TiendaUI/CenterContainer/HBoxContainer/botones/vidaBoton.grab_focus()

func _on_vida_boton_pressed():
	comprar(0)
func _on_calavera_boton_pressed():
	comprar(1)
func _on_tiempo_boton_pressed():
	comprar(2)
func _on_memoria_boton_pressed():
	comprar(3)

func comprar(id):
	var precio = get_node("TiendaUI/Precios").get_child(id)
	#precio = precio.text
	precio = int(precio.text.replace("x", ""))
	if VariablesComunes.huesos_act >= precio:
		VariablesComunes.huesos_act -= precio
		match id:
			0:
				VariablesComunes.compraAumentoVida()
			1:
				VariablesComunes.compraAumentoCalavera()
			2:
				VariablesComunes.compraAumentoTiempo()
			3:
				VariablesComunes.compraAumentoMemoria()

func _on_salir_boton_pressed():
	VariablesComunes.vel_player = VariablesComunes.vel_player_almacenada
	hide()

