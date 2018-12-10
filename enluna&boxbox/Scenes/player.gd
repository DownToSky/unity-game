extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = - 500

var motion = Vector2()
#var spwan = Vector2()

func _ready():
	#spwan.x = self.global_position.x
	#spwan.y = self.global_position.y
	$AnimatedSprite.play("idle")
	set_physics_process(true)

func _physics_process(delta):
	#if self.global_position.y > 1000:
	#self.global_position  = spawn
	motion.y += GRAVITY
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			$AnimatedSprite.play("jump")
		else:
			if Input.is_action_pressed("ui_right"):
				$AnimatedSprite.flip_h = false
				motion.x = SPEED
				$AnimatedSprite.play("run")
			elif Input.is_action_pressed("ui_left"):
				$AnimatedSprite.flip_h = true
				motion.x = -SPEED
				$AnimatedSprite.play("run")
			else:
				motion.x = 0
				$AnimatedSprite.play("idle")
	else:
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.flip_h = false
			motion.x = SPEED
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.flip_h = true
			motion.x = -SPEED
		else:
			motion.x = 0

	motion = move_and_slide(motion, UP)