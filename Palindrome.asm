# program that tells if a string is a palindrome.
# @author    Kal Stoykov
# @version   Last modified on 05/10/2016

main:					
	la	$a0, string_space
	li	$a1, 1024
	li	$v0, 8			# load "read_string" code into $v0.
	syscall

	la	$t1, string_space	# initialize $t1 to point to start
	
	la	$t2, string_space	# to move B to the end
length_loop:
	lb	$t3, ($t2)		# load the byte *B into $t3.
	beqz	$t3, end_length_loop	# if $t3 == 0, branch out of loop
	addu	$t2, $t2, 1		# otherwise, increment B
	b	length_loop		# and repeat the loop
end_length_loop:
	subu	$t2, $t2, 2		# subtract 2 to move B back past
					# the '\0' and '\n'.
test_loop:
	bge	$t1, $t2, is_palin	# if A >=B, it is a palindrome.
	
	lb 	$t3, ($t1)		# load the byte *A into $t3.
	lb	$t4, ($t2)		# load the byte *B into $t4.
	sub 	$t4, $t4, 0		# make an ASCII number
	sub 	$t4, $t4, 0		# make an ASCII number
	b 	testA
	
testA:
	bgt 	$t3, 64, upperTestA 	#charA is either uppercase, lowercase or garbage value
	addu 	$t1, $t1, 1		# if Char A is less than 64, increment A
	b	test_loop

testB:	bgt 	$t4, 64, upperTestB 	#charB is either uppercase, lowercase or garbage value
	subu	$t2, $t2, 1		# if Char A is less than 64, decrement B
	b	test_loop

isPali:	bne	$t3, $t4, not_palin	# if $t3 !=t4, not palindrome.
					# Otherwise.
	b	is_palin		# it is a palindrome, shows the message

upperTestA:
	bgt	$t3, 90, lowerTestA	# check if it is a lowecase character
	add 	$t3, $t3, 32		# otherwise, it is an uppercase character, convert to lowercase
	b	testB

lowerTestA:
	bgt	$t3, 96, lowerTest2A	# continues check if a char is lowecase character
	addu 	$t1, $t1, 1		# it is between 90-96, which means it is a garbage value and it is ignored
	b	test_loop

lowerTest2A:
	blt	$t3, 122, testB   	# character value is between 96 and 122 and it is a smallcase char, do nothing
	addu 	$t1, $t1, 1  		# character value is bigger than 122, it is a garbage value and it is ignored
	b	test_loop		# goes back to the test_loop

upperTestB:
	bgt	$t4, 90, lowerTestB	# check if it is a lowecase character
	add 	$t4, $t4, 32		# otherwise, it is an uppercase character, convert to lowercase
	b	isPali

lowerTestB:
	bgt	$t4, 96, lowerTest2B	# continues check if a char is lowecase character
	subu	$t2, $t2, 1		# it is between 90-96, which means it is a garbage value and it is ignored
	b	test_loop

lowerTest2B:
	blt	$t4, 122, isPali   	# character value is between 96 and 122 and it is a smallcase char, do nothing
	subu	$t2, $t2, 1  		# character value is bigger than 122, it is a garbage value and it is ignored
	b	test_loop		# goes back to the test_loop


is_palin:				# print the is_palin_msg, and exit.
	la	$a0, is_palin_msg
	li	$v0, 4
	syscall
	b	exit

not_palin:
	la	$a0, not_palin_msg	#print the not_palin_msg, and exit.
	li	$v0, 4
	syscall

exit:					# exit the program:
	li	$v0, 10			# load exit into $v0.
	syscall				# make the system call.

## Data for the program to be stored:
	.data
string_space:	.space	1024	# set aside 1024 bytes for the string
is_palin_msg:	.asciiz	"The string is a palindrome.\n"
not_palin_msg:	.asciiz "The string is not a palindrome.\n"

## end of palindrome.asm
