extends Node2D

var posicion_player = Vector2(0,0)

#Velocidades
var vel_player = 400
var vel_enemigo = 200

#Vida Player
var vida_player_max = 6
var vida_player = vida_player_max

#Senales
signal hit

#Total enemigos
var max_enemigos = 255
var enemigos_cant = 0
var enemigo_ind = 3

#Porcentaje
var porcentaje_actual = 0
var porcentaje_x_seg = 5

func _process(delta):
	if max_enemigos < enemigos_cant:
		print("MUERTE")

func danoPlayer():
	emit_signal("hit")
	vida_player-=1
	if vida_player==0:
		muertePlayer()

func muertePlayer():
	print("fin")

func nuevoEnemigo(enemigo_base):
	#Creamos una posicion aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pos_x = rng.randi_range(0, 984)
	var pos_y = rng.randi_range(0, 960)
	
	#Instanciamos un enemigo, se hace hijo, y se pone en una pos random
	var enemigo = enemigo_base.instantiate()
	add_child(enemigo)
	enemigo.position = Vector2(pos_x,pos_y)
	
	#Aumentamos limite
	enemigos_cant+=enemigo_ind

func matarEnemigo():
	enemigos_cant-=enemigo_ind


func _on_porcentaje_oleada_timeout():
	porcentaje_actual+=porcentaje_x_seg
	$InterfazSuperior/Porcentaje.text=str(porcentaje_actual)+"%"
	if porcentaje_actual >= 100:
		print("FIN OLEADA")
