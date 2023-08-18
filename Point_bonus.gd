extends RigidBody2D


var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpirationTimeout.start()
	screen_size = get_viewport_rect().size
	name = "PointBonus"

	position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	
func _on_expiration_timer_timeout():
	queue_free()

func _on_touched():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$BonusSound.play()
	await($BonusSound.finished)
	queue_free()

