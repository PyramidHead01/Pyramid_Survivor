extends Area2D

#Activado espada
func _on_tiempo_espada_timeout():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

func _on_body_entered(body):
	if body.get("name").begins_with("Enemigo"):
		VariablesComunes.danarEnemigo(body)
		$SonidoDanoEnemigo.play()
