extends KinematicBody2D


export(int) var SPEED = 50 * 60
export(float) var DASH_MULTIPLIER = 3

var direction = Vector2(0,1)
onready var ANIM_SPEED = $AnimatedSprite.get_sprite_frames().get_animation_speed($AnimatedSprite.get_animation())


func many2eight_direction():
	$Camera2D/text1.text = String(Vector2(1,0).angle_to(Vector2(-1,0)))
	var possible_dirs = Array()
	for i in range(-1,2):
		for j in range(-1,2):
			possible_dirs.append(Vector2(i,j))
	var least_diff = null
	var least_dir = null
	for dir in possible_dirs:
		var new_diff = 360 + rad2deg(dir.angle_to(self.get_local_mouse_position()))
		if least_diff == null or least_diff >  new_diff:
			least_diff = new_diff
			least_dir = dir
	least_dir.x *= -1 
	least_dir.y *= -1 		
	return least_dir


func _ready():
	set_physics_process(true)
	


func _physics_process(delta):
	var motion = Vector2(0, 0)

	if Input.is_action_pressed('ui_right'):
		motion.x += 1
	if Input.is_action_pressed('ui_left'):
		motion.x += -1
	if Input.is_action_pressed('ui_up'):
		motion.y += -1
	if Input.is_action_pressed('ui_down'):
		motion.y += 1
	
	var dir = many2eight_direction()
	
	$Flashlight.look_at(get_global_mouse_position())
	$Flashlight.rotate(deg2rad(-90))
	
	$Camera2D/text2.text = "motion on"
	if motion == Vector2(0,0):
		$Camera2D/text2.text = "motion off"
		if dir == Vector2(0,1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_down")
		elif dir == Vector2(1,1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_down_right")
		elif dir == Vector2(1,0):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_right")
		elif dir == Vector2(1,-1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_up_right")
		elif dir == Vector2(0,-1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_up")
		elif dir == Vector2(-1,-1):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_up_right")
		elif dir == Vector2(-1,0):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_right")
		elif dir == Vector2(-1,1):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_right")
	elif dir == Vector2(0,1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down")
	elif dir == Vector2(1,1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down_right")
	elif dir == Vector2(1,0):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_right")
	elif dir == Vector2(1,-1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up_right")
	elif dir == Vector2(0,-1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up")
	elif dir == Vector2(-1,-1):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_up_right")
	elif dir == Vector2(-1,0):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_right")
	elif dir == Vector2(-1,1):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_down_right")
	
	var speed = SPEED
	var anim_name = $AnimatedSprite.get_animation()
	if Input.is_action_pressed('ui_dash'):
		speed =  DASH_MULTIPLIER * SPEED
		$AnimatedSprite.get_sprite_frames().set_animation_speed(anim_name, speed)
	else:
		$AnimatedSprite.get_sprite_frames().set_animation_speed(anim_name, ANIM_SPEED)
		
	motion = motion.normalized() * speed * delta
	move_and_slide(motion, Vector2(0,-1))
	
