extends Node2D

signal hoverBotonTienda

func _on_boton_tienda_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.vel_player = 0
		$Tienda.show()
		emit_signal("hoverBotonTienda")
func _on_boton_siguiente_oleada_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.seguirOleada()
		queue_free()
