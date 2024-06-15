extends Node2D

var huesos_n = 1
var porcentaje_n = 1
var enemigos_n = 1
var vida_n = 1


signal compra

func _on_entre_oleadas_hover_boton_tienda():
	$TiendaUI/CenterContainer/HBoxContainer/botones/vidaBoton.grab_focus()

func _on_vida_boton_pressed():
	compra.emit(0)
func _on_calavera_boton_pressed():
	compra.emit(1)
func _on_tiempo_boton_pressed():
	compra.emit(2)
func _on_memoria_boton_pressed():
	compra.emit(3)
func _on_dano_boton_pressed():
	compra.emit(4)

func _on_salir_boton_pressed():
	compra.emit(null)
	VariablesComunes.parar = false
	#VariablesComunes.vel_player = VariablesComunes.vel_player_almacenada
	hide()


