#!/usr/bin/env python3

# ANSI color scheme script 
# Author: Dennis Svensson < ech.o >
# Original: http://crunchbang.org/forums/viewtopic.php?pid=134749%23p134749#p134749
# Modified using Python 3.

# Spacer
spr	=	 " "
# ANSI Color Setup
CL  =    "\033[0m" # reset all (colors and brightness)
BO  =    "\033[1m" # Bright 
# Foreground
BL  =   "\033[30m" # Black
R   =   "\033[31m" # Red
G   =   "\033[32m" # Green
Y   =   "\033[33m" # Yellow
B   =   "\033[34m" # Blue
M   =   "\033[35m" # Magenta 
C   =   "\033[36m" # Cyan
W   =   "\033[37m" # White
# Backgroud
# example:
# BBL	=	"\033[40m" # Black
# BR 	=	"\033[41m" # Red
# BG 	=	"\033[42m" # Green
# and so on

print(spr)
print(BO+R+"  ██████  "+CL+" "+BO+G+"██████  "+CL+BO+Y+"   ██████"+CL+" "+BO+B+"██████ "+CL+"  "+BO+M+"  ██████"+CL+" "+BO+C+"  ███████"+CL)
print(BO+R+"  ████████"+CL+" "+BO+G+"██    ██ "+CL+BO+Y+"██ "+CL+BO+B+"      ██    ██"+CL+" "+BO+M+"██████ "+CL+" "+BO+C+" █████████"+CL)
print(R+"  ██  ████"+CL+" "+G+"██  ████"+CL+Y+" ████    "+CL+" "+B+"████  ██"+CL+M+" ████ "+CL+"    "+C+"█████ "+CL)
print(R+"  ██    ██"+CL+" "+G+"██████ "+CL+Y+"  ████████"+CL+" "+B+"██████ "+CL+M+"  ████████"+CL+" "+C+"██ "+CL)
print(spr)
# print(spr)
# print("   ████  █████   ████  ██  ██")
# print("  ██  ██ ██  ██ ██  ██ ██  ██")
# print("  ██  ██ ██  ██ ██     ██████")
# print("  ██████ ████   ██  ██ ██  ██")
# print("  ██  ██ ██  ██  ████  ██  ██")
# print(spr)
# print(BO+R+"  █████████"+CL+BO+G+" █████████"+CL+BO+M+" █████████"+CL+BO+C+" █████"+CL)
# print(BO+R+"  █       █"+CL+BO+G+" █       █"+CL+BO+M+" █       █"+CL+BO+C+" █   █████"+CL)
# print(BO+R+"  █████   █"+CL+BO+G+" █   █   █"+CL+BO+M+" █   █   █"+CL+BO+C+" █       █"+CL)
# print(BO+R+"  █       █"+CL+G+" █   █   █"+CL+BO+M+" █   █   █"+CL+C+" █   █   █"+CL)
# print(R+"  █   █   █"+CL+G+" █   █████"+CL+M+" █   █████"+CL+C+" █   █   █"+CL)
# print(R+"  █       █"+CL+G+" █   █    "+CL+M+" █       █"+CL+C+" █   █   █"+CL)
# print(R+"  █████████"+CL+G+" █████    "+CL+M+" █████████"+CL+C+" █████████"+CL)