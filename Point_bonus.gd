extends RigidBody2D

var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpirationTimeout.start()
	screen_size = get_viewport_rect().size
	position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	$BonusSound.play()

func _on_body_entered(body):
	print("BONUS TOUCHED !")
	queue_free()

func _on_expiration_timer_timeout():
	queue_free()
