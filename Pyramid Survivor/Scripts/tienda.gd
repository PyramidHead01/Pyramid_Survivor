extends Node2D

var huesos_n = 1
var porcentaje_n = 1
var enemigos_n = 1
var vida_n = 1


signal compra

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var n = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_entre_oleadas_hover_boton_tienda():
	$TiendaUI/CenterContainer/HBoxContainer/botones/vidaBoton.grab_focus()

func _on_vida_boton_pressed():
	compra.emit(0)
	#comprar(0, porcentaje_n)
func _on_calavera_boton_pressed():
	compra.emit(1)
	#comprar(1, porcentaje_n)
func _on_tiempo_boton_pressed():
	compra.emit(2)
	#print("AAQ")
	#porcentaje_n += 1
	#comprar(2, porcentaje_n)
func _on_memoria_boton_pressed():
	compra.emit(3)
	#comprar(3, porcentaje_n)
"""
func comprar(id):
	var precio = get_node("TiendaUI/Precios").get_child(id)
	#precio = precio.text
	precio = int(precio.text.replace("x", ""))
	if VariablesComunes.huesos_act >= precio:
		VariablesComunes.huesos_act -= precio
		match id:
			0:
				pass
				#VariablesComunes.compraAumentoVida()
			1:
				pass
				#VariablesComunes.compraAumentoCalavera()
			2:
				VariablesComunes.porcentaje_tienda_n += 1
				VariablesComunes.compraAumentoTiempo(porcentaje_n)
			3:
				pass
				#VariablesComunes.compraAumentoMemoria()
"""

func _on_salir_boton_pressed():
	VariablesComunes.vel_player = VariablesComunes.vel_player_almacenada
	hide()

