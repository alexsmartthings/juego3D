extends Path3D

@export var speed : int = 5

func _process(delta):
	$PathFollow3D.progress += speed * delta
