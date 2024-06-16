extends Node2D

signal hoverBotonTienda

func _ready():
	hide()

func _on_boton_tienda_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.parar = true
		$Tienda.show()
		emit_signal("hoverBotonTienda")
func _on_boton_siguiente_oleada_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.seguirOleada()
			
		$botonSiguienteOleada/CollisionShape2D.set_deferred("disabled", true)
		$botonTienda/CollisionShape2D.set_deferred("disabled", true)

		hide()

func _on_tienda_compra(id):
	get_node("/root/menuInicio/Juego/Audios/botonSon").play()
	if id != null:
		var precio = get_node("Tienda/TiendaUI/Precios").get_child(id)
		precio = int(precio.text.replace("x", ""))
		if VariablesComunes.huesos_act >= precio:
			VariablesComunes.huesos_act -= precio
			match id:
				#ViDA
				0:
					precio += 1
					get_node("Tienda/TiendaUI/Precios").get_child(id).text = "x"+str(precio)
					if VariablesComunes.vida_player_max+1<=VariablesComunes.vida_player_max_total:
						VariablesComunes.vida_player_max+=1
						var i = 0
						for child in get_node(VariablesComunes.ruta_vida_spr).get_children():
							if VariablesComunes.vida_player_max > i:
								child.show()
							i+= 1
					if VariablesComunes.vida_player_max+1>VariablesComunes.vida_player_max_total:
						print("TOPE")
						get_node("Tienda/TiendaUI/Precios").get_child(id).text = "xMAX"
						VariablesComunes.huesos_act += precio-1
				#Huesos/DANO
				1:
					precio += 1
					get_node("Tienda/TiendaUI/Precios").get_child(id).text = "x"+str(precio)
					VariablesComunes.dano_n+=1
					#if VariablesComunes.huesos_n <= 4:

					#if VariablesComunes.huesos_n > 4:
					#	get_node("Tienda/TiendaUI/Precios").get_child(id).text = "xMAX"
					#	VariablesComunes.huesos_act += precio
				#Porcentaje/HUESOS
				2:
					precio += 1
					get_node("Tienda/TiendaUI/Precios").get_child(id).text = "x"+str(precio)
					VariablesComunes.huesos_n+=1

				#ENEMIGOS/PORCENTAJE
				3:
					precio += 1
					get_node("Tienda/TiendaUI/Precios").get_child(id).text = "x"+str(precio)
					VariablesComunes.porcentaje_n+=1
				#Dano
				4:
					precio += 1
					get_node("Tienda/TiendaUI/Precios").get_child(id).text = "x"+str(precio)
					VariablesComunes.enemigos_n-=1
				null:
					print("Salir")

