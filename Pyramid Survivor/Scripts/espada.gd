extends Area2D

#Activado espada
func _on_tiempo_espada_timeout():
	print("Ya no da;o")
	hide()


func _on_body_entered(body):
	print(body)
	
	if(body.get("name")=="Enemigo"):
		body.queue_free()
		print("DANAOOASDOASDOIASD")
