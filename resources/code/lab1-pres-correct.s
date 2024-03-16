#---------------------------------------------------------------
# Assignment:           1
# Due Date:             September 27, 2010
# Name:                 Adam Wolfe Gordon
# Unix ID:              awolfe
# Lecture Section:      A1
# Instructor:           Nelson Amaral
# Lab Section:          D04
# Teaching Assistant:   Adam Wolfe Gordon
#---------------------------------------------------------------

#---------------------------------------------------------------
# The main program asks the user to input an integer, N, then
# calculates and prints the first N numbers of the fibonacci
# sequence.
#
# Register Usage:
#
#       a0: used for syscall arguments
#       v0: used for syscall arguments
#       t0: N, the number of numbers to calculate
#       t1: loop counter
#       t3: the lower "current" number in the sequence
#       t4: the higher "current" number in the sequence
#       t5: temporary storage for the old higher number
#
#---------------------------------------------------------------

	.data
prompt:
	.asciiz "Input N: "
space:
	.asciiz " "
alldone:
	.asciiz "\nI hope you enjoyed the Fibonacci sequence.\n"
ofmsg:
	.asciiz "\nSorry, I can't print any more numbers without more bits for my integers."
	
	.text
main:
	# Print the prompt
	li $v0, 4
	la $a0, prompt
	syscall

	# Read in N
	li $v0, 5
	syscall

	# Move N to $t0
	move $t0, $v0
	# Counter in $t1 -- start at 0
	li $t1, 0

	# Load the first values of the Fibonacci sequence (0 and 1)
	li $t3, 0
	li $t4, 1

loop:
	# Check the loop condition
	beq $t0, $t1, done
	# Increment the counter
	addi $t1, $t1, 1
	
	# Print the next number in the sequence
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, space
	syscall

	# Update the series
	# BUG: We should be saving $t4, the larger current value, not $t3, the smaller one.
	move $t5, $t4
	addu $t4, $t3, $t4
	move $t3, $t5

	# BUG: We should check for overflow and print a nice message.
	blez $t4, overflow
	
	# Loop!
	j loop

overflow:
	# Print the one number that was calculated but not yet printed.
	li $v0, 1
	move $a0, $t3
	syscall
	# Let the user know there was overflow.
	li $v0, 4
	la $a0, ofmsg
	syscall
	
done:
	# Print a friendly message
	li $v0, 4
	la $a0, alldone
	syscall

	# Exit.
	# BUG: We need to exit or return.
	jr $ra
	