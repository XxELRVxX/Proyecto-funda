.model large

.data

  ;Variables numericas
    
    num1 db ?
    num2 db ?
    unidades db ?
    decenas db ?
    
  ;Variables string  
    
    encabezado db 'Nombre de los integrantes: Esteban Rodriguez vargas, Mauricio Leon Bermudez','$' 
    encabezado2 db 'Segundo semestre 2022','$'
    opcion_juego db 'Opciones de juego: ','$'
    jugar db 'Jugar partida','$'  
    opcion_txt db 'Mostrar los resultados del ganador','$'
    salir db 'Salir','$'
    
    
    
    
    
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
      
      
      ;Mosstrando encabezado en pantalla
      mov ah, 09h
      lea dx, opcion_juego
      int 21h
      
      
    ;Opcion de jugar
      
      
    
    ;Opcion de volver a jugar
    
    ;Opcion de guardar el resultado del ganador 
  
  
  ;Opcion de mostrar el .TXT con los resultados del ganador
    
  ; Opcion de salir
    
    
;-------------------------Juego de gato-----------------------------------------------------------------------    
    
    end