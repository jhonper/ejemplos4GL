FUNCTION message_box() # muestra un cuadro con un mensaje y espera una confirmación.
    DEFINE  caution_msg CHAR(50), # mensaje de advertencia (aunque no se le asigna valor aquí).
            confirm_msg CHAR(50), # mensaje de confirmación
            dummy SMALLINT        # TRUE si presiona "y" (sí), FALSE en caso contrario.
    LET confirm_msg = "Press any key to continue." # se asigna el mensaje al confirm_msg.
    CALL yesno_box(caution_msg, confirm_msg) RETURNING dummy # se llama a la función yesno_box y se guarda su retorno (booleano) en dummy.
END FUNCTION -- message_box --

FUNCTION yesno_box(caution_msg, confirm_msg) # crea una ventana donde se muestra un mensaje de advertencia
    DEFINE  caution_msg CHAR(50), # mensaje de advertencia (aunque no se le asigna valor aquí).
            confirm_msg CHAR(50), # mensaje de confirmación
            yes_no CHAR(1)        # para recibir el resultado de la función yesno_box.

    OPEN WINDOW w_yesno AT 10, 10 # abre una ventana Posición: fila 10, columna 10. Tamaño: 4 filas por 56 columnas.
        WITH 4 ROWS, 56 COLUMNS   # Tamaño: 4 filas por 56 columnas.
        ATTRIBUTE (BORDER, MESSAGE LINE FIRST+1, # Borde visible (BORDER), Línea de mensajes (MESSAGE LINE)
                    PROMPT LINE FIRST+2) # Línea de prompt para entrada de usuario (PROMPT LINE)

    MESSAGE caution_msg # muestra el mensaje de advertencia.
    PROMPT confirm_msg CLIPPED FOR CHAR yes_no # se muestra el mensaje de confirmación y se espera que el usuario ingrese una letra (sí o no).
    CLOSE WINDOW w_yesno # se cierra la ventana emergente.

    RETURN (DOWNSHIFT(yes_no) = "y") # Convierte la entrada del usuario a minúsculas. Devuelve TRUE si el usuario escribió "y" (sí), FALSE si escribió otra cosa.
END FUNCTION -- yesno_box --

# Nota: caution_msg no se inicializa, lo que puede causar que el mensaje de advertencia esté vacío. 
