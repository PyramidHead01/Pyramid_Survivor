extends Timer

@onready
var enemigo_base = preload("res://Scenes/enemigo.tscn")

func _on_timeout():
	for i in VariablesComunes.num_enemigos_instanciados:
		VariablesComunes.nuevoEnemigo(enemigo_base)
