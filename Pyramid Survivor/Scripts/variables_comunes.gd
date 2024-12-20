extends Node2D

###########################
########VARIABLES##########
###########################

var rutaJuego = '/root/menuInicio/Juego'

#Player
var posicion_player = Vector2(0,0)
var parar = false

#Dano
var dano_total = 20
var dano_up = 10
var dano_n = 0

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
var huesos_act = 15
var huesos_ind = 10
var huesos_aumento = 5
var huesos_n = 0

#Total enemigos
var max_enemigos = 255
var enemigos_cant = 0
var enemigo_ind = 5
var enemigos_aumento = 10
var enemigos_n = 0
var num_enemigos_instanciados = 1

#Porcentaje
var porcentaje_actual = 0
var porcentaje_aumento = 1
var porcentaje_x_seg = 5
var porcentaje_n = 0

#Oleadas
var nOleadas = 0 

@onready
var entre_oleadas = preload("res://Scenes/entre_oleadas.tscn")


###########################
########FUNCIONES##########
###########################

func _process(delta):
	if max_enemigos < enemigos_cant:
		finOleada(false,"OUT OF MEMORY ERROR\n"+"TOTAL STAGES: "+str(nOleadas))
	
#	if muertePlayer && Input.is_action_just_pressed ('ui_accept'):
#		print("FIN")
#		get_tree().reload_current_scene()
#		pass

#Player
func danoPlayer():
	if vida_player>0:
		#Restamos un corazon de vida
		var vida_icono = get_node(ruta_vida_spr+"/vida_"+str(vida_player-1))
		vida_icono.hide()
		vida_player-=1
		if vida_player>0:
			get_node(rutaJuego+'/Audios/DanoPlayerSon').play()
	if vida_player==0:
		get_node(rutaJuego+'/Audios/muertePlayerSon').play()
		finOleada(false,"YOU DIED\n"+"TOTAL STAGES: "+str(nOleadas))
func matarPlayer(node):
	node.queue_free()
	print("MUERTE")

#Enemigos
func nuevoEnemigo(enemigo_base):
	#Creamos una posicion aleatoria
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var int_pos = rng.randi_range(0,1)
	var pos_x = 0
	if int_pos == 0:
		pos_x = 0
	else:
		pos_x = 984
	var pos_y = rng.randi_range(200, 960)
	
	#Instanciamos un enemigo, se hace hijo, y se pone en una pos random
	var enemigo = enemigo_base.instantiate()
	get_node(rutaJuego+'/Audios/instanciarEnemigoSon').play()
	get_node(rutaJuego+'/Enemigos').add_child(enemigo,true)
	enemigo.position = Vector2(pos_x,pos_y)
	
	#Aumentamos limite
	interfaz_enemigos()
	
	#Escribimos el nuevo valor
	get_node(rutaJuego+'/InterfazSuperior/Memoria').text = str(VariablesComunes.enemigos_cant)+"/255"
func danarEnemigo(nodoEnemigo):
	#nodoEnemigo.vida
	
	nodoEnemigo.vida-=(dano_total+(dano_up*dano_n))
	
	var dist=nodoEnemigo.position.direction_to(posicion_player)
	
	var retraso = 200
	
	if dist.x >= dist.y:
		dist = dist.y
		if dist > 0:
			nodoEnemigo.position = Vector2(nodoEnemigo.position.x-retraso,nodoEnemigo.position.y)
		else:
			nodoEnemigo.position = Vector2(nodoEnemigo.position.x,nodoEnemigo.position.y+retraso)
	else:
		dist = dist.x
		if dist > 0:
			nodoEnemigo.position = Vector2(nodoEnemigo.position.x,nodoEnemigo.position.y-retraso)
		else:
			nodoEnemigo.position = Vector2(nodoEnemigo.position.x+retraso,nodoEnemigo.position.y)
		
	if nodoEnemigo.vida <= 0:
		nodoEnemigo.queue_free()
		matarEnemigo(true)
	pass
func matarEnemigo(muerte_espada):
	enemigos_cant-=enemigo_ind
	get_node(rutaJuego+'/Audios/muerteEnemigoSon').play()
	if muerte_espada:
		interfaz_huesos()
func matarEnemigosTODOS():
	get_node(rutaJuego+'/Spawner').stop()
	limpiarDatosInterfaz()
	for enemigos in get_node(rutaJuego+'/Enemigos').get_children ():
		enemigos.queue_free()

#Oleadas
func limpiarDatosInterfaz():
	vida_player = vida_player_max
	porcentaje_actual = 0
	enemigos_cant = 0
	var i = 0
	for child in get_node(ruta_vida_spr).get_children():
		if vida_player_max > i:
			child.show()
		i+= 1
func finOleada(ganado, mensaje):
	print(vida_player)
	if ganado:
		get_node(rutaJuego+'/Audios/finOleadaSon').play()
	else:
		get_node(rutaJuego+'/Audios/muertePlayerSon').play()
	get_node(rutaJuego+'/Audios/audioFondoSon').stop()
	get_node(rutaJuego+'/PorcentajeOleada').stop()
	matarEnemigosTODOS()
	
	var oleada = get_node(rutaJuego+'/EntreOleadas') 
	
	var labelOleada=get_node(rutaJuego+'/EntreOleadas/LabelOleada')
	labelOleada.text = mensaje
	if !ganado:
		muertePlayer = true
	else:
		entreOleadas.emit()
		nOleadas += 1


	get_node(rutaJuego+'/EntreOleadas/botonSiguienteOleada/CollisionShape2D').set_deferred("disabled", false)
	get_node(rutaJuego+'/EntreOleadas/botonTienda/CollisionShape2D').set_deferred("disabled", false)

	oleada.show()
func seguirOleada():
	aumentarDificultad()
	get_node(rutaJuego+'/Audios/audioFondoSon').play()
	get_node(rutaJuego+'/InterfazSuperior/Porcentaje').text="0%"
	get_node(rutaJuego+'/InterfazSuperior/Memoria').text = "0/255"
	
	get_node(rutaJuego+'/PorcentajeOleada').start()
	get_node(rutaJuego+'/Spawner').start()
	
	limpiarDatosInterfaz()
func aumentarDificultad():
	#porcentaje
	if porcentaje_x_seg > 1:
		porcentaje_x_seg -= 1
	#num_enemigos_instanciados
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var enemigoExtra = rng.randi_range(0,1)

	if enemigoExtra == 1 && num_enemigos_instanciados < 4:
		num_enemigos_instanciados += 1
	
	pass

#Tienda
func interfaz_huesos():
	huesos_act+=(huesos_ind+(huesos_aumento*huesos_n))
func interfaz_porcentaje():
	porcentaje_actual+=(porcentaje_x_seg+(porcentaje_aumento*porcentaje_n))
func interfaz_enemigos():
	enemigos_cant+=enemigo_ind+(enemigos_aumento*enemigos_n)
