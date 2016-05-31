# program that prints the smallest and largest values found
# in a non-empty table of N word-sized integers.
# @author    Kal Stoykov
# @version   Last modified on 05/10/2016

	.text

main:
	la	$t0, table			# Load the starting address of the table	
	lw  	$t1, ($t0)			# takes first value from table / largest
	lw  	$t5, ($t0)			# takes first value from table / smallest
	la	$t2, N				# Load address of N
	lw  	$t3, ($t2)			# takes the value from  N at address s2 - counter

main2:	bgt	$t3, 1, multiNum		# value of N is bigger than 1
						# otherwise N is the smallest / largest number
	la	$a0, smallmsg
	li	$v0, 4				# print a string
	syscall
	li	$v0, 1				#Code to print an integer
	move	$a0, $t5			#Load the integer
	syscall

	la	$a0, largemsg
	li	$v0, 4				# print a string
	syscall
	li	$v0, 1				#Code to print an integer
	move	$a0, $t1			#Load the integer
	syscall
	li      $v0,10      			# code 10 == exit
        syscall             			# Halt the program.
	
multiNum:
	addi	$t0, $t0,  4			# move to the next number
	lw  	$t4, ($t0)			# takes next value from table
	addi	$t3, $t3,  -1			#decrement N
	bgt	$t4, $t1, largeNum		# if the $t4 num is larger
						# otherwise
	bgt	$t4, $t5, smallNum		# if the $t4 num is larger than smallest num $t5
	move	$t5, $t4			# otherwise stores t4 in $t5 - smaller number
	b	main2

largeNum:
	move 	$t1, $t4			#stores the larger number in $t1
	b 	main2

smallNum:
	b	main2				# do nothing, branch to main
	

## Data for the program to be stored:
	.data

table:     .word   3  -1  6  5  7  -3  -15  18  2 
N:         .word   9				# defined constant N

##table:   .word   3
##N:       .word   1				# defined constant N

largemsg:  .asciiz "\nThe largest number is: "
smallmsg:  .asciiz "\nThe smallest number is: \n"

## end of table.asm
