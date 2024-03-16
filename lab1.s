#---------------------------------------------------------------
# Assignment:           1
# Due Date:             January 21, 2022
# Name:                 Othman Sebti
# Unix ID:              osebti
# Lecture Section:      B1
# Instructor:           Karim Ali
# Lab Section:          (Tuesday, Thursday)
# Teaching Assistant:   Danil Tiganov
#---------------------------------------------------------------


#---------------------------------------------------------------
# The main program inverts the byte order of a word (4 bytes) so as to convert
# it into a big-endian representation. The program does so by isolating each individual 
# byte with and instructions, and then uses shift operations to swap them. 
#
#
# Register Usage:
#
#  t-registers are used for temporary values to store the isolated bytes
#  and to shift them. 
#
#---------------------------------------------------------------



.text

main: 

li $v0,5 # read user input
syscall

move $t0, $v0 # moving the read integer to register $t0

andi $t1,$t0,0x000000ff # isolating  byte
sll $t1,$t1,24 # shifting to new position

andi $t2,$t0,0x0000ff00 # isolating  byte
sll $t2,$t2,8 # shifting to new position

andi $t3,$t0,0x00ff0000 # isolating  byte
srl $t3,$t3,8 # shifting to new position

andi $t4,$t0,0xff000000 # isolating  byte
srl $t4,$t4,24 # shifting to new position

or $t1,$t1,$t2 # or-operation to combine the bytes in one 4 byte element
or $t1,$t1,$t3 # or-operation to combine the bytes in one 4 byte element
or $t1,$t1,$t4 # or-operation to combine the bytes in one 4 byte element

li $v0,1 # printing the value from register
move $a0,$t1 # moving the value sotred in $t1 in argument register $a0
syscall # calling print

jr $ra # return to caller




