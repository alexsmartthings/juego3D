extends CharacterBody3D
# 2) Debe tener un class_name Player
class_name Player
# 3) Declarar la variable booleana llamada can_move y ponerle el valor false.
var can_move: bool = false
# 4) Declarar la variable de tipo Vector2 llamada axis.
var axis: Vector2
# 5) Declarar la variable de tipo Vector3 llamada rot.
var rot: Vector3
# 6) Declarar una variable de tipo float llamada angle.
var angle: float
# 7) Declarar una variable constante llamada SPEED y ponerle un valor 12.
const SPEED: float = 12
# ------MEJORA DE SPRINT-------
const SPRINT_SPEED: float = 20
# 8) Declarar una variable constante llamada GRAVITY y ponerle el valor 2.
const GRAVITY: float = 2
# 9) Declarar una variable constante de tipo entero llamada JUMP y ponerle el valor 30.
const JUMP: int = 30

func _process(_delta):
	match can_move:
		true:
		# 10) Llamar a motion_ctrl()
			motion_ctrl()

func _input(event):
	if is_on_floor() and event.is_action_pressed("ui_accept"):
 # velocity es una variable afectada por move_and_slide, asi que no es necesario multiplicar por delta.
 # 11) velocity en la variable y debe ser igual a JUMP.
 # 12) $AudioJump debe llamar a la función play()
		velocity.y = JUMP
		$AudioJump.play()
		# --------MEJORA FOV CAMARA-----------------
	if event is InputEventKey and event.keycode == KEY_Z:
		# Obtenemos la cámara activa actual
		var camara = get_viewport().get_camera_3d()
		
		# Verificamos que la cámara exista para evitar errores
		if camara:
			if event.pressed:
				camara.fov = 45 # Zoom activado (acerca la imagen)
			else:
				camara.fov = 75 # Zoom desactivado (vuelve a la normalidad)

# Función para retornar la dirección pulsada.
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
 # 13) Devolver axis.normalized()
	return axis.normalized()
	
func motion_ctrl() -> void:
	var current_speed = SPEED
	if Input.is_action_pressed("ui_shift"):
		current_speed = SPRINT_SPEED
# 14) velocity en su valor x debe ser igual a get_axis().x multiplicado por SPEED
	velocity.x = get_axis().x * current_speed
# 15) velocity en su valor y menos igual a GRAVITY
	velocity.y -= GRAVITY
# 16) velocity en su valor z debe ser igual a get_axis().y multiplicado por –SPEED (en valor negativo.
	velocity.z = get_axis().y * -current_speed

	if not get_axis().x == 0 or not get_axis().y == 0:
		angle = atan2(get_axis().x, -get_axis().y)
# 17) rot debe ser igual a get_rotation().
		rot = get_rotation()
# 18) rot.y debe ser igual a angle.
		rot.y = angle
# 19) llamar a set_rotation() y le pasamos como parámetro rot (dentro del paréntesis).
		set_rotation(rot)
	move_and_slide()
	'''ANIMACIONES'''
	match is_on_floor():
		true:
			if not get_axis().x == 0 or not get_axis().y == 0:
	# 20) Llamar a $AnimationPlayer.play() y entre paréntesis ponemos entrecomillado Run
				$AnimationPlayer.play("Run")
	# 21) $GPUParticles3D.emitting debe tener el valor true
				$GPUParticles3D.emitting = true
			else:
	# 22) Llamar a $AnimationPlayer.play() y entre paréntesis ponemos entrecomillado Idle
				$AnimationPlayer.play("Idle")
	# 23) $GPUParticles3D.emitting debe tener el valor false
				$GPUParticles3D.emitting = false
		false:
			if velocity.y > 0:
	# 24) Llamar a $AnimationPlayer.play() y entre paréntesis ponemos entrecomillado Jump
				$AnimationPlayer.play("Jump")
	# 25) $GPUParticles3D.emitting debe tener el valor false
				$GPUParticles3D.emitting = false	

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Wave":
			can_move = true
