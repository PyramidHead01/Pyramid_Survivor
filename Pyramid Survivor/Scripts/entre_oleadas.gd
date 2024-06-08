extends Node2D

func _ready():
	apagarEntreOleadas()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_juego_entre_oleadas():
	encenderEntreOleadas();

##########
func apagarEntreOleadas():
	$LabelOleada.hide()
	$botonSiguienteOleada.hide()
	$botonSiguienteOleada/CollisionShape2D.disabled = true
func encenderEntreOleadas():
	$LabelOleada.show()
	$botonSiguienteOleada.show()
	$botonSiguienteOleada/CollisionShape2D.disabled = false


func _on_boton_siguiente_oleada_area_entered(area):
	apagarEntreOleadas()
	VariablesComunes.seguirOleada()
