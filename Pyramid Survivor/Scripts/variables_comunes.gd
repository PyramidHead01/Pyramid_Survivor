extends Node2D

###########################
########VARIABLES##########
###########################

#Player
var posicion_player = Vector2(0,0)

#Velocidades
var vel_player = 400
var vel_player_almacenada = vel_player
var vel_enemigo = 200

#Vida Player
var vida_player_max = 4
var vida_player = vida_player_max
var ruta_vida_spr='/root/menuInicio/Juego/InterfazSuperior/Vida/Vida_Sprite'

#Senales
var muertePlayer = false
signal entreOleadas

#Bolsa huesos
var huesos_act = 200
var huesos_ind = 1
var huesos_aumento = 1

#Total enemigos
var max_enemigos = 255
var enemigos_cant = 0
var enemigo_ind = 10
var enemigos_aumento = 2

#Porcentaje
var porcentaje_actual = 0
var porcentaje_aumento = 25
var porcentaje_x_seg = 15
 
#Oleadas
var nOleadas = 0 

###########################
########INSTANCIACIONES####
###########################

@onready
var entre_oleadas = preload("res://Scenes/entre_oleadas.tscn")

###########################
########FUNCIONES##########
###########################
	
func _ready():
	pass
	#get_node('/root/Juego/EntreOleadas/LabelOleada').text = ""
func _process(delta):
	print("B" + str(porcentaje_x_seg))
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
	add_child(enemigo)
	enemigo.position = Vector2(pos_x,pos_y)
	
	#Aumentamos limite
	enemigos_cant+=enemigo_ind
	
	#Escribimos el nuevo valor
	get_node('/root/menuInicio/Juego/InterfazSuperior/Memoria').text = str(VariablesComunes.enemigos_cant)+"/255"
func matarEnemigo(muerte_espada):
	enemigos_cant-=enemigo_ind
	if muerte_espada:
		huesos_act+=huesos_ind
func matarEnemigosTODOS():
	get_node('/root/menuInicio/Juego/Spawner').stop()
	limpiarDatosInterfaz()
	for enemigos in get_node('/root/VariablesComunes').get_children ():
		enemigos.queue_free()
	
#Oleadas
func limpiarDatosInterfaz():
	vida_player = vida_player_max
	porcentaje_actual = 0
	enemigos_cant = 0
	for child in get_node(ruta_vida_spr).get_children():
		child.show()
func _on_porcentaje_oleada_timeout():
	porcentaje_actual+=porcentaje_x_seg
	$InterfazSuperior/Porcentaje.text=str(porcentaje_actual)+"%"
	if porcentaje_actual >= 100:
		finOleada(true,"END STAGE: "+str(nOleadas))
func finOleada(ganado, mensaje):

	get_node('/root/menuInicio/Juego/PorcentajeOleada').stop()
	matarEnemigosTODOS()
	
	var oleada = entre_oleadas.instantiate()
	add_child(oleada)
	
	var labelOleada=get_node('/root/menuInicio/Juego/EntreOleadas/LabelOleada')
	#labelOleada.text=mensaje
	
	if !ganado:
		muertePlayer = true
	else:
		entreOleadas.emit()
		nOleadas += 1

	oleada.show()
func seguirOleada():
	get_node('/root/menuInicio/Juego/InterfazSuperior/Porcentaje').text="0%"
	get_node('/root/menuInicio/Juego/InterfazSuperior/Memoria').text = "0/255"
	
	get_node('/root/menuInicio/Juego/PorcentajeOleada').start()
	get_node('/root/menuInicio/Juego/Spawner').start()
	limpiarDatosInterfaz()

#Tienda
func compraAumentoVida():
	print("Aumento Vida")
	pass
func compraAumentoCalavera():
	huesos_ind += huesos_aumento
func compraAumentoTiempo():
	print("AumentoTiempo")
	print("a"+str(porcentaje_x_seg))
	porcentaje_x_seg = porcentaje_x_seg + porcentaje_aumento
	print(porcentaje_x_seg)
func compraAumentoMemoria():
	print("AumentoMemoria")
	print(enemigos_cant)
	enemigos_cant -= enemigos_aumento
	print(enemigos_cant)
	pass
