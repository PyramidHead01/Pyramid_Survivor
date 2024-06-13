extends Node2D

###########################
########VARIABLES##########
###########################

var ARG = 0

var rutaJuego = '/root/menuInicio/Juego'

#Player
var posicion_player = Vector2(0,0)

#Velocidades
var vel_player = 400
var vel_player_almacenada = vel_player
var vel_enemigo = 200

#Vida Player
var vida_player_max_total = 8
var vida_player_max = 4
var vida_player = vida_player_max
var ruta_vida_spr=rutaJuego+'/InterfazSuperior/Vida/Vida_Sprite'
var vida_n = 0

#Senales
var muertePlayer = false
signal entreOleadas

#Bolsa huesos
var huesos_act = 200
var huesos_ind = 1
var huesos_aumento = 10
var huesos_n = 0

#Total enemigos
var max_enemigos = 255
var enemigos_cant = 0
var enemigo_ind = 5
var enemigos_aumento = 10
var enemigos_n = 0

#Porcentaje
var porcentaje_actual = 0
var porcentaje_aumento = 1
var porcentaje_x_seg = 20
var porcentaje_n = 0

#Oleadas
var nOleadas = 0 

@onready
var entre_oleadas = preload("res://Scenes/entre_oleadas.tscn")


###########################
########FUNCIONES##########
###########################
func _ready():
	pass
func _process(delta):
	if max_enemigos < enemigos_cant:
		finOleada(false,"OUT OF MEMORY ERROR"+str(nOleadas))

#Player
func danoPlayer():
	if vida_player>0:
		
		#Restamos un corazon de vida
		var vida_icono = get_node(ruta_vida_spr+"/vida_"+str(vida_player-1))
		vida_icono.hide()
		vida_player-=1
		
	if vida_player==0:
		finOleada(false,"GAME OVER:"+str(nOleadas))
func matarPlayer(node):
	node.queue_free()

#Enemigos
func nuevoEnemigo(enemigo_base):
	#Creamos una posicion aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var pos_x = rng.randi_range(0, 984)
	var pos_y = rng.randi_range(0, 960)
	
	#Instanciamos un enemigo, se hace hijo, y se pone en una pos random
	var enemigo = enemigo_base.instantiate()
	get_node(rutaJuego+'/Enemigos').add_child(enemigo)
	enemigo.position = Vector2(pos_x,pos_y)
	
	#Aumentamos limite
	interfaz_enemigos()
	
	#Escribimos el nuevo valor
	get_node(rutaJuego+'/InterfazSuperior/Memoria').text = str(VariablesComunes.enemigos_cant)+"/255"
func matarEnemigo(muerte_espada):
	enemigos_cant-=enemigo_ind
	if muerte_espada:
		interfaz_huesos()
func matarEnemigosTODOS():
	get_node(rutaJuego+'/Spawner').stop()
	limpiarDatosInterfaz()
	for enemigos in get_node(rutaJuego+'/Enemigos').get_children ():
		enemigos.queue_free()
	
#Oleadas
func limpiarDatosInterfaz():
	#print("VIDA_MAX: "+str(vida_player_max))
	#print("VIDA: "+str(vida_player))
	vida_player = vida_player_max
	porcentaje_actual = 0
	enemigos_cant = 0
	var i = 0
	for child in get_node(ruta_vida_spr).get_children():
		if vida_player_max > i:
			print(child.name)
			child.show()
		i+= 1
func _on_porcentaje_oleada_timeout():
	pass
func finOleada(ganado, mensaje):

	get_node(rutaJuego+'/PorcentajeOleada').stop()
	matarEnemigosTODOS()
	
	#var oleada = entre_oleadas.instantiate()
	var oleada = get_node(rutaJuego+'/EntreOleadas') 
	
	var labelOleada=get_node(rutaJuego+'/EntreOleadas/LabelOleada')
	if !ganado:
		muertePlayer = true
	else:
		entreOleadas.emit()
		nOleadas += 1

	oleada.show()
func seguirOleada():
	get_node(rutaJuego+'/InterfazSuperior/Porcentaje').text="0%"
	get_node(rutaJuego+'/InterfazSuperior/Memoria').text = "0/255"
	
	get_node(rutaJuego+'/PorcentajeOleada').start()
	get_node(rutaJuego+'/Spawner').start()
	limpiarDatosInterfaz()

#Tienda
"""
func compraAumentoVida():
	print("Aumento Vida")
	pass
func compraAumentoCalavera():
	huesos_tienda_n = 1
	#huesos_ind += huesos_aumento
func compraAumentoMemoria():
	print(enemigos_cant)
	enemigos_tienda_n += 1
	#enemigos_cant -= enemigos_aumento
	print(enemigos_cant)
"""

#Tienda
func interfaz_huesos():
	huesos_act+=(huesos_ind+(huesos_aumento*huesos_n))
	pass

func interfaz_porcentaje():
	porcentaje_actual+=(porcentaje_x_seg+(porcentaje_aumento*porcentaje_n))
	pass

func interfaz_enemigos():
	#enemigos_cant+=enemigo_ind
	enemigos_cant+=enemigo_ind+(enemigos_aumento*enemigos_n)
	pass
