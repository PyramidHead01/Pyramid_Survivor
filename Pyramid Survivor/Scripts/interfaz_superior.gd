extends Control

var vida_act = VariablesComunes.vida_player_max

func _process(delta):
	$Memoria.text = str(VariablesComunes.enemigos_cant)+"/256"
	$Calavera/Label.text = "x" + str(VariablesComunes.huesos_act)
