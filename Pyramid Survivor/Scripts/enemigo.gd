extends CharacterBody2D

var dist = Vector2.ZERO
var mov_x = false

#Emite la se;al que hara da;o al player
func _on_area_2d_body_entered(body):
	if(body.get("name")=="Player"):
		VariablesComunes.danoPlayer()
		queue_free()

		
func _physics_process(delta):

	#Calculamos la distancia a la que esta el player
	dist=position.direction_to(VariablesComunes.posicion_player)

	#Si detecta que esta mas cerca el eje x, ira a este, sino, al y, de estar ambos muy cerca, priorizara el ultimo al que ha ido
	if snapped(abs(dist.x),0.1) > snapped(abs(dist.y),0.1):
		dist.y=0
		mov_x = true
	elif snapped(abs(dist.x),0.1) < snapped(abs(dist.y),0.1):
		dist.x=0
		mov_x = false
	else:
		if mov_x:
			dist.y=0
		else:
			dist.x=0
	
	#Metemos la distancia en el velocity, y le damos tambien la velocidad que tenemos guardada
	velocity = dist * VariablesComunes.vel_enemigo
			
	move_and_slide()
