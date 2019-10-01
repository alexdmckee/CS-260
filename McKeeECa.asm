#Alex McKee - EC
# Enter an unknown number of integers, then print them out in order

.data
prompt:	   .asciiz "Enter integers  >0, enter 0 to stop \n"
loopprompt: .asciiz "enter num: "

.text

main: 
	#set num items ($t0) and set temp stack pointer
	li $t0, 0
	la $a1, ($sp)
	
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	jal getNums
	
	jal printNums
	
	#reset stack pointer
	sll $t1, $t1, 2
	add $sp, $sp, $t1
	
	li $v0, 10
	syscall
	
	

# Getnums 
# description: gets the user to enter a number, then enters in on the stack, ad infitum until zero is entered
# parameters : $t0 - numelements
#returns: nothing

getNums:
	
loop:
	#prompts
	li $v0, 4
	la $a0, loopprompt
	syscall
	
	li $v0, 5
	syscall
	
	beqz $v0, endloop
	
	#if not zero, allocate space on the stack, store it there and increment num counter
	addi $sp, $sp, -4
	sw $v0, ($sp)
	addi $t0, $t0, 1
	
	j loop
	
endloop:
	#save number of items on the stack in $t1
	move $t1, $t0
	jr $ra
	
	
	
#printNums
#description: prints out the elements on the stack
#parameters: $t0 - numElements on the stack
#returns: nothing

printNums:

printLoop:
		
	beqz $t0, endPrint
	
	#else still things to print, load word from temp stack pointer, increment temp stack pointer by -4, decrement number of items
	addi $a1, $a1, -4
	lw $t2, ($a1)
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	addi $t0, $t0, -1
	
	j printLoop

endPrint:

	jr $ra
	

