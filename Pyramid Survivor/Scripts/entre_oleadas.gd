extends Node2D

func _ready():
	apagarEntreOleadas()

func _on_juego_entre_oleadas():
	encenderEntreOleadas();

##########
func apagarEntreOleadas():
	$botonSiguienteOleada/CollisionShape2D.disabled = true
	$LabelOleada.hide()
	$botonSiguienteOleada.hide()
func encenderEntreOleadas():
	$botonSiguienteOleada/CollisionShape2D.disabled = false
	$LabelOleada.show()
	$botonSiguienteOleada.show()

func _on_boton_siguiente_oleada_area_entered(area):
	apagarEntreOleadas()
	VariablesComunes.seguirOleada()
