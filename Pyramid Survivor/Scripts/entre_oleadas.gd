extends Node2D

signal hoverBotonTienda

func _ready():
	hide()

func _on_boton_tienda_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.vel_player = 0
		$Tienda.show()
		emit_signal("hoverBotonTienda")
func _on_boton_siguiente_oleada_body_entered(body):
	if body.get("name")=="Player":
		VariablesComunes.seguirOleada()
			
		$botonSiguienteOleada/CollisionShape2D.set_deferred("disabled", true)
		$botonTienda/CollisionShape2D.set_deferred("disabled", true)
		
		#$botonSiguienteOleada/CollisionShape2D.disabled = true
		#$botonTienda/CollisionShape2D.disabled = true
		hide()

func _on_tienda_compra(id):
	var precio = get_node("Tienda/TiendaUI/Precios").get_child(id)
	precio = int(precio.text.replace("x", ""))
	if VariablesComunes.huesos_act >= precio:
		VariablesComunes.huesos_act -= precio
		match id:
			0:
				VariablesComunes.vida_player_max+=1
				var i = 0
				for child in get_node(VariablesComunes.ruta_vida_spr).get_children():
					if VariablesComunes.vida_player_max > i:
						child.show()
					i+= 1
			1:
				VariablesComunes.huesos_n+=1
			2:
				VariablesComunes.porcentaje_n+=1
			3:
				VariablesComunes.enemigos_n-=1
			4:
				VariablesComunes.dano_n+=1

