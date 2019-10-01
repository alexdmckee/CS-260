#Alex McKee - Program 5
#
#
#  Manually calculating the column sums give col 1: 56.0, col 2: 57.0, col 3: 52.0, col 4: 49.0, col 5: 52.0 col 6: 20.0
#
#  I tested the program on columns 1 and 5 and recieved the correct answer. 

.eqv NUM_ROWS 5
.eqv NUM_COLS 6
.eqv READ_INT 5
.eqv PRINT_FLOAT 2

         .data  
Array:   .float 1.0,   6.0,  8.0, 10.0, 12.0, 2.0
         .float 14.0,  2.0, 18.0, 20.0, 24.0, 3.0
         .float 30.0, 32.0,  3.0, 10.0,  5.0, 4.0
         .float 1.0,   2.0,  3.0,  4.0,  5.0, 5.0
         .float 10.0, 15.0, 20.0,  5.0,  6.0, 6.0
         
 Prompt: .asciiz "Please enter a number between 0-5 "
         
         .text                
 main:	
 	li $v0, 4
 	la $a0, Prompt
 	syscall
 	
 	# After this block $t0 holds the desired column to sum
 	li $v0, 5
 	syscall

 	
 	# This block primes the pump for the RowCalc subroutine
 	la $a0, Array
 	move $a1, $v0
 	li $a2, NUM_COLS
 	li $a3, NUM_ROWS
 	
 	
 	
 	jal RowCalc
 	
 	li $v0, 2
  	mov.s $f12, $f0   # Move contents of register $f0 to register $f12
  	syscall
 	
 	li $v0, 10
 	syscall
 	
 # RowCacl -  Sums up all the numbers in in a given column
 #Parameters:
 # $a0 - beginning of array
 # %a1 - column to sum
 # $a2 - number of columns 
 # $a3 - number of rows
 #
 # Returns: $f0 - sum of column
 
 # Local Vars----------
 # $t6 - num of times to loop (rows - 1)
 # $t7 - loop counter
 # $v0 - col. sum  accumalator
 # $t0 - hold column to sum
 
 
 RowCalc:
 
 	# get $a0 to point to start column
 	mul $a1, $a1, 4
 	la $a0, Array($a1)
 	
 	#case where there is only one row
 	l.s 	$f1, ($a0)
 	add.s 	$f0, $f0, $f1
 	
 	mul 	$t2, $a2, 4  #offset to item directly below in column

 	
 	#
 	li $t7, 1		#counter 

 	
 LoopColumns:
 	
 	beq 	$t7, $a3, End
 	
 	add   	$a0, $a0, $t2
 	l.s 	$f1, ($a0)
 	add.s 	$f0, $f0, $f1
 	
 	
 	addi $t7, $t7, 1
 	j LoopColumns
 	
 	
 
 
 End:
 	jr $ra
 		
 		
 	