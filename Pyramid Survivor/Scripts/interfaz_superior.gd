extends Control

func _process(delta):
	#$Memoria.text = str(VariablesComunes.enemigos_cant)+"/255"
	$Calavera/Label.text = "x" + str(VariablesComunes.huesos_act)
