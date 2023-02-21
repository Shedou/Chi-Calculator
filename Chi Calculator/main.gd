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
var Version = "v2.3"

# Strings
var chi_str_buffer: String = "";
var chi_str_temp = [];

# trash
var chi_float_result: float = 0.0;
var chi_bool_operand: bool = false;
var chi_bool_numb2: bool = false;
var chi_bool_dot_1: bool = false;
var chi_bool_dot_2: bool = false;
var chi_bool_calculated: bool = false;
var chi_int_cAC: int = 0;

var Text_Input_Focus = 0;

var chi_na_temp;

func _ready():
	$Container/Version.text = Version;

func _unhandled_key_input(event):
	if Text_Input_Focus == 0:
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
			chi_calculate();
			chi_bool_calculated = false;
		if Input.is_action_just_pressed("backspace"):
			clear_last();
		if Input.is_action_just_pressed("ui_cancel"):
			clear_input();
			chi_int_cAC += 1;

#func _process(delta):
#	pass;
		
func clear_input():
	chi_str_buffer = "";
	chi_bool_operand = false;
	chi_bool_dot_1 = false;
	chi_bool_dot_2 = false
	chi_bool_numb2 = false;
	chi_bool_calculated = false;
	chi_put_Text_Input(chi_str_buffer);
	if chi_int_cAC >= 1:
		chi_put_Text_Output(chi_str_buffer);
		chi_int_cAC = 0;

func clear_flags():
	chi_str_buffer = "";
	chi_bool_operand = false;
	chi_bool_dot_1 = false;
	chi_bool_dot_2 = false;
	chi_bool_numb2 = false;
	chi_bool_calculated = false;
	chi_int_cAC = 0;

func clear_last():
	chi_int_cAC = 0;
	chi_str_temp = chi_str_buffer.split(" ");
	if chi_bool_operand == false && chi_bool_numb2 == false:
		chi_na_temp = str(chi_str_temp[0]);
		if chi_na_temp.substr(chi_na_temp.length() - 1, 1) == ".":
			chi_bool_dot_1 = false;
		chi_na_temp.erase(chi_na_temp.length() - 1, 1);
		chi_str_buffer = chi_na_temp;
		chi_put_Text_Input(chi_str_buffer);
	if chi_bool_operand == true && chi_bool_numb2 == true:
		chi_na_temp = str(chi_str_temp[2]);
		if chi_na_temp.substr(chi_na_temp.length() - 1, 1) == ".":
			chi_bool_dot_2 = false;
		chi_na_temp.erase(chi_na_temp.length() - 1, 1);
		chi_str_buffer = str(chi_str_temp[0]) + " " +str(chi_str_temp[1]) + " " + chi_na_temp;
		chi_put_Text_Input(chi_str_buffer);

func add_buffer(numb):
	chi_int_cAC = 0;
	chi_str_buffer = $Container/TextIO/Text_Input.text;
	if numb == " √ ":
			chi_str_buffer = chi_str_buffer + str(numb);
			calc_sqrt();
	
	if numb in [" * ", " / ", " + ", " - ", " % "]:
		if chi_bool_operand == false:
			chi_str_buffer = chi_str_buffer + str(numb);
			chi_bool_operand = true;
			chi_put_Text_Input(chi_str_buffer);
		if chi_bool_operand == true && chi_bool_numb2 == false:
			chi_str_temp = chi_str_buffer.split(" ");
			chi_str_temp[1] = numb;
			chi_str_buffer = chi_str_temp[0] + chi_str_temp[1] + chi_str_temp[2];
			chi_put_Text_Input(chi_str_buffer);
		if chi_bool_operand == true && chi_bool_numb2 == true:
			chi_calculate();
			chi_bool_operand == false
			chi_str_buffer = str(chi_float_result) + numb;
			chi_put_Text_Input(chi_str_buffer);
	
	if numb in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]:
		if numb != "." && chi_bool_operand == true:
			chi_bool_numb2 = true;
			chi_put_Text_Input(chi_str_buffer);
		if numb != ".":
			if chi_bool_calculated == true:
				clear_flags();
			chi_str_buffer += numb;
			chi_put_Text_Input(chi_str_buffer);
		
		if chi_bool_operand == false && chi_bool_dot_1 == false && numb == ".":
			chi_bool_dot_1 = true;
			chi_str_buffer += numb;
			chi_put_Text_Input(chi_str_buffer);
		if chi_bool_operand == true && chi_bool_dot_2 == false && numb == ".":
			chi_bool_dot_2 = true;
			chi_str_buffer += numb;
			chi_put_Text_Input(chi_str_buffer);
	
func calc_sqrt():
	chi_int_cAC = 0;
	chi_str_temp = chi_str_buffer.split(" ");
	if chi_str_temp[1] == "%":
		chi_float_result = sqrt(100 * float(chi_str_temp[0]) / float(chi_str_temp[2]));
	if chi_str_temp[1] == "+":
		chi_float_result = sqrt(float(chi_str_temp[0]) + float(chi_str_temp[2]));
	if chi_str_temp[1] == "-":
		chi_float_result = sqrt(float(chi_str_temp[0]) - float(chi_str_temp[2]));
	if chi_str_temp[1] == "/":
		chi_float_result = sqrt(float(chi_str_temp[0]) / float(chi_str_temp[2]));
	if chi_str_temp[1] == "*":
		chi_float_result = sqrt(float(chi_str_temp[0]) * float(chi_str_temp[2]));
	if chi_str_temp[1] == "√":
		chi_float_result = sqrt(float(chi_str_temp[0]));
	chi_put_Text_Output(chi_float_result);
	chi_str_buffer = str(chi_float_result);
	
func chi_put_Text_Input(value):
	$Container/TextIO/Text_Input.text = str(value);
	
func chi_put_Text_Output(value):
	$Container/TextIO/Text_Result.text = str(value);
	
func chi_calculate():
	chi_int_cAC = 0;
	chi_str_buffer = $Container/TextIO/Text_Input.text;
	chi_str_temp = chi_str_buffer.split(" ");
	chi_put_Text_Input(chi_str_temp);

	if chi_str_temp.has("*") || chi_str_temp.has("/") || chi_str_temp.has("-") || chi_str_temp.has("+") || chi_str_temp.has("%"):
		if chi_str_temp[1] == "*":
			if chi_str_temp[2] != "0" && chi_str_temp[2]:
				chi_float_result = float(chi_str_temp[0]) * float(chi_str_temp[2]);
		if chi_str_temp[1] == "/":
			if chi_str_temp[2] != "0" && chi_str_temp[2]:
				chi_float_result = float(chi_str_temp[0]) / float(chi_str_temp[2]);
		if chi_str_temp[1] == "-":
			chi_float_result = float(chi_str_temp[0]) - float(chi_str_temp[2]);
		if chi_str_temp[1] == "+":
			chi_float_result = float(chi_str_temp[0]) + float(chi_str_temp[2]);
		if chi_str_temp[1] == "%":
			chi_float_result = float(chi_str_temp[2]) / 100 * float(chi_str_temp[0]);
		chi_put_Text_Output(chi_float_result);

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
	chi_calculate();
	chi_bool_calculated = true;

func _on_AC_pressed():
	clear_input();
	chi_int_cAC += 1;
	
func _on_Del_pressed():
	clear_last();
	chi_int_cAC = 0;
	
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
