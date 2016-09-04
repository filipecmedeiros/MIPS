.data 
a: .word 3
b: .word 4
x: .word 0
.text
.globl start
.ent start
start:  lw $8, a //carrega a
        lw $9, b //carrega b
		lw $11, x //carrega x
		
		slt $4, $8, $0 //if (a<0) fim
		bne $4, $0, fim
		
		addi $10, $0, 100 //carrega 100
		slt $5, $10, $9 //if (b>100) fim
		bne $5, $0, fim
		
		addi $11, $11, 1
		sw $11, x
fim:
.end start