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
	add_child(mob_scene.instantiate())

func _on_bonus_timer_timeout():
	add_child(point_bonus_scene.instantiate())

func _on_player_point_bonus(bonus_node):
	bonus_node._on_touched()
	score = int(score) + bonus_point_amount
	$HUD.update_score(score)

func _on_hud_toggle_settings():
	$Settings.toggle_settings()

func _on_settings_set_game_pause(pause):
	get_tree().paused = pause
