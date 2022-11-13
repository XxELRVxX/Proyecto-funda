.model large

.data

  ;Variables numericas
    
    opcion db ?
    num1 db ?
    num2 db ?
    unidades db ?
    decenas db ?
    
  ;Variables string  
    
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
      
      
      ;Mosstrando opcion de juego en pantalla
      mov ah, 09h
      lea dx, opcion_juego
      int 21h
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,5  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h  
      
      ;Mosstrando opcion de archivo .txt en pantalla
      mov ah, 09h
      lea dx, opcion_txt
      int 21h   
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,6  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
      int 10h 
      
      ;Mosstrando opcion de salir en pantalla
      mov ah, 09h
      lea dx, salir
      int 21h
      
      ;Salto de linea
      mov bh,0  ;Pagina
      mov dh,8  ;Renglon
      mov dl,0  ;Columna
      mov ah,2  ;Servicio 
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
      
       
      
     ;Iniciar partida 
     
    
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
