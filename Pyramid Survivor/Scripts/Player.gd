extends CharacterBody2D

@export var vel = 100

#Movimiento player (Solo se mueve a un punto a la vez)
func ui_movimiento():
	
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		rotation_degrees = 270
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		rotation_degrees = 90
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
		rotation_degrees = 0
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		rotation_degrees = 180
		
	velocity = velocity.normalized() * vel

#Conexion para que el player pierda vida
func _on_enemigo_hit():
	print("Mueltooooooooooooo")

#Mezcladillo de cosas, movimiento y atacar por ahora
func _physics_process(delta):
	ui_movimiento()
	move_and_slide()
	if Input.is_action_pressed('ui_accept'):
		$Espada.show()
		$Espada/TiempoEspada.start()

