.data 
   str1:.asciiz "Cin {["
   str2:.asciiz "Palavra inicial: "
   str3:.asciiz "\nPalavra convertida: "
   string: .space 2
   a: .asciiz "a"
   i: .word 0
   um: .word 1
   A: .asciiz "A"
   Z: .asciiz "["
   z: .asciiz "{"
.text
.globl start
.ent start
start:
	la $6,str1    //carrega a string no registrador6
	lb $10 , 0($6)// coloca no registrador 10 o primeiro caractere
	lw $20,i // carrega no reg 20 o contador
	la $7,str1// carrega a string no reg 7
	la $11,a// carrega a string a em 11
	lb $12,0($11)// carrega primeiro caractere em 12
	lw $19,um// carrega no reg 19 o valor 1
	la $5,A
	lb $13,0($5)//carrega o caractere da string A em 13
	la $5,Z
	lb $14,0($5)//carrega o caractere da string Z em 14
	la $5,z
	lb $15,0($5)//carrega o caractere da string z em 15
	la $26,string//carrega o endereço da string em 26
	la $4,str2
	jal printf
	la $4,str1
	jal printf
	la $4,str3
	jal printf
	
 
loop: beq $10,$0,finaloop // loop  pra saber o tamanho da string
	addi $20,$20,1
	addi $7,$7,1
	lb $10 , 0($7)
j loop
	
finaloop:
	addi $20,$20,-1
	add $6,$6,$20 // vai pro final da string
	
	
	addi $20,$20,1	
loop2: beq $20,$0,final
	lb $10,0($6)//pega o caractere da string
	addi $6,$6,-1
	addi $20,$20,-1//volta a string em 1 posiçao
	
	slt $25,$10,$13 //todas essas verificaçoes é pra analisar se o caractere está no intervalo das letras,se tiver ele é convertido
	beq $25,$19,escrever//se nao tiver ele é apenas impresso
	slt $25,$10,$14  
	beq $25,$19,cmp
	slt $25,$10,$12
	beq $25,$19,escrever
	slt $25,$10,$15  
	beq $25,$19,cmp
	j escrever
	
cmp: slt $25,$10,$12//verifica se a letra é maior ou menor que o caractere 'a'
	beq $25,$19,somar//se for menor,soma
	j subt//se nao,sub
somar: addi $10,$10,32//soma de 32 para caracteres menor que a
j escrever

subt: addi $10,$10,-32//subtrai de 32 para caracteres maior que a
      
j escrever

escrever:
		sb $10,0($26)//guarda o caractere na string
		sb $0,1($26)//coloca o caractere nulo no final
        la $4,string
        jal printf//imprime caractere 
        j loop2

final:
.end start