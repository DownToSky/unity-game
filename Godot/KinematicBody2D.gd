extends KinematicBody2D

var motion = Vector2(0, 0)

var MAX_SPEED_X = 100
var MAX_SPEED_Y = 100

func filter_speed():
	if motion.x > MAX_SPEED_X:
		motion.x = MAX_SPEED_X
	elif motion.x < -MAX_SPEED_X:
		motion.x = -MAX_SPEED_X
	if motion.y > MAX_SPEED_Y:
		motion.y = MAX_SPEED_Y
	elif motion.y < -MAX_SPEED_Y:
		motion.y = -MAX_SPEED_Y

func _physics_process(delta):
	if Input.is_action_just_released('ui_right'):
		motion.x = 0
	if Input.is_action_just_released('ui_left'):
		motion.x = 0
	if Input.is_action_just_released('ui_up'):
		motion.y = 0
	if Input.is_action_just_released('ui_down'):
		motion.y = 0
	
	if Input.is_action_pressed('ui_right'):
		motion.x += 100
		filter_speed()
	if Input.is_action_pressed('ui_left'):
		motion.x += -100
		filter_speed()
	if Input.is_action_pressed('ui_up'):
		motion.y += -100
		filter_speed()
	if Input.is_action_pressed('ui_down'):
		motion.y += 100
		filter_speed()
	
	
	move_and_slide(motion)
	