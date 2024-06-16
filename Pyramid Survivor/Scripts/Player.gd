extends CharacterBody2D

func _ready():
	$Espada/CollisionShape2D.set_deferred("disabled", true)

#Movimiento player (Solo se mueve a un punto a la vez)
func ui_movimiento():
	VariablesComunes.posicion_player=position
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_down') || Input.is_action_pressed('ui_up'):
		$AnimatedSprite2D.play("andar")
	elif Input.is_action_pressed('ui_left'):
		$AnimatedSprite2D.play("andarIzquierda")
	else:
		$AnimatedSprite2D.play("quieto")
		
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		$Espada.rotation_degrees = 0
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$Espada.rotation_degrees = 180
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$Espada.rotation_degrees = 90
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$Espada.rotation_degrees = 270

	velocity = velocity.normalized() * VariablesComunes.vel_player

	position.x = clamp(position.x, 0, 1024)
	position.y = clamp(position.y, 199, 903)

#Mezcladillo de cosas, movimiento y atacar por ahora
func _physics_process(delta):
	if !VariablesComunes.parar:
		ui_movimiento()
		move_and_slide()
		if VariablesComunes.muertePlayer:
			queue_free()
		if Input.is_action_just_pressed ('ui_accept'):
			$Espada/CollisionShape2D.set_deferred("disabled", false)
			$Espada.show()
			$Espada/TiempoEspada.start()
			$Audio/EspadaSon.play()

func _on_juego_muerte_player():
	queue_free()
