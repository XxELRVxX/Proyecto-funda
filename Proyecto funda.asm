.model large

.data

  ;Variables numericas
    
    opcion db ?
    num1 db ?
    num2 db ?
    unidades db ?
    decenas db ?
    cuadro_1 db 0
    cuadro_2 db 0
    cuadro_3 db 0
    cuadro_4 db 0
    cuadro_5 db 0
    cuadro_6 db 0
    cuadro_7 db 0
    cuadro_8 db 0
    cuadro_9 db 0 
    

    
  ;Variables del guardado del archivo
  ruta db 'C',':','\','$',00h ;especificar directorio del archivo
  mg db 10,13, "Ingresa nombre del archivo: $"
  mg2 db 10,13, "Ingresa nombre con el que quieres aparecer: $"
  msg4 db 10,13, "Archivo creado: $" 
  decision1 db 10,13, "Estas seguro de que quieres agregar este cambio S/N: $"  
  texto db 10,13, "Contenido: $"
  exito db 10,13, "Exito: $"
  nombre_txt db 13 dup('$') 
  handle dw 0
  aux dw 0
  vec db 50 dup('$')   
  
    
    
  ;Variables string  
    ;Lineas 
    linea_h db '-','$'
    linea_v db '|','$'
    
    ;String comunes
    msg_juegos db 'Menu de juego','$'
    encabezado db 'Nombre de los integrantes: Esteban Rodriguez vargas, Mauricio Leon Bermudez','$' 
    encabezado2 db 'Segundo semestre 2022','$'
    opcion_juego db 'Opciones de juego (1) ','$'  
    opcion_txt db 'Mostrar los resultados de ganadores (2)','$'
    salir db 'Salir (3)','$'
    confirmar_salir db 'Esta seguro de que desea salir? ','$' 
    seleccion db 'Por favor, seleccione una opcion: ','$'
    error db 'ERROR: Opcion seleccionada incorrecta: ','$' 
    empezar_partida db 'Iniciar partida(1) ','$'
    opcion_volver_jugar db 'Volver a jugar(1)','$'
    opcion_guardar_resul db 'Guardar el resultado del ganador(2)','$'
    opcion_crear_archivo db 'Crear archivo (para primer partida)(3)','$' 
    nombre_1 db 'Ingrese nombre del jugador 1: ','$'
    nombre_2 db 'Ingrese nombre del jugador 2: ','$' 
    nombre1 db 100 dup ('$')
    nombre2 db 100 dup ('$') 
    jugador_1 db 'El simbolo del jugador 1 es la X y su nombre es: ','$'
    jugador_2 db 'El simbolo del jugador 2 es el O y su nombre es: ','$'
    press_enter db 'Presione ENTER','$'
    simbolo_player1 db 'X','$'
    simbolo_player2 db 'O','$'
    msg_victoria_jugador1 db 'El ganador ha sido el <JUGADOR 1>','$'
    msg_victoria_jugador2 db 'El ganador ha sido el <JUGADOR 2>','$'
    
    
    
    
    
.code
;-------------------------Pasar los elementos de la seccion de datos al DS------------------------------------
    mov ax, @data
    mov ds, ax   

;-------------------------Creando el encabezado---------------------------------------------------------------    
    
    ;Mosstrando encabezado en pantalla
    mov ah, 09h
    lea dx, encabezado
    int 21h
    
    ;Salto de linea
    mov bh,0  ;Pagina
    mov dh,1  ;Renglon
    mov dl,0  ;Columna
    mov ah,2  ;Servicio 
    int 10h
    
    ;Mostrando encabezado 2.0
    mov ah, 09h
    lea dx, encabezado2
    int 21h
    
    
;-------------------------Creando menu principal--------------------------------------------------------------

  ;Creando opciones de juego
  
     ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,4  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h
      
      
      ;Mostrando opcion de juego en pantalla
      mov ah, 09h
      lea dx, opcion_juego
      int 21h
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,5  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h  
      
      ;Mostrando opcion de archivo .txt en pantalla
      mov ah, 09h
      lea dx, opcion_txt
      int 21h   
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,6  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h 
      
      ;Mostrando opcion de salir en pantalla
      mov ah, 09h
      lea dx, salir
      int 21h
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,8  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h 
      
      ;Mostrando opcion de seleccionar en pantalla
      mov ah, 09h
      lea dx, seleccion
      int 21h 
      
      ;Se define la opcion seleccionada
      mov ah,01h    ; Aca se ingresa la opcion a seleccionar
      int 21h
      sub al,30h ; En esta linea se arregla lo del codigo ASCII
      mov opcion,al   ; En esta linea se guarda el valor de entrada en la variable de opcion del menu
      
      ;Realizar la comparacion 
      mov al, opcion 
      mov bl, 1
      cmp al, bl
      je opciones_juego
      jmp comparacion_2
      
      
      
      comparacion_2:
        mov bl, 2
        cmp al, bl
        je menu_txt
        jmp comparacion_3    
        
        
      comparacion_3:
        mov bl, 3
        cmp al, bl
        je opcion_salir
        jmp mensaje_error
        
      
      
    ;Opcion de jugar
    opciones_juego: 
      ;Primero limpiar pantalla 

      mov ah,0Fh ;Servicio
      int 10h
      mov ah,0
      int 10h    
      
      ;Mostrar menu
      
      mov ah,09h
      lea dx,msg_juegos
      int 21h
      
      ;Salto de linea    
      mov bh,0      ; Indico pagina
      mov dh,3      ; Indico renglon
      mov dl,0      ; Indico columna
      mov ah,2      ; Servicio
      int 10h
      
      ;Mostrar opcion #1
      mov ah,09h
      lea dx,empezar_partida
      int 21h
      
      ;Salto de linea    
      mov bh,0      ; Indico pagina
      mov dh,4      ; Indico renglon
      mov dl,0      ; Indico columna
      mov ah,2      ; Servicio
      int 10h  
      
      ;Mostrar opcion salir
      mov ah, 09h
      lea dx, salir
      int 21h
      
      ;Salto de linea    
      mov bh,0      ; Indico pagina
      mov dh,6      ; Indico renglon
      mov dl,0      ; Indico columna
      mov ah,2      ; Servicio
      int 10h
      
      ;Mosstrando opcion de seleccionar en pantalla
      mov ah, 09h
      lea dx, seleccion
      int 21h 
      
      ;Se define la opcion seleccionada
      mov ah,01h    ; Aca se ingresa la opcion a seleccionar
      int 21h
      sub al,30h ; En esta linea se arregla lo del codigo ASCII
      mov opcion,al   ; En esta linea se guarda el valor de entrada en la variable de opcion del menu
      
      ;Realizar la comparacion 
      mov al, opcion 
      mov bl, 1
      cmp al, bl
      je  inico_juego
      jmp comparacion_juego
      
      
      comparacion_juego:
        mov bl, 3
        cmp al, bl
        je opcion_salir
        jmp mensaje_error  
      
         
 
  
  
  ;Opcion de mostrar el .TXT con los resultados del ganador
  menu_txt:
  ;Proceso de leer
    mov ah, 09
    mov dx,offset mg
    int 21h
    mov si, 3
    call ciclo
    
    abrir:
    mov ah,3dh ;Instrucion para abrir el archivo
    mov al, 0h  ;0h solo lectura, 1h solo escritura
    mov dx,offset ruta 
    int 21h
    mov handle, ax
    
    ;Leer archivo
    mov ah, 3fh ;Lectura del archivo
    mov bx, handle
    mov dx, offset vec
    mov cx, aux
    int 21h
    
    mov ah,09h
    mov dx, offset texto
    int 21h
    
    mov ah,09h
    mov dx, offset vec
    int 21h
    
    mov ah, 3eh ;Cierre de archivo 
    int 21h
    jmp fin
    
  ;Opcion de salir
  opcion_salir:
  
  ;Limpiar pantalla
  mov ah,0Fh ;Servicio
  int 10h
  mov ah,0
  int 10h
  
  
  ;Mostrar mensaje de confirmacion
  mov ah,09h
  lea dx,confirmar_salir
  int 21h
  
  jmp fin
  
    
    
;-------------------------Juego de gato-----------------------------------------------------------------------    
    

  inico_juego:
  ;Primero limpiar pantalla 

        mov ah,0Fh ;Servicio
        int 10h
        mov ah,0
        int 10h
        
        ;Solicitar ingreso de nombres
        mov ah, 09h
        lea dx, nombre_1
        int 21h  
        
        ;Inicio de ingreso nombre 1
        mov si, 00h
        leer:
        
          mov ax, 0000
          mov ah, 01h
          int 21h
          ;Se guarda el valor tecleado por el usuario en la posicion 'si' del vector
          mov nombre1[si],al
          inc si ; Incrementar nuestro contador
          cmp al,0dh ;Se repite el ingreso de datos hasta que se teclee un Enter 
          ja leer
          jb leer  
        
        ;Limpiar pantalla
        mov ah,0Fh ;Servicio
        int 10h
        mov ah,0
        int 10h  
        
        ;Solicitar ingreso de nombre 2
        mov ah, 09h
        lea dx, nombre_2
        int 21h  
        
        ;Inicio de ingreso nombre 2
        mov si, 00h 
        
        leer1:
        
          mov ax, 0000
          mov ah, 01h
          int 21h
          ;Se guarda el valor tecleado por el usuario en la posicion 'si' del vector
          mov nombre2[si],al
          inc si ; Incrementar nuestro contador
          cmp al,0dh ;Se repite el ingreso de datos hasta que se teclee un Enter 
          ja leer1
          jb leer1
        
        ;Limpiar pantalla
        mov ah,0Fh ;Servicio
        int 10h
        mov ah,0
        int 10h
        

        ver: 
          
          ;Mostrar jugador 1
          mov ah, 09h
          lea dx, jugador_1
          int 21h
        
          mov dx,offset nombre1 ;Imprime el contenido del vector con la misma instruccion de una cadena
          mov ah, 09h
          int 21h 
          
          ;Hace salto de linea
          mov bh,0      ; Indico pagina
          mov dh,3      ; Indico renglon
          mov dl,0      ; Indico columna
          mov ah,2      ; Servicio
          int 10h  
          
          ;Mostrar jugador 2
          mov ah, 09h
          lea dx, jugador_2
          int 21h
          
          mov dx,offset nombre2 ;Imprime el contenido del vector con la misma instruccion de una cadena
          mov ah, 09h
          int 21h
          
          ;Hace salto de linea
          mov bh,0      ; Indico pagina
          mov dh,6      ; Indico renglon
          mov dl,0      ; Indico columna
          mov ah,2      ; Servicio
          int 10h
          
          ;Mensaje que solcita que presione enter el usuario
          mov ah, 09h
          lea dx, press_enter
          int 21h
          
          ;Instruccion para esperar que se presione enter
          mov ah, 01h
          int 21h
          
          ;Limpiar pantalla
            mov ah,0Fh ;Servicio
            int 10h
            mov ah,0
            int 10h 
          
          
          
          
  gato:   
    
    ;Modo video
    mov ah, 0 ;Configurar modo 
    mov al, 13h ;320x200 Pixeles, 256 colores
    int 10h ;Set del modo video
    
    mov ah, 0ch ;Configura para un solo pixel
    mov al, 0fh ;Color negro
      
    mov dx, 5 ;Coordenada y
    mov cx, 110 ;Coordenada x 
    
    mov dx, 5 ;Coordenada y
    mov cx, 110 ;Coordenada x
    Linea1: 
        inc dx ;Incremento coordenada   
        int 10h ;Set del color del pixel
        cmp dx, 70 ;Valor maximo
        jne Linea1 ;Brinca si no es cero
        
    mov dx, 5 ;Coordenada y
    mov cx, 60 ;Coordenada x
    
    Linea2:   
        inc dx ;Incremento coordenada
        int 10h ;Set del color del pixel
        cmp dx, 70 ;Valor maximo
        jne Linea2 ;Brinca si no es cero
        
    mov dx, 25 ;Coordenada y     
    mov cx, 30 ;Coordenada x
    
    Linea3:
        inc cx ;Incrementa coordenada
        int 10h; Set del color del pixel
        cmp cx, 140
        jne Linea3
    
    mov dx, 50 ;Coordenada y     
    mov cx, 30 ;Coordenada x
        
    Linea4:
        inc cx ;Incrementa coordenada
        int 10h; Set del color del pixel
        cmp cx, 140
        jne Linea4
        
    inicioCursor:
        mov ah, 0 ;Activar cursor con instruccion 0
        int 33h ;Interrupcion para acceder al hardware
        mov ax, 1
        int 33h
        
    boton:    
        mov ax, 3
        int 33h
        shr cx, 1
        cmp bx, 0
        je na
        cmp bx, 1
        je turno_jugador1 
    
    na: ;Etiqueta de cursor sin presionar click
        jmp boton ;Regresa a etiqueta 
    
    turno_jugador1:
        
    pintar_cuadro1:
        cmp cx, 3Ah ;Compara la coordenada cx en el puntero
        jng cuadro1 ;Si es menor que, se va hacia la etiqueta
        cmp cx, 6Ch ;Si lo de antes no se cumplio verifica si cx es menor a la coordenada del puntero
        jng cuadro4 ;Si es menor que, se va hacia la etiqueta 
        cmp cx, 8Bh ;;Si lo de antes no se cumplio verifica si cx es menor a la coordenada del puntero
        jng cuadro7 ;Si es menor que, se va hacia la etiqueta     
        
    cuadro1: 
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro2 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_1
        mov bl, 0
        cmp al, bl
        jnz boton
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_1, 1
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
        
    cuadro2:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro3 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_2
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_2, 1
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1  
        
    cuadro3:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_3
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_3, 1
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
        
    cuadro4:    
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro5 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_4
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_4, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
    
    cuadro5:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro6 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_5
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h 
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_5, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
    
    cuadro6:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_6
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h 
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_6, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
        
    cuadro7:
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro8 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_7
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_7, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
    
    cuadro8:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro9 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_8
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_8, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1
    
    cuadro9:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_9
        mov bl, 0
        cmp al, bl
        jnz boton                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h  
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_9, 1
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player1 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador1  
        
    verificacion1_victoria_jugador1: 
        mov bl, 1
        mov al, cuadro_1
        cmp al, bl
        
        je verificacion2_victoria_jugador1  
        jne verificacion4_victoria_jugador1 
    
    verificacion2_victoria_jugador1:
        mov al, cuadro_1
        mov bl, cuadro_2
        cmp al, bl
        
        je verificacion3_victoria_jugador1 
        jne verificacion4_victoria_jugador1
    
    verificacion3_victoria_jugador1:
        mov bl, cuadro_2
        mov al, cuadro_3 
        cmp al, bl
        
        je ganador_jugador1
        jne verificacion4_victoria_jugador1    
    
    verificacion4_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_1
        cmp al, bl
        
        je verificacion5_victoria_jugador1
        jne verificacion7_victoria_jugador1 
       
    verificacion5_victoria_jugador1:
        mov al, cuadro_1  
        mov bl, cuadro_4
        cmp al, bl
        
        je verificacion6_victoria_jugador1
        jne verificacion7_victoria_jugador1
    
    verificacion6_victoria_jugador1:
        mov bl, cuadro_4
        mov al, cuadro_7
        cmp al, bl 
        
        je ganador_jugador1
        jne verificacion7_victoria_jugador1 
    
    verificacion7_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_1
        cmp al, bl 
        
        je verificacion8_victoria_jugador1
        jne verificacion10_victoria_jugador1
    
    verificacion8_victoria_jugador1:
        mov al, cuadro_1
        mov bl, cuadro_5
        cmp al, bl 
        
        je verificacion9_victoria_jugador1
        jne verificacion10_victoria_jugador1
        
    verificacion9_victoria_jugador1: 
        mov bl, cuadro_5
        mov al, cuadro_9
        cmp al, bl 
        
        je ganador_jugador1
        jne verificacion10_victoria_jugador1
        
    verificacion10_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_7
        cmp al, bl
        
        je verificacion11_victoria_jugador1
        jne verificacion13_victoria_jugador1
    
    verificacion11_victoria_jugador1:
        mov al, cuadro_7
        mov bl, cuadro_8
        cmp al, bl 
        
        je verificacion12_victoria_jugador1 
        jne verificacion13_victoria_jugador1
       
    verificacion12_victoria_jugador1:
        mov bl, cuadro_8  
        mov al, cuadro_9
        cmp al, bl
        
        je ganador_jugador1
        jne verificacion13_victoria_jugador1
    
    verificacion13_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_2
        cmp al, bl
        
        je verificacion14_victoria_jugador1
        jne verificacion16_victoria_jugador1
        
    verificacion14_victoria_jugador1:
        mov al, cuadro_2
        mov bl, cuadro_5
        cmp al, bl
        
        je verificacion15_victoria_jugador1
        jne verificacion16_victoria_jugador1
    
    verificacion15_victoria_jugador1:
        mov al, cuadro_8
        mov bl, cuadro_5
        cmp al, bl
        
        je ganador_jugador1
        jne verificacion16_victoria_jugador1
        
    verificacion16_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_3
        cmp al, bl
        
        je verificacion17_victoria_jugador1
        jne verificacion19_victoria_jugador1
    
    verificacion17_victoria_jugador1:
        mov al, cuadro_3
        mov bl, cuadro_6
        cmp al, bl
        
        je verificacion18_victoria_jugador1
        jne verificacion19_victoria_jugador1
        
    verificacion18_victoria_jugador1:
        mov bl, cuadro_6
        mov al, cuadro_9
        cmp al, bl
        
        je ganador_jugador1
        jne verificacion19_victoria_jugador1
        
    verificacion19_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_4
        cmp al, bl
        
        je verificacion20_victoria_jugador1
        jne verificacion22_victoria_jugador1 
        
    verificacion20_victoria_jugador1:
        mov al, cuadro_4
        mov bl, cuadro_5
        cmp al, bl
        
        je verificacion21_victoria_jugador1
        jne verificacion22_victoria_jugador1
        
    verificacion21_victoria_jugador1:
        mov bl, cuadro_5
        mov al, cuadro_6
        
        je ganador_jugador1
        jne verificacion22_victoria_jugador1
        
    verificacion22_victoria_jugador1:
        mov bl, 1
        mov al, cuadro_3
        cmp al, bl
        
        je verificacion23_victoria_jugador1    
        jne turno_jugador2
        
    verificacion23_victoria_jugador1:
        mov al, cuadro_3
        mov bl, cuadro_5
        cmp al, bl
        
        je verificacion24_victoria_jugador1
        jne turno_jugador2
        
    verificacion24_victoria_jugador1:
        mov bl, cuadro_5
        mov al, cuadro_7
        cmp al, bl
        
        je ganador_jugador1
        jne turno_jugador2
    
    boton1.1:    
        mov ax, 3
        int 33h
        shr cx, 1
        cmp bx, 0
        je na1.1
        cmp bx, 1
        je pintar_cuadro2 
    
    na1.1: ;Etiqueta de cursor sin presionar click
        jmp boton1.1 ;Regresa a etiqueta
         
    turno_jugador2:
        
    pintar_cuadro2:
        cmp cx, 3Ah ;Compara la coordenada cx en el puntero
        jng cuadro1_1 ;Si es menor que, se va hacia la etiqueta
        cmp cx, 6Ch ;Si lo de antes no se cumplio verifica si cx es menor a la coordenada del puntero
        jng cuadro4_1 ;Si es menor que, se va hacia la etiqueta 
        cmp cx, 8Bh ;;Si lo de antes no se cumplio verifica si cx es menor a la coordenada del puntero
        jng cuadro7_1 ;Si es menor que, se va hacia la etiqueta     
        
    cuadro1_1: 
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro2_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_1
        mov bl, 0
        cmp al, bl
        jnz boton1.1
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_1, 2
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
        
    cuadro2_1:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro3_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_2
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                 
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_2, 2
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2  
        
    cuadro3_1:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton1.1
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_3
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 5 ;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_3, 2
         
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
        
    cuadro4_1:    
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro5_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_4
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                 
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_4, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
    
    cuadro5_1:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro6_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_5
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h 
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_5, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
    
    cuadro6_1:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton1.1
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_6
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 10;Columna
        mov ah, 2
        int 10h 
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_6, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
        
    cuadro7_1:
        cmp dx, 16h ;Compara si Cx es menor a la del puntero
        jg cuadro8_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_7
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                
        
        mov bh, 0 ;Pagina
        mov dh, 1 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_7, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
    
    cuadro8_1:
        cmp dx, 30h ;Compara si Cx es menor a la del puntero
        jg cuadro9_1 ;Si es mayor va hacia la etiqueta
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_8
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                
        
        mov bh, 0 ;Pagina
        mov dh, 5 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_8, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
    
    cuadro9_1:
        cmp dx, 45h ;Compara si Cx es menor a la del puntero
        jg boton1.1
        
        ;Verifica si el cuadro se encuentra en uso
        mov al, cuadro_9
        mov bl, 0
        cmp al, bl
        jnz boton1.1                                 
        
        mov bh, 0 ;Pagina
        mov dh, 7 ;Renglon
        mov dl, 15;Columna
        mov ah, 2
        int 10h  
        
        ;Asignar que el jugador 1 ya marco el espacio
        mov cuadro_9, 2
        
        ;Colocar el caracter en pantalla
        lea dx, simbolo_player2 
        mov ah, 09h
        int 21h
        
        jmp verificacion1_victoria_jugador2
    
    verificacion1_victoria_jugador2: 
        mov bl, 2
        mov al, cuadro_1
        cmp al, bl
        
        je verificacion2_victoria_jugador2  
        jne verificacion4_victoria_jugador2 
    
    verificacion2_victoria_jugador2:
        mov al, cuadro_1
        mov bl, cuadro_2
        cmp al, bl     
        
        je verificacion3_victoria_jugador2 
        jne verificacion4_victoria_jugador2
    
    verificacion3_victoria_jugador2:
        mov bl, cuadro_2
        mov al, cuadro_3 
        cmp al, bl  
        
        je ganador_jugador2
        jne verificacion4_victoria_jugador2    
    
    verificacion4_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_1
        cmp al, bl
        
        je verificacion5_victoria_jugador2
        jne verificacion7_victoria_jugador2 
       
    verificacion5_victoria_jugador2:
        mov al, cuadro_1  
        mov bl, cuadro_4
        cmp al, bl
        
        je verificacion6_victoria_jugador2
        jne verificacion7_victoria_jugador2
    
    verificacion6_victoria_jugador2:
        mov bl, cuadro_4
        mov al, cuadro_7
        cmp al, bl
        je ganador_jugador2
        jne verificacion7_victoria_jugador2 
    
    verificacion7_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_1
        cmp al, bl 
        
        je verificacion8_victoria_jugador2
        jne verificacion10_victoria_jugador2
    
    verificacion8_victoria_jugador2:
        mov al, cuadro_1
        mov bl, cuadro_5
        cmp al, bl 
        
        je verificacion9_victoria_jugador2
        jne verificacion10_victoria_jugador2
        
    verificacion9_victoria_jugador2: 
        mov bl, cuadro_5
        mov al, cuadro_9
        cmp al, bl  
        
        je ganador_jugador2
        jne verificacion10_victoria_jugador2
        
    verificacion10_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_7
        cmp al, bl
        
        je verificacion11_victoria_jugador2
        jne verificacion13_victoria_jugador2
    
    verificacion11_victoria_jugador2:
        mov al, cuadro_7
        mov bl, cuadro_8
        cmp al, bl  
        
        je verificacion12_victoria_jugador2 
        jne verificacion13_victoria_jugador2
       
    verificacion12_victoria_jugador2:
        mov bl, cuadro_8  
        mov al, cuadro_9
        cmp al, bl 
        
        je ganador_jugador2
        jne verificacion13_victoria_jugador2
    
    verificacion13_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_2
        cmp al, bl
        
        je verificacion14_victoria_jugador2
        jne verificacion16_victoria_jugador2
        
    verificacion14_victoria_jugador2:
        mov al, cuadro_2
        mov bl, cuadro_5
        cmp al, bl
        
        je verificacion15_victoria_jugador2
        jne verificacion16_victoria_jugador2
    
    verificacion15_victoria_jugador2:
        mov al, cuadro_8
        mov bl, cuadro_5
        cmp al, bl
        
        je ganador_jugador2
        jne verificacion16_victoria_jugador2
        
    verificacion16_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_3
        cmp al, bl
        
        je verificacion17_victoria_jugador2
        jne verificacion19_victoria_jugador2
    
    verificacion17_victoria_jugador2:
        mov al, cuadro_3
        mov bl, cuadro_6
        cmp al, bl
        
        je verificacion18_victoria_jugador2
        jne verificacion19_victoria_jugador2
        
    verificacion18_victoria_jugador2:
        mov bl, cuadro_6
        mov al, cuadro_9
        cmp al, bl
        
        je ganador_jugador2
        jne verificacion19_victoria_jugador2
        
    verificacion19_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_4
        cmp al, bl
        
        je verificacion20_victoria_jugador2
        jne verificacion22_victoria_jugador2
        
    verificacion20_victoria_jugador2:
        mov al, cuadro_4
        mov bl, cuadro_5
        cmp al, bl
        
        je verificacion21_victoria_jugador2
        jne verificacion22_victoria_jugador2
        
    verificacion21_victoria_jugador2:
        mov bl, cuadro_5
        mov al, cuadro_6
        
        je ganador_jugador2
        jne verificacion22_victoria_jugador2
        
    verificacion22_victoria_jugador2:
        mov bl, 2
        mov al, cuadro_3
        cmp al, bl
        
        je verificacion23_victoria_jugador2
        jne turno_jugador1
    
    verificacion23_victoria_jugador2:
        mov al, cuadro_3
        mov bl, cuadro_5
        cmp al, bl
         
        je verificacion24_victoria_jugador2
        jne turno_jugador1
        
    verificacion24_victoria_jugador2:
        mov bl, cuadro_5
        mov al, cuadro_7
        cmp al, bl
        
        je ganador_jugador2
        jne turno_jugador1
    
        
ganador_jugador1: 
      ;Primero limpiar pantalla 

      mov ah,0Fh ;Servicio
      int 10h
      mov ah,0
      int 10h    
      
      ;Mostrar mensaje de victoria
      
      mov ah,09h
      lea dx, msg_victoria_jugador1
      int 21h
      
      ;Hace salto de linea
      mov bh,0      ; Indico pagina
      mov dh,6      ; Indico renglon
      mov dl,0      ; Indico columna
      mov ah,2      ; Servicio
      int 10h
          
      ;Mensaje que solcita que presione enter el usuario
      mov ah, 09h
      lea dx, press_enter
      int 21h
      
      ;Instruccion para esperar que se presione enter
      mov ah, 01h
      int 21h
      
      jmp post_partida1  

ganador_jugador2:
      ;Primero limpiar pantalla 

      mov ah,0Fh ;Servicio
      int 10h
      mov ah,0
      int 10h    
      
      ;Mostrar mensaje de victoria
      
      mov ah,09h
      lea dx, msg_victoria_jugador2
      int 21h
      
      ;Hace salto de linea
      mov bh,0      ; Indico pagina
      mov dh,6      ; Indico renglon
      mov dl,0      ; Indico columna
      mov ah,2      ; Servicio
      int 10h
          
      ;Mensaje que solcita que presione enter el usuario
      mov ah, 09h
      lea dx, press_enter
      int 21h
      
      ;Instruccion para esperar que se presione enter
      mov ah, 01h
      int 21h
      
      jmp post_partida1
      
;-------------------------Definir opciones post partida para ganador jugador 1-----------------------------------------------------------------------------------------------
  
  
post_partida1:
  
  ;Primero limpiar pantalla 

  mov ah,0Fh ;Servicio
  int 10h
  mov ah,0
  int 10h 
  
  
  ;Mostrar opcion de jugar de nuevo en pantalla
  mov ah, 09h
  lea dx, opcion_volver_jugar
  int 21h 
         
  ;Salto de linea
  mov bh,0  ;Pagina
  mov dh,2  ;Renglon
  mov dl,0  ;Columna
  mov ah,2  ;Servicio 
  int 10h 
  
  ;Mostrar opcion de guardar resultado
  mov ah, 09h
  lea dx, opcion_guardar_resul
  int 21h
          
  ;Salto de linea
  mov bh,0  ;Pagina
  mov dh,4  ;Renglon
  mov dl,0  ;Columna
  mov ah,2  ;Servicio 
  int 10h  
  
  ;Mostrar opcion de crar archivo
  mov ah, 09h
  lea dx, opcion_crear_archivo
  int 21h
  
  ;Salto de linea
  mov bh,0  ;Pagina
  mov dh,7  ;Renglon
  mov dl,0  ;Columna
  mov ah,2  ;Servicio 
  int 10h
  
  ;Mostrando opcion de seleccionar en pantalla
  mov ah, 09h
  lea dx, seleccion
  int 21h 
  
  ;Se define la opcion seleccionada
  mov ah,01h    ; Aca se ingresa la opcion a seleccionar
  int 21h
  sub al,30h ; En esta linea se arregla lo del codigo ASCII
  mov opcion,al   ; En esta linea se guarda el valor de entrada en la variable de opcion del menu
  
  
  ;Realizar la comparacion 
      mov al, opcion 
      mov bl, 1
      cmp al, bl
      je inico_juego 
      mov bl, 2
      cmp al, bl 
      je guardar_resultado1
      mov bl, 3
      cmp al,bl
      je crear_archivo
      jmp mensaje_error
               
          
          
  guardar_resultado1:
  ;proceso de actualizar
    mov ah, 09h
    lea dx,mg2 ;Imprimir mensaje
    int 21h
    mov si, 0
    
    pedir:
    mov ah, 01h
    int 21h
    mov vec[si],al
    inc si
    cmp al, 0dh
    ja pedir
    jb pedir
    
    mov ah, 09h
    lea dx, decision1 ;Imprimir mensaje
    int 21h
    mov ah,01h ;Solicitamos digito para elegir opcion 
    int 21h
    mov opcion, al
    mov ah,02h
    mov dl,0ah ;salto de linea
    int 21h
    cmp opcion, 110
    je fin
    
    editar:
    ;Abrir archivo
    push si
    mov si,3
    mov ah, 09h
    lea dx, mg ;imprimir mensaje
    int 21h
    call ciclo
    pop si
    mov ah,3dh
    mov al, 1h ;Abrimos archivo en solo escritura
    mov dx,offset ruta
    int 21h
    jc fin ;Si hubo un error 
    
    
    ;Escritura de archivo
    
    mov bx,ax ;mover hadfile
    mov cx,si ;num de caracteres a grabar
    mov dx, offset vec
    mov ah,40h
    int 21h
    cmp cx,ax
    jne fin ;error salir
    mov ah,3eh ;Ciere de archivo
    int 21h
    mov ah, 09h
    lea dx, exito ;imprimir mensaje
    int 21h
    jmp fin
  
    
 
  
;-------------------------Definir opciones post partida para ganador jugador 2--------------------------------------------------------------------------------  
          
  ;Mensaje que solcita que presione enter el usuario
  mov ah, 09h
  lea dx, press_enter
  int 21h
      
  ;Instruccion para esperar que se presione enter
  mov ah, 01h
  int 21h
      
  jmp fin       


;-----------------------------------------------------------------------------------------------------------------------------------     
  mensaje_error:
    ;Limpiar pantalla
    mov ah,0Fh ;Servicio
    int 10h
    mov ah,0
    int 10h
      
    ;Mostrar mensaje de error
    mov ah,09h
    lea dx,error
    int 21h
      
    jmp fin

;-------------------------Crear el archivo---------------------------------------------------------------------------------------------------------

  crear_archivo:
  ;proceso de crear
    mov ah,09
    mov dx, offset mg
    int 21h
    
    mov si, 3
    call ciclo
    
    
    mov ah,3ch
    mov cx,0
    mov dx, offset ruta 
    int 21h
    mov handle,ax 
    
    mov bx,ax
    mov ah,3eh
    int 21h 
    
    mov ah, 09h
    lea dx, msg4
    int 21h
    jmp fin
    
    
    ciclo:
    mov ah, 1h
    int 21h
    
    cmp al, 13d
    je terminar 
    cmp si, 16
    je terminar
    mov ruta[si], al
    inc si
    jb ciclo
    terminar:
    mov ruta[si], 0
    ret
  








  fin:
  
    mov ah,07
    int 21h
    mov ah,4ch
    int 21h 
    
    
    
  end
