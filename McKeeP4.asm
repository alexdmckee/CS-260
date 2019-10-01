#Program 4 - Alex McKee
#Reverse a string in place, then print it

.eqv PRINT_STR 4
.eqv TERMINATE 10

	.data
Str:	.asciiz "Brudda Shark"

	.text
main:
	#Set up the stack to hold beginning contents of Str
	addi $sp, $sp, -4
	la $a0, Str
	sw $a0, ($sp)

	jal ReverseString
	
	li $t0, 0 # $t0 is the loop counter for following print
	move $t1, $v0 # $t1 contains number of chars
	move $a1, $a0
Print:
	beq $t0, $t1, Terminate
	lb $a0, ($a1)
	li $v0, 11	#print char
	syscall
	
	addi $a1, $a1, 1
	addi $t0, $t0, 1
	
	b Print
	
	

Terminate:
	
	#clean up stack
	addi $sp, $sp, 8
	
	li $v0, TERMINATE
	syscall
	
	
	
	
	
#Reverses a string in place "Hi" becomes "iH"
# Prototype: void ReverseString(string x)
# $sp = address of beginning of string
# Returns: Nothing

# Local Vars -----------
# $t1 - pointer to the first char of Str
# $t2 - pointer to the last char in the Str
# $t3 - number of chars/2
# $t4 - temp variable to hold char in swap loop
# $t6 - temp variable to hold char in swap loop
# $t5 - counter in swap loop 

ReverseString:

	lw $t1, ($sp)  # t1 contains the address of the string, it points to the first char
	
	#save the return address on the stack
	addi $sp, $sp, -4
	sw $ra, ($sp)
	
	jal StrLen
	
	# $t2 now points to the last char
	add $t2, $t1, $v0   
	addi $t2, $t2, -1
	
	
	#swap chars $v0 divided by 2 times
	srl $t3, $v0, 1
	
	li $t5, 0 # $t5 is counter for number of swaps
Swap:
	beq $t5, $t3, EndReverse
	lb $t4, ($t1)
	lb $t6, ($t2)
	
	sb $t6, ($t1)
	sb $t4, ($t2)
	
	
	addi $t1, $t1, 1	#increment to next char
	addi $t2, $t2, -1	# increment to prev char
	addi $t5, $t5, 1
	
	b Swap


EndReverse:
	lw $ra, ($sp)
	jr $ra	
	

	
	
	
# Prototype: int StrLen(string x)
# $a0 -	address of the beginning of the string
# Returns: $v0 - The number of chars in the str

# Local Vars --------
# $v0 = number of chars
# $t9 - working variable on the string

StrLen:
	li $v0, 0
	move $t9, $a0
Loop:	
	lb $a1, ($t9)
	beqz $a1, End
	addi $t9, $t9, 1	#increment to next char
	addi $v0, $v0, 1	#increment number of chars
	b Loop

End:
	jr $ra