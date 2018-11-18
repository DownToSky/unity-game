extends KinematicBody2D



export(int) var SPEED = 40
export(float) var DASH_MULTIPLIER = 3

func _physics_process(delta):
	var motion = Vector2(0, 0)
	var speed = SPEED
	if Input.is_action_pressed('ui_dash'):
		speed =  DASH_MULTIPLIER * SPEED
	if Input.is_action_pressed('ui_right'):
		motion.x += 1
	if Input.is_action_pressed('ui_left'):
		motion.x += -1
	if Input.is_action_pressed('ui_up'):
		motion.y += -1
	if Input.is_action_pressed('ui_down'):
		motion.y += 1
	
	
	
	move_and_slide(motion.normalized() * speed, Vector2(0, -1))
	