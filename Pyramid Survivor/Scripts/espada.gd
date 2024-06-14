extends Area2D

#Activado espada
func _on_tiempo_espada_timeout():
	hide()

func _on_body_entered(body):
	if body.get("name").begins_with("Enemigo"):
		VariablesComunes.danarEnemigo(body)

