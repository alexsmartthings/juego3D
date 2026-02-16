extends StaticBody3D

func _on_area_3d_body_entered(body):
	if body is Player:
		var gui = get_tree().get_first_node_in_group("GUI")
		if gui:
			gui.get_node("FadeScreen/AnimationPlayer").play("FadeOut")
		
