extends KinematicBody2D


export(int) var SPEED = 100 * 60
export(float) var DASH_MULTIPLIER = 3

var direction = Vector2(0,1)
onready var ANIM_SPEED = $AnimatedSprite.get_sprite_frames().get_animation_speed($AnimatedSprite.get_animation())

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
	
	if motion != Vector2(0,0):
		direction = motion
		var angle = rad2deg(motion.angle()) - 90
		$Light2D.set_rotation_degrees(angle)
	
	if motion == Vector2(0,0):
		if direction == Vector2(0,1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_down")
		elif direction == Vector2(1,1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_down_right")
		elif direction == Vector2(1,0):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_right")
		elif direction == Vector2(1,-1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_up_right")
		elif direction == Vector2(0,-1):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("idle_up")
		elif direction == Vector2(-1,-1):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_up_right")
		elif direction == Vector2(-1,0):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_right")
		elif direction == Vector2(-1,1):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("idle_right")
	elif motion == Vector2(0,1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down")
	elif motion == Vector2(1,1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_down_right")
	elif motion == Vector2(1,0):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_right")
	elif motion == Vector2(1,-1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up_right")
	elif motion == Vector2(0,-1):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_up")
	elif motion == Vector2(-1,-1):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_up_right")
	elif motion == Vector2(-1,0):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_right")
	elif motion == Vector2(-1,1):
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
	
