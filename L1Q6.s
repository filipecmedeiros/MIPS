#include <iregdef.h>
.data 
demost: .asciiz "O char que estava em inteiro complementado a dois eh %c\n" 
msgerro: .asciiz "Nao foi possivel converter, valor informado nao esta entre 0 e 255\n"
palavra: .asciiz "11111111111111111111111111010000" #ascii"z" poe null no final da string por padrao 
#[valor atual eh = 48]
valor0: .word 48		# 48 equivale ao simbolo 0
valor1: .word 49		# 49 equivale ao simbolo 1

.text
.globl start
.ent start
start: 
la a0,palavra 	#carrega o endereço inicial da string 
lw s0,valor0    #por constante de comparação com 0 nas ascii
lw s1,valor1	#por constante de comparação com 1 nas ascii
move v0,zero    #garantir que v0 nao inicie com lixo
move v1,zero    #garantir que v1 nao inicie com lixo
lb t4,0(a0)		#guarda o primeiro char

leitura:
lb t0,0(a0) 			#carrega char palavra[0]
addi a0,a0,1 			#incremente a base para o proximo char
beq t0,zero,validade 	#se o char eh nulo entao para de ler pois a palavra acabou
beq t0,s0,por0  		#verifica se deve por 0 em v0
beq t0,s1,por1  		#verifica se deve por 1 em v0

por0:
sll v0,v0,1     		#desloca acrescentando um 0 no bit menos significativo
b leitura				# volta a procurar mais valores

por1:
sll v0,v0,1				#desloca acrescentando um 0 no bit menos significativo
ori v0,v0,1				#acrescenta 1 no bit menos significativo
b leitura				# volta a procurar mais valores

validade:
bne t4,s1,menorq0		#se nao for negativo ignore o complemento a 2 e faça validação
not s3,v0				#complementa a 1 v0 e guarda em s3
addi s3,s3,1			#complenta a 2
menorq0:
slti t1,s3,0			#verifica se o valor eh menor que zero
bne  t1,zero,erro		#se nao for va para erro e atualize v1
menorq256:
slti t2,s3,256          #verifica se o valor esta entre os possiveis para um char
beq  t2,zero,erro       #se nao for va para erro e atualize v1
# se quiser ver char no console [quando possivel conversao]
la a0,demost			#formato da string
move a1,s3				#valor para ser colocada na variavel %c da string acima
jal printf				#carrega os parametros passados em a0 e a1 e chama a funcao imprimir
j   _exit 				#comando para rotina de saida
#fim da impressao no console
b fim 					#o valor eh um char valido e nada deve ser feito, e esta guardado em s3

erro:
addi v1,v1,1
# se quiser ver char no console [quando nao eh possivel conversao]
la a0,msgerro			#formato da string
jal printf				#carrega os parametros passados em a0 e a1 e chama a funcao imprimir
j   _exit 				#comando para rotina de saida
#fim da impressao no console

fim:
.end start