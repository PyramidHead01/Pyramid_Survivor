extends Node2D

signal hoverBotonTienda

func _ready():
	apagarEntreOleadas()

func _on_juego_entre_oleadas():
	encenderEntreOleadas();

##########
func apagarEntreOleadas():
	$botonSiguienteOleada/CollisionShape2D.disabled = true
	$botonTienda/CollisionShape2D.disabled = true
	$LabelOleada.hide()
	$botonSiguienteOleada.hide()
	$botonTienda.hide()
func encenderEntreOleadas():
	$botonSiguienteOleada/CollisionShape2D.disabled = false
	$botonTienda/CollisionShape2D.disabled = false
	$LabelOleada.show()
	$botonSiguienteOleada.show()
	$botonTienda.show()

func _on_boton_siguiente_oleada_area_entered(area):
	apagarEntreOleadas()
	VariablesComunes.seguirOleada()

func _on_boton_tienda_area_entered(area):
	VariablesComunes.vel_player = 0
	$Tienda.show()
	emit_signal("hoverBotonTienda")
