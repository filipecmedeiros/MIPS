.data 
a: .word 3
b: .word 4
m: .word 10
.text
.globl start
.ent start
start: lw $16, a
lw $17,b
lw $18,m
nop
add $18, $0, $16 //m = a
nop
slt $7, $18,$17 // if (m<b) m=b
beq $7, $0, fim
add $18, $0, $17 //m=b
fim:
.end start