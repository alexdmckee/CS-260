#Constants 
.eqv PRINT_STR 4
.eqv TERMINATE 10
.eqv PRINT_INT 1
.eqv ALLOCATE_MEMORY 9


	.data
Arr1:   .word  3, 6, 9, 12, 15, 18, 21
Arr2:   .word 4, 8, 12, 16, 20, 24, 28
ArrSum: .word 0, 0, 0, 0, 0, 0, 0
Str:    .asciiz "End of arrays"


	.text
main:
	# Get the number of words in the array
	la $a1, Arr2
	la $a0, Arr1
	la $a2, ArrSum
	sub $t0, $a1, $a0	# $t0 holds number of bytes of arrays

	# Dynamically allocate memory for the Arr Sum 
	move $a0, $t0
	li $v0, 9
	syscall
	move $a2, $v0
	la $a0, Arr1

	srl $a3, $t0, 2		# $a0 holds the number of words in the arrays
	
	# To initialize memory during run-time
	#  Set $a2 to this new block of memory, or $v0 contains it?

	# li $a0, $t0     #..number of bytes, before it gets divided by  4
	# li $v0, ALLOCATE_MEMORY
	# syscall
	#
	#
	#la $a2, $v0  
	#
	#loop to set $v0 to 0 $a3 times
	
	
	jal AddArrays
	
	#test last value
	
	#lw $a0, ($a2) #is not working, says out of bounds...


	li $v0, TERMINATE 
	syscall

#AddArrays subroutine - Given two arrays of equal length, sums the components into a third array
# Parameters: 
	#$a0 - Address of array 1
	#$a1 - Address of array 2
	#$a2 - Address of Arrsum
	#$a3 - Number of elements in the arrays
#Local Vars
	# $t1 - Loop counter 
	# $t2 - temp variable holder
	# $t3 - temp variable holder
	# $t4 - temp holder of beggining of dynamically allocated array
# Returns nothing

AddArrays: 
	
	
	li $t1, 0	# initialize the loop counter to 0

	move $t4, $a2

Loop:
	beq $t1, $a3, End	# Branch if loop has run the size of the arrays
	
	
	# Load two particular numbers from memory to be summed, store in Arrsum
	lw $t2, ($a0)		
	lw $t3, ($a1)
	add $t3, $t2, $t3
	sw $t3, ($t4)
	
	


	addi $a0, $a0, 4	# Increase to the next position in the array	
	addi $a1, $a1, 4	# Increase to the next position in the array
	addi $t4, $t4, 4	# Increase to the next position in the array
	addi $t1, $t1, 1	# Increase the loop counter by 1
	
	
	j Loop


End:
	jr $ra