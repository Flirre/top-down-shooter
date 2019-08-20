extends Entity

const LASER = preload("res://Laser.tscn")

# Sets the constants from the Entity class when readying
func _ready():
	SPEED = 200
	RELOAD_TIME = 0.5
	DAMAGE = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	reloading -= delta

# warning-ignore:unused_argument
func _physics_process(delta):
	input_loop()
	movement_loop()
	damage_loop(delta)

func input_loop():
	var LEFT 	= Input.is_action_pressed("move_left")
	var UP 		= Input.is_action_pressed("move_up")
	var RIGHT 	= Input.is_action_pressed("move_right")
	var DOWN 	= Input.is_action_pressed("move_down")
	var FIRE 	= Input.is_action_pressed("fire")
	
	movement_direction.x = -int(LEFT) + int(RIGHT)
	movement_direction.y = -int(UP) + int(DOWN)
	
	if (FIRE):
		fire()
		
func fire():
	if readyToFire():
		var left_laser = LASER.instance()
		var right_laser = LASER.instance()

		left_laser.global_position = global_position
		left_laser.position.x -= 34
		left_laser.position.y -= 27

		right_laser.global_position = global_position
		right_laser.position.x += 35
		right_laser.position.y -= 27

		get_parent().add_child(left_laser)
		get_parent().add_child(right_laser)
		reloading = RELOAD_TIME
