extends CharacterBody3D

var speed
const WALK_SPEED = 9
const SPRINT_SPEED = 6.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003
const HIT_STAGGER = 10.0
var JUMP_COUNT = 0
var MAX_JUMP = 2
#bob variables
const BOB_FREQ = 1
const BOB_AMP = 0.2
var t_bob = 0.5




#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# signal
signal player_hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2



# Camera
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var aim_ray = $Head/Camera3D/AimRay
@onready var aim_ray_end = $Head/Camera3D/AimRayEnd





func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-70), deg_to_rad(70))


func _physics_process(delta):
	# Add the gravity.
	
	if is_on_floor():
		JUMP_COUNT = 0
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and JUMP_COUNT < MAX_JUMP:
		velocity.y = JUMP_VELOCITY
		$Head/Agile.value -= 3.5
		JUMP_COUNT +=1
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
		
		var agile = $Head/Agile.value
		if agile <= 1:
			speed = WALK_SPEED
		else:
			$Head/Agile.value -= 0.05
	else:
		speed = WALK_SPEED


	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 15.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 15.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	# Shooting
	
	move_and_slide()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos


func hit(dir):
	emit_signal("player_hit")
	velocity += dir * HIT_STAGGER
	if velocity.length() > SPRINT_SPEED:
		velocity = velocity.normalized() * SPRINT_SPEED
	#var text = $Dead
	$Head/Health.value -= 10
	var healt = $Head/Health.value
	if healt <= 0:
		$Dead.visible = true
		get_tree().paused = true
	if healt >= 1:
		$Dead.visible = false


func hit2(dir):
	emit_signal("player_hit")
	velocity += dir * HIT_STAGGER
	if velocity.length() > SPRINT_SPEED:
		velocity = velocity.normalized() * SPRINT_SPEED
	#var text = $Dead
	$Head/Health.value -= 20
	var healt = $Head/Health.value
	if healt <= 0:
		$Dead.visible = true
		get_tree().paused = true
	if healt >= 1:
		$Dead.visible = false
