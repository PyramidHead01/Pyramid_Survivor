extends Timer

@onready
var enemigo_base = preload("res://Scenes/enemigo.tscn")

func _on_timeout():
	
	#Creamos una posicion aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pos_x = rng.randi_range(0, 256)
	var pos_y = rng.randi_range(0, 240)
	
	#Instanciamos un enemigo, se hace hijo, y se pone en una pos random
	var enemigo = enemigo_base.instantiate()
	add_child(enemigo)
	enemigo.position = Vector2(pos_x,pos_y)
