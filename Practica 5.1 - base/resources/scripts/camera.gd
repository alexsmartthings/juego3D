extends Camera3D

@export var player: CharacterBody3D

func _ready():
	position.y = 9

func _process(_delta):
	if player:
		global_position.x = player.global_position.x
		global_position.z = player.global_position.z + 10
	
