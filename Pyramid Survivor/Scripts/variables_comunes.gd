extends Node2D

###########################
########VARIABLES##########
###########################

#Player
#@onready
#var player = preload("res://Scenes/player.tscn")
var posicion_player = Vector2(0,0)


#Velocidades
var vel_player = 400
var vel_enemigo = 200

#Vida Player
var vida_player_max = 4
var vida_player = vida_player_max
var ruta_vida_spr='/root/Juego/InterfazSuperior/Vida/Vida_Sprite/vida_'

#Senales
signal muertePlayer
signal entreOleadas

#Bolsa huesos
var huesos_act = 0
var huesos_ind = 4

#Total enemigos
var max_enemigos = 255
var enemigos_cant = 0
var enemigo_ind = 140

#Porcentaje
var porcentaje_actual = 0
var porcentaje_x_seg = 1

#Oleadas
var nOleadas = 0 

###########################
########FUNCIONES##########
###########################

func _ready():
	get_node('/root/Juego/Oleada').text = ""
func _process(delta):
	if max_enemigos < enemigos_cant:
		finOleada(false,"OUT OF MEMORY ERROR"+str(nOleadas))

#Player
func danoPlayer():
	if vida_player>0:
		
		#Recibimos golpe
		emit_signal("hit")
		
		#Restamos un corazon de vida
		var vida_icono = get_node(ruta_vida_spr+str(vida_player-1))
		vida_icono.hide()
		vida_player-=1
		
	if vida_player==0:
		finOleada(false,"GAME OVER:"+str(nOleadas))

#Enemigos
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
func matarEnemigo(muerte_espada):
	enemigos_cant-=enemigo_ind
	if muerte_espada:
		huesos_act+=huesos_ind
func matarEnemigosTODOS():
	get_node('/root/Juego/Spawner').stop()
	for enemigos in get_node('/root/VariablesComunes').get_children ():
		enemigos.queue_free()
	pass

#Oleadas
func limpiarDatosInterfaz():
	porcentaje_actual = 0
	enemigos_cant = 0
	
func _on_porcentaje_oleada_timeout():
	porcentaje_actual+=porcentaje_x_seg
	$InterfazSuperior/Porcentaje.text=str(porcentaje_actual)+"%"
	if porcentaje_actual >= 100:
		finOleada(true,"END STAGE: "+str(nOleadas))
		
func finOleada(ganado, mensaje):
	limpiarDatosInterfaz()
	matarEnemigosTODOS()
	
	get_node('/root/Juego/PorcentajeOleada').stop()
	
	var labelOleada=get_node('/root/Juego/EntreOleadas/LabelOleada')
	labelOleada.text=mensaje
	
	if !ganado:
		print("envio")
		emit_signal("muertePlayer")
	else:
		emit_signal("entreOleadas")
		nOleadas += 1
		
	labelOleada.show()
func seguirOleada():
	print("AAAAAAAAAAA")
