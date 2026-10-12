extends CharacterBody2D

@export var maxHealth: int = 3
@export var speed = 150.0
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var previousDirection: String = "Down"
var currentHealth: int = maxHealth

func handleInput():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed

func handleCollision(): 
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()

func updateAnimation():
	var direction = "Down"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"
	
	animations.play("walk" + direction)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name == "hitbox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
	print_debug(currentHealth)

func heal(amount: int) -> void:
	currentHealth = min(currentHealth ++ amount, maxHealth)
	print_debug(currentHealth)
