#Chi Calculator
#Copyright (C) 2023 Chimbal
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends Node2D

# Version
var Version = "v2.2"

# Deprecated
var buffer: String = "";
var main_string = [];

# Calc
var result: float = 0.0;
var a: float = 0.0;
var b: float = 0.0;
var op = "0";
var num2 = "0";
var dot = "0";
var dot2 = "0";
var calculated = "0";
var SQRT = "0";

var temp;

func _ready():
	$Container/Version.text = Version;

func _process(delta):
	
	if Input.is_action_just_pressed("numb_0"):
		add_buffer("0");
	if Input.is_action_just_pressed("numb_1"):
		add_buffer("1");
	if Input.is_action_just_pressed("numb_2"):
		add_buffer("2");
	if Input.is_action_just_pressed("numb_3"):
		add_buffer("3");
	if Input.is_action_just_pressed("numb_4"):
		add_buffer("4");
	if Input.is_action_just_pressed("numb_5"):
		add_buffer("5");
	if Input.is_action_just_pressed("numb_6"):
		add_buffer("6");
	if Input.is_action_just_pressed("numb_7"):
		add_buffer("7");
	if Input.is_action_just_pressed("numb_8"):
		add_buffer("8");
	if Input.is_action_just_pressed("numb_9"):
		add_buffer("9");
	if Input.is_action_just_pressed("numb_dot"):
		add_buffer(".");
	if Input.is_action_just_pressed("op_multiply"):
		add_buffer(" * ");
	if Input.is_action_just_pressed("op_divide"):
		add_buffer(" / ");
	if Input.is_action_just_pressed("op_plus"):
		add_buffer(" + ");
	if Input.is_action_just_pressed("op_minus"):
		add_buffer(" - ");
	if Input.is_action_just_pressed("ui_accept"):
		calc();
		calculated ="1";
	if Input.is_action_just_pressed("backspace"):
		#clear_input();
		clear_last();
	if Input.is_action_just_pressed("ui_cancel"):
		clear_input();
		
func clear_input():
	buffer = "";
	op = "0";
	dot = "0";
	dot2 = "0";
	num2 = "0";
	calculated = "0";
	SQRT = "0";
	$Container/TextIO/Text_Input.text = str(buffer);

func clear_last():
	main_string = buffer.split(" ");
	if op == "0" && num2 == "0":
		temp = str(main_string[0]);
		temp.erase(temp.length() - 1, 1);
		buffer = temp;
		$Container/TextIO/Text_Input.text = str(buffer);
	if op == "1" && num2 == "1":
		temp = str(main_string[2]);
		temp.erase(temp.length() - 1, 1);
		buffer = str(main_string[0]) + " " +str(main_string[1]) + " " + temp;
		$Container/TextIO/Text_Input.text = str(buffer);

func add_buffer(numb):
	buffer = $Container/TextIO/Text_Input.text;
	if numb == " √ ":
			buffer = buffer + str(numb);
			calc_sqrt();
			buffer = str(result);
	
	if numb == " * " || numb == " / " || numb == " + " || numb == " - " || numb == " % ":
		if op == "0":
			buffer = buffer + str(numb);
			op = "1";
		if op == "1" && num2 == "0":
			main_string = buffer.split(" ");
			main_string[1] = numb;
			buffer = main_string[0] + main_string[1] + main_string[2];
		if op == "1" && num2 == "1":
			calc();
			op == "0"
			buffer = str(result) + numb;
	
	if numb == "0" || numb == "1" || numb == "2" || numb == "3" || numb == "4" || numb == "5" || numb == "6" || numb == "7" || numb == "8" || numb == "9" || numb == ".":
		if numb != "." && op == "1":
			num2 = "1";
		if numb != ".":
			if calculated == "1":
				op = "0";
				dot = "0";
				dot2 = "0";
				num2 = "0";
				buffer = "";
				calculated = "0";
				SQRT = "0";
			buffer += numb;
		
		if op == "0" && dot == "0" && numb == ".":
			dot = "1";
			buffer += numb;
		if op == "1" && dot2 == "0" && numb == ".":
			dot2 = "1";
			buffer += numb;
			
	$Container/TextIO/Text_Input.text = str(buffer);
	
func calc_sqrt():
	main_string = buffer.split(" ");
	if main_string[1] == "%":
		result = sqrt(100 * float(main_string[0]) / float(main_string[2]));
	if main_string[1] == "+":
		result = sqrt(float(main_string[0]) + float(main_string[2]));
	if main_string[1] == "-":
		result = sqrt(float(main_string[0]) - float(main_string[2]));
	if main_string[1] == "/":
		result = sqrt(float(main_string[0]) / float(main_string[2]));
	if main_string[1] == "*":
		result = sqrt(float(main_string[0]) * float(main_string[2]));
	if main_string[1] == "√":
		result = sqrt(float(main_string[0]));
	$Container/TextIO/Text_Result.text = str(result);
	
func calc():
	buffer = $Container/TextIO/Text_Input.text;
	main_string = buffer.split(" ");
	$Container/TextIO/Text_Input.text = str(main_string);

	if main_string.has("*") || main_string.has("/") || main_string.has("-") || main_string.has("+") || main_string.has("%"):
		if main_string[1] == "*":
			if main_string[2] != "0" && main_string[2]:
				result = float(main_string[0]) * float(main_string[2]);
		if main_string[1] == "/":
			if main_string[2] != "0" && main_string[2]:
				result = float(main_string[0]) / float(main_string[2]);
		if main_string[1] == "-":
			result = float(main_string[0]) - float(main_string[2]);
		if main_string[1] == "+":
			result = float(main_string[0]) + float(main_string[2]);
		if main_string[1] == "%":
			result = float(main_string[2]) / 100 * float(main_string[0]);
		$Container/TextIO/Text_Result.text = str(result);

func _on_Link_Blog_pressed():
	OS.shell_open("https://overclockers.ru/blog/Hard-Workshop");

func _on_Link_Git_pressed():
	OS.shell_open("https://github.com/Shedou/Chi-Calculator");

#
# Operand
func _on_sqrt_pressed():
	add_buffer(" √ ");

func _on_Percent_pressed():
	add_buffer(" % ");

func _on_Multiple_pressed():
	add_buffer(" * ");

func _on_Divide_pressed():
	add_buffer(" / ");

func _on_Plus_pressed():
	add_buffer(" + ");
	
func _on_Minus_pressed():
	add_buffer(" - ");

func _on_Result_pressed():
	calc();
	calculated ="1";

func _on_AC_pressed():
	clear_input();
	
func _on_Del_pressed():
	clear_last();
	
# Operand
#
#
# Numbers
func _on_Num_1_pressed():
	add_buffer("1");

func _on_Num_2_pressed():
	add_buffer("2");

func _on_Num_3_pressed():
	add_buffer("3");

func _on_Num_4_pressed():
	add_buffer("4");

func _on_Num_5_pressed():
	add_buffer("5");

func _on_Num_6_pressed():
	add_buffer("6");

func _on_Num_7_pressed():
	add_buffer("7");

func _on_Num_8_pressed():
	add_buffer("8");

func _on_Num_9_pressed():
	add_buffer("9");
	
func _on_Num_0_pressed():
	add_buffer("0");

func _on_Num_point_pressed():
	add_buffer(".");
	
# Numbers
#
