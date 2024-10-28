extends CanvasLayer

class_name PauseMenu

func _on_resume_btn_pressed() -> void:
	$".".visible = false

func _on_audio_btn_pressed() -> void:
	$Control/Control.visible = false
	$OptionsGroup.visible = true

func _on_quit_pressed() -> void:
		$".".visible = false
		$"../TransitionManager".transitionToScene("res://Menu/scenes/menu.tscn")


func _on_cancel_btn_pressed() -> void:
	$Control/Control.visible = true
	$OptionsGroup.visible = false
