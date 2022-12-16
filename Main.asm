## CS 254 Program 6
##
## Compute (8x^2 -3x +12) / (3x^2 +2x -16)
##
## Jonathan Gargano
## April 10, 2021
## 
## Registers:
## $10 base register
## $11 x
## $12 temporary
## $13 denominator
## $14 numerator
## $15 ratio
## $16 remain
## $17 error

          .text
          .globl main
		    
main:

       #Evaluate denominator
       lui   $10, 0x1000    # $10 = base register 0x00001000
       lw    $11, 0($10)    # $11 = x
       ori   $17, $0, 1     # $17 = 1
       addiu $13, $0, -16   # $13 = -16
       addiu $12, $0, 2     # $12 = 2
       mult  $12, $11       # 2x
       mflo  $12            # $12 = 2x
       addu  $13, $13, $12  # $13 = 2x + (-16)
       mult  $11, $11       # xx
       mflo  $11            # $11 = xx
       addiu $12, $0, 3     # $12 = 3
       mult  $12, $11       # 3x
       mflo  $12            # $12 = 3x
       addu  $13, $13, $12  # $13 = (3x^2) + (2x-16)
       beq   $13, $0, exit  # Branch if denominator == 0
       sll   $0,  $0, 0     # Branch delay slot
	   
       #Evaluate Numerator
       lw    $11, 0($10)    # $11 = x
       addiu $14, $0, 12    # $13 = 12
       addiu $12, $0, -3    # $12 = -3
       mult  $12, $11       # -3x
       mflo  $12            # $12 = -3x
       addu  $14, $14, $12  # $13 = -3x + 12
       mult  $11, $11       # xx
       mflo  $11            # $11 = xx
       addiu $12, $0, 8     # $12 = 8
       mult  $12, $11       # 8x
       mflo  $12            # $12 = 8x
       addu  $14, $14, $12  # $14 = (8x^2) + (-3x+12)

       #Evaluate rational function
       div   $14, $13       # $14 = (8x^2 -3x +12) / (3x^2 +2x -16)
       mflo  $15            # $15 = ratio
       mfhi  $16            # $16 = remain
       sw    $15 8($10)     # Store quiotient in ratio
       sw    $16 12($10)    # Store remainder in remain
       j done

exit:  sw   $17, 4($10)     # Store 1 in error
	   
done:  sll  $0, $0, 0       # no-op

            .data
		  
x:          .word  1
error:      .word  0
ratio:      .word  0
remain:     .word  0

## End of File