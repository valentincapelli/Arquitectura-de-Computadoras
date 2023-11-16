; 4) Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la
; subrutina char de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada
; en la variable clave. Si las dos cadenas son iguales entre si, la subrutina llamada respuesta mostrará el texto
; “Bienvenido” en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la
; subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave.

            .data
cadena:     .asciiz ""
valida:     .asciiz "Bienvenido"
erronea:    .asciiz "ERROR"
clave:      .asciiz "1234"
control:    .word 0x10000
data:       .word 0x10008

            .code
            daddi $t4, $zero, 4        ; pongo en $t4 en 4 para comparar
            while: dadd $s0, $zero, $zero   ; pongo en 0 para sumar 1 en cada rep
            loop: jal char             ; llamo a subrutina char  
            sb $v0, cadena($s0)        ; guardo el caracter en la posicion correspondiente de cadena
            daddi $s0, $s0, 1          ; sumo 1 a la cant de caracteres
            beq $s0, $t4 , listo        ; si $s0 llego a 4 sale del loop
            j loop
            listo: daddi $a0, $zero, cadena   ; le paso al argumento a0 la cadena que forme con los 4 caracteres
            daddi $a1, $zero, clave    ; le paso al argumento a1 la clave original
            jal respuesta              ; me devuelve 1 si la contraseña coincide
            dadd $s1, $zero, $v0       ; 1 correcta, 0 incorrecta 
            beqz $s1, while            ; mientras $v0 me devuelva 0 continuar
            halt

            char: ld $t0, data($zero) ; pongo la direccion de data en $t0
            ld $t1, control($zero)    ; pongo la direccion de control en $t1
            daddi $t3, $zero, 9       ; pongo el 9 en $t3
            sd $t3, 0($t1)            ; le mando a control 9 para que lea un caracter de teclado
            lbu $v0, 0($t0)           ; tomo ese caracter leido y lo guardo en $v0
            jr $ra

            respuesta: dadd  $t6, $zero, $zero
            ld $t0, data($zero) ; pongo la direccion de data en $t0
            ld $t1, control($zero)         ; pongo la direccion de control en $t0
            daddi $t4, $zero, 4            ; pongo $t4 en 4 para contar los caracteres
            lazo: lbu $t2, 0($a0)          ; tomo elemento actual de cadena que esta en $a0
            lbu $t3, 0($a1)                ; tomo elemento actual de la clave que esta en $a1
            beq $t2, $t3, seguir           ; si son iguales los dos primeros caracteres continua analizando
            j incorrecto                   ; si no son iguales imprime ERROR
            seguir: daddi $a0, $a0, 1       ; sumo 1 en $a0 para avanzar en la cadena
            daddi $a1, $a1, 1               ; sumo 1 en $a1 para avanzar en la clave
            daddi $t6, $t6, 1
            beq $t6, $t4, correcto         ; NO ENTIENDO
            j lazo

            incorrecto: daddi $t5, $zero, erronea ; cargo la direc de erronea en $t5
            sd $t5, 0($t0)      ; data = erronea
            daddi $v0, $zero, 0  ; devuelvo de la subrutina $v0 = 0
            daddi $t5, $zero, 4  ; cargo el 4 en $t5
            sd $t5, 0($t1)      ; control = 4
            j final
            correcto: daddi $t5, $zero, valida ; cargo la direc de valida en $t5
            sd $t5, 0($t0)           ; data = valida
            daddi $v0, $zero, 1     ; devuelvo de la subrutina $v0 =1
            daddi $t5, $zero, 4  ; cargo el 4 en $t5
            sd $t5, 0($t1)      ; control = 4
            final: jr $ra