extends Node

var posicion_player = Vector2(0,0)

var vel_player = 100
var vel_enemigo = 50

var vida_player_max = 6
var vida_player = vida_player_max

signal hit

func danoPlayer():
	emit_signal("hit")
	vida_player-=1
	if vida_player==0:
		muertePlayer()
	
func muertePlayer():
	print("fin")
	
