extends TextEdit


func _on_Text_Input_mouse_entered():
	readonly = false;
	get_node("../../../").get_node(".").Text_Input_Focus = 1;

func _on_Text_Input_mouse_exited():
	readonly = true;
	get_node("../../../").get_node(".").Text_Input_Focus = 0;
