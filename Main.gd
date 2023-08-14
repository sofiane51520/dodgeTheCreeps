extends Node

@export var point_bonus_scene: PackedScene
@export var mob_scene: PackedScene

var score
var bonus_point_amount = 5


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BonusTimer.stop()
	$HUD.show_game_over()
	$GameMusic.stop()
	$LooseMusic.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$GameMusic.play()
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$BonusTimer.start()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("GamePerimeter/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_bonus_timer_timeout():
	var bonus = point_bonus_scene.instantiate()
	add_child(bonus)
	
func _on_player_point_bonus():
	score = int(score) + bonus_point_amount
	$HUD.update_score(score)

func _on_hud_toggle_settings():
	$Settings.toggle_settings()

func _on_settings_set_game_pause(pause):
	get_tree().paused = pause
