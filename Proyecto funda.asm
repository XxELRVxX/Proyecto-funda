.model large

.data

  ;Variables numericas
    
    opcion db ?
    num1 db ?
    num2 db ?
    unidades db ?
    decenas db ?
    turno db 1
    mouse_x db ?
    mouse_y db ?
     
    
    
    
  ;Variables string  
    ;Lineas 
    linea_h db '-','$'
    linea_v db '|','$' 
    
    ;Simbolos
    simb_1 db 'X','$'  
    simb_2 db 'O','$'
    
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
    opcion_guardar_resul db 'Guardar el resultado del ganador(2)','$' 
    nombre_1 db 'Ingrese nombre del jugador 1: ','$'
    nombre_2 db 'Ingrese nombre del jugador 2: ','$' 
    nombre1 db 100 dup ('$')
    nombre2 db 100 dup ('$') 
    jugador_1 db 'El simbolo del jugador 1 es la X y su nombre es: ','$'
    jugador_2 db 'El simbolo del jugador 2 es el O y su nombre es: ','$'
    expl_tunro db 'El turno es del jugador ','$'
    turnoi db '1','$'
    turno_2 db '2','$' 
    press_enter db 'Presione ENTER','$'
    
    
    
    
    
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
      
         
        
        
        
     
    
     ;Opcion de guardar el resultado del ganador 
  
  
  ;Opcion de mostrar el .TXT con los resultados del ganador
  menu_txt:
    
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
      
    mov dx, 10 ;Coordenada del renglon
    mov cx, 220 ;Coordenada del renglon
    Linea1: 
        inc dx ;Incremento coordenada   
        int 10h ;Set del color del pixel
        cmp dx, 110 ;Valor maximo
        jne Linea1 ;Brinca si no es cero
        
    mov dx, 10 ;Coordenada del renglon
    mov cx, 120
    
    Linea2:   
        inc dx ;Incremento coordenada
        int 10h ;Set del color del pixel
        cmp dx, 110 ;Valor maximo
        jne Linea2 ;Brinca si no es cero
        
    mov dx, 40      
    mov cx, 50
    
    Linea3:
        inc cx ;Incrementa coordenada
        int 10h; Set del color del pixel
        cmp cx, 280
        jne Linea3
    
    mov dx, 80      
    mov cx, 50
        
    Linea4:
        inc cx ;Incrementa coordenada
        int 10h; Set del color del pixel
        cmp cx, 280
        jne Linea4
    
    ;Hace salto de linea
          mov bh,0      ; Indico pagina
          mov dh,20      ; Indico renglon
          mov dl,0      ; Indico columna
          mov ah,2      ; Servicio
          int 10h                                                                                                         
              
    ;Mostrar mensaje de de turno
    mov ah,09h
    lea dx,expl_tunro
    int 21h
    
    mov ah,09h
    lea dx, turnoi
    int 21h
    
    Inicio_cursor:
      mov ax,0 ;Activar cursor con instruccion 0
      int 33h ;interrupcion para acceder al hardware
      mov ax,1 ;mostrar cursor con instruccion 1
      int 33h ;interupcion para acceder al hardware 
      
    boton:
      mov ax,3 ;Leer posicion y accion con raton con instruccion 3
      int 33h ;Interrupcion para acceder al hardware
      shr cx, 1    ;Modo video al doble se divide x entre 2
      cmp bx, 0    ;Compara raton inactivo
      je na
      cmp bx, 1    ;Compara con click izquierdo
      je poner_simbolo
                 
                 
    poner_simbolo:
      cmp turno, 1
      je poner_x
      jmp poner_O  
      
    poner_X:
      mov ah, 09h
      lea dx, simb_1
      int 21h 
      
    
    poner_O:   
                
                                                                         
       
      
  ;Etiqueta de mouse inactivo 
  na:
  jmp boton
      
      
        
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


  fin:
  
    mov ah,07
    int 21h
    mov ah,4ch
    int 21h 
    
    
    
  end
