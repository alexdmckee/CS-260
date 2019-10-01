#Alex McKee
#Program 6	
	
	
.eqv NULL 0
.eqv ELEVEN 11
.eqv NEGATIVE_ONE -1


	.data
inputMsg:.asciiz "Enter a number in the range of 0 through 10..."
endMsg: .asciiz "   Done!\n"

	.align 2         # Align what follows in a 4-byte boundary
head:
node0:      .word 0 
	   .word node1
	    .asciiz "cero "
	    
node1:   .word 1
	.word node2 
	.asciiz "uno "

node2:   .word 2
	.word node3 
	.asciiz "dos "

node3:   .word 3
	.word node4 
	.asciiz "tres "

node4:   .word 4
	.word node5 
	.asciiz "cuatro "

node5:   .word 5
	.word node6 
	.asciiz "cinco "

node6:   .word 6
	.word node7 
	.asciiz "seis "

node7:   .word 7
	.word node8 
	.asciiz "siete "

node8:   .word 8
	.word node9 
	.asciiz "ocho "

node9:   .word 9
	.word node10
	 .asciiz "nueve "
	
node10:  .word 10 
	.word nodeEND 
	.asciiz "diez "

nodeEND: .word -1 
	.word NULL
	.asciiz "Final "
	
	
	
.text

main:

prompt:	
	# prompt the user for a number
	li $v0, 4
	la $a0, inputMsg
	syscall
	
	# store the number in $v0
	li $v0, 5
	syscall
	
	# branch to prompt if not inbetween 0-10
	bge  $v0, ELEVEN, prompt
	ble  $v0, NEGATIVE_ONE, prompt
	
	
	#prime the pump for FindNumber
	la $a0, head
	move $a1, $v0
	jal FindNumber
	
	#display the spanish word for the numeral
	li $v0, 4
	la $a0, ($a2)
	syscall
	
	
	#Get ready to  call printlist
	la $a0, head
	jal PrintList
	
	#terminate
	li $v0, 4
	la $a0, endMsg
	syscall
	
	li $v0, 10
	syscall
	


# FindNumber ---------
# description : searches the linked list for the specified number, starting from the head of the list, and
# returns the address of the string with the Spanish word for that number. 
# parameters: ------------
# $a0 - address of the head of the list
# $a1 - the numeral to search for
# returns: 
# $a2 - the address of the Spanish word for the numeral
# 
# local vars ---------------
# t1 - working var - next pointer, check if null

FindNumber:
	
	#check if at end of list, at nodeEnd
	lw $t1, 4($a0)
	lw $t2, ($a0)
	beq $t1, NULL, endFind
	
	#check if the node has the numeral
	beq $a1, $t2, Found
	
	
	move $a0, $t1
	j FindNumber
	
	
	
	
	
Found:
	la $a2, 8($a0)
	jr $ra


endFind:
	jr $ra
	

#PrintList:
#description: starts at the head of the list, and prints each Spanish word in the list. 
# Parameters: $a0 - head of the list
# returns: nothing

#local vars ---
# $a1 - working list pointer (temp)
	
PrintList:
	
	move $a1, $a0
loop:
	#la $t1, 4($a1)
	#beq $t1, NULL, endPrint
	
	li $v0, 4
	la $a0, 8($a1)
	syscall
	
	lw $a1, 4($a1)
	beq $a1, NULL, endPrint
	
	j loop

endPrint:
	jr $ra
	