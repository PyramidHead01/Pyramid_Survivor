extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$EntreOleadas/botonSiguienteOleada/CollisionShape2D.set_deferred("disabled", true)
	$EntreOleadas/botonTienda/CollisionShape2D.set_deferred("disabled", true)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_porcentaje_oleada_timeout():
	#VariablesComunes.interfaz_porcentaje()
	VariablesComunes.porcentaje_actual+=(VariablesComunes.porcentaje_x_seg+(VariablesComunes.porcentaje_aumento*VariablesComunes.porcentaje_n))
	$InterfazSuperior/Porcentaje.text=str(VariablesComunes.porcentaje_actual)+"%"
	if VariablesComunes.porcentaje_actual >= 100:
		VariablesComunes.finOleada(true,"END STAGE: "+str(VariablesComunes.nOleadas))
	pass
