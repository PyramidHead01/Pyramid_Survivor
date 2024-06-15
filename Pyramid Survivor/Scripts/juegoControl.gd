extends Node

func _ready():
	$Audios/audioFondoSon.play()
	$EntreOleadas/botonSiguienteOleada/CollisionShape2D.set_deferred("disabled", true)
	$EntreOleadas/botonTienda/CollisionShape2D.set_deferred("disabled", true)
	pass

func _on_porcentaje_oleada_timeout():
	VariablesComunes.porcentaje_actual+=(VariablesComunes.porcentaje_x_seg+(VariablesComunes.porcentaje_aumento*VariablesComunes.porcentaje_n))
	$InterfazSuperior/Porcentaje.text=str(VariablesComunes.porcentaje_actual)+"%"
	if VariablesComunes.porcentaje_actual >= 100:
		$Audios/audioFondoSon.stop()
		VariablesComunes.finOleada(true,"WAVE COMPLETED\n"+"REACHED WAVE: "+str(VariablesComunes.nOleadas))
	pass
