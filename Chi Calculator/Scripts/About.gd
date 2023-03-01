extends Control

var chi_ab_mouse_x;
var chi_ab_mouse_y;

var chi_ab_viewport_x;
var chi_ab_viewport_y;

var chi_ab_relative_x;
var chi_ab_relative_y;

var chi_ab_blog_rect_x;
var chi_ab_blog_rect_y;

var chi_ab_force = 0.3;

func _ready():
	chi_ab_viewport_x = ProjectSettings.get_setting("display/window/size/width");
	chi_ab_viewport_y = ProjectSettings.get_setting("display/window/size/height");
	chi_ab_blog_rect_x = $Links.rect_position.x;
	chi_ab_blog_rect_y = $Links.rect_position.y;

func _input(event):
	if visible == true:
		if event is InputEventMouseMotion:
			chi_ab_mouse_x = event.position.x;
			chi_ab_mouse_y = event.position.y;
			chi_ab_relative_x = chi_ab_force * (chi_ab_mouse_x - (chi_ab_viewport_x/2));
			chi_ab_relative_y = chi_ab_force * (chi_ab_mouse_y - (chi_ab_viewport_y/2));
			$Background.position.x = chi_ab_viewport_x/2 + chi_ab_relative_x;
			$Background.position.y = chi_ab_viewport_y/2 + chi_ab_relative_y;
			$Links.rect_position.x = chi_ab_blog_rect_x + chi_ab_relative_x/5;
			$Links.rect_position.y = chi_ab_blog_rect_y + chi_ab_relative_y/5;
			$Text.rect_position.x = chi_ab_blog_rect_x + chi_ab_relative_x/10;
			$Text.rect_position.y = chi_ab_blog_rect_y + chi_ab_relative_y/10;


func _on_About_BTN_Close_pressed():
	visible = false;
