extends Timer

@onready
var enemigo_base = preload("res://Scenes/enemigo.tscn")

func _on_timeout():
	VariablesComunes.nuevoEnemigo(enemigo_base)

