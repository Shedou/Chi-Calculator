extends Control

var chi_ab_mouse = Vector2();
var chi_ab_viewport = Vector2();
var chi_ab_relative = Vector2();
var chi_ab_blog_rect = Vector2();

var chi_ab_force = 0.3;

func _ready():
	chi_ab_viewport.x = ProjectSettings.get_setting("display/window/size/width");
	chi_ab_viewport.y = ProjectSettings.get_setting("display/window/size/height");
	chi_ab_blog_rect = $Links.rect_position;

func _input(event):
	if visible == true:
		if event is InputEventMouseMotion:
			chi_ab_mouse = event.position;
			chi_ab_relative = chi_ab_force * (chi_ab_mouse - (chi_ab_viewport/2));
			$Background.position = chi_ab_viewport/2 + chi_ab_relative;
			$Links.rect_position = chi_ab_blog_rect + chi_ab_relative/5;
			$Text.rect_position = chi_ab_blog_rect + chi_ab_relative/10;


func _on_About_BTN_Close_pressed():
	visible = false;
