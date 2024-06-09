extends Node2D

signal hoverBotonTienda

#func _ready():
#	apagarEntreOleadas()
	
#func _process(delta):
	#print($botonTienda/CollisionShape2D.disabled)

#func _on_juego_entre_oleadas():
#	encenderEntreOleadas();

##########
func apagarEntreOleadas():
	queue_free()

func _on_boton_tienda_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.vel_player = 0
		$Tienda.show()
		emit_signal("hoverBotonTienda")
func _on_boton_siguiente_oleada_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.seguirOleada()
		apagarEntreOleadas()
