extends CanvasLayer

signal set_game_pause(pause)

func _process(delta):
	if Input.is_action_pressed("toggle_settings"): 
		toggle_settings()
		
func _on_volume_slider_mouse_exited():
	pass

func toggle_settings():
	if visible:
		close_settings()
	else:
		open_settings()

func close_settings():
	hide()
	emit_signal("set_game_pause", false)
	
func open_settings():
	emit_signal("set_game_pause", true)
	show()
	
func _on_close_settings_button_pressed():
	close_settings()
