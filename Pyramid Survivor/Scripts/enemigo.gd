extends CharacterBody2D

signal hit

#Emite la se;al que hara da;o al player
func _on_area_2d_body_entered(body):
	emit_signal("hit")
