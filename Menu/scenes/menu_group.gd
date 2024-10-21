extends Control

func _on_new_btn_mouse_entered() -> void:
	$NewBtn/NewLabel.modulate = Color8(253, 184, 3)
	
func _on_new_btn_mouse_exited() -> void:
	$NewBtn/NewLabel.modulate = Color8(255, 255, 255)

func _on_continue_btn_mouse_entered() -> void:
	$ContinueBtn/ContinueLabel.modulate = Color8(253, 184, 3)

func _on_continue_btn_mouse_exited() -> void:
	$ContinueBtn/ContinueLabel.modulate = Color8(255, 255, 255)

func _on_options_btn_mouse_entered() -> void:
	$OptionsBtn/OptionsLabel.modulate = Color8(253, 184, 3)

func _on_options_btn_mouse_exited() -> void:
	$OptionsBtn/OptionsLabel.modulate = Color8(255, 255, 255)

func _on_exit_btn_mouse_entered() -> void:
	$ExitBtn/ExitLabel.modulate = Color8(253, 184, 3)

func _on_exit_btn_mouse_exited() -> void:
	$ExitBtn/ExitLabel.modulate = Color8(255, 255, 255)

func _on_cancel_btn_mouse_entered() -> void:
	$"../OptionsGroup/CancelBtn/CancelLabel".modulate = Color8(253, 184, 3)

func _on_cancel_btn_mouse_exited() -> void:
	$"../OptionsGroup/CancelBtn/CancelLabel".modulate = Color8(255, 255, 255)

func _on_done_btn_mouse_entered() -> void:
	$"../OptionsGroup/DoneBtn/DoneLabel".modulate = Color8(253, 184, 3)

func _on_done_btn_mouse_exited() -> void:
	$"../OptionsGroup/DoneBtn/DoneLabel".modulate = Color8(255, 255, 255)
