DATABASE sales

MAIN
    DEFINE p_cliente RECORD LIKE cliente.*
    
    CALL clear_screen()
    
    OPEN WINDOW w_cliente AT 3,3 WITH 18 ROWS, 76 COLUMNS
        ATTRIBUTE (BORDER, COMMENT LINE 19)
    
    DISPLAY "REGISTRO DE CLIENTES" AT 1,25
        ATTRIBUTE (REVERSE, BLUE)
    
    INPUT BY NAME p_cliente.* ATTRIBUTE (REVERSE, WITHOUT DEFAULTS)
        
        BEFORE FIELD cliente_id
            DISPLAY "Ingrese el ID del cliente (obligatorio)" AT 19, 1
        
        AFTER FIELD cliente_id
            IF p_cliente.cliente_id IS NULL THEN
                ERROR "El ID del cliente no puede estar vacío"
                NEXT FIELD cliente_id
            END IF
        
        BEFORE FIELD nombre
            DISPLAY "Ingrese el nombre del cliente (obligatorio)" AT 19, 1
        
        AFTER FIELD nombre
            IF p_cliente.nombre IS NULL THEN
                ERROR "El nombre del cliente no puede estar vacío"
                NEXT FIELD nombre
            END IF
        
        BEFORE FIELD apellido
            DISPLAY "Ingrese el apellido del cliente (obligatorio)" AT 19, 1
        
        AFTER FIELD apellido
            IF p_cliente.apellido IS NULL THEN
                ERROR "El apellido del cliente no puede estar vacío"
                NEXT FIELD apellido
            END IF
        
        BEFORE FIELD direccion
            DISPLAY "Ingrese la dirección del cliente (opcional)" AT 19, 1
        
        BEFORE FIELD telefono
            DISPLAY "Ingrese el teléfono del cliente (formato: XXX-XXX-XXXX)" AT 19, 1
        
        AFTER FIELD telefono
            IF p_cliente.telefono IS NOT NULL THEN
                IF NOT p_cliente.telefono MATCHES "[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" THEN
                    ERROR "Formato de teléfono inválido. Use: XXX-XXX-XXXX"
                    NEXT FIELD telefono
                END IF
            END IF
        
        BEFORE FIELD email
            DISPLAY "Ingrese el email del cliente (opcional)" AT 19, 1
        
        BEFORE FIELD credito_limite
            DISPLAY "Ingrese el límite de crédito (debe ser mayor que cero)" AT 19, 1
        
        AFTER FIELD credito_limite
            IF p_cliente.credito_limite IS NOT NULL THEN
                IF p_cliente.credito_limite <= 0 THEN
                    ERROR "El límite de crédito debe ser mayor que cero"
                    NEXT FIELD credito_limite
                END IF
            END IF
        
        ON KEY (F1)
            CALL mostrar_ayuda()
            
        ON KEY (ESC)
            IF PROMPT "¿Desea salir sin guardar? (S/N)" FOR CHAR user_resp
            MATCHES "[Ss]" THEN
                EXIT INPUT
            END IF
    
        AFTER INPUT
            IF NOT campo_invalido(p_cliente) THEN
                IF PROMPT "¿Desea guardar los datos? (S/N)" FOR CHAR user_resp
                MATCHES "[Ss]" THEN
                    INSERT INTO cliente VALUES (p_cliente.*)
                    IF sqlca.sqlcode = 0 THEN
                        MESSAGE "Cliente registrado correctamente"
                        SLEEP 2
                    ELSE
                        ERROR "Error al insertar cliente: ", sqlca.sqlerrm
                        NEXT FIELD cliente_id
                    END IF
                END IF
            END IF
    
    END INPUT
    
    CLOSE WINDOW w_cliente
    
    CLEAR SCREEN
    
    MENU "MENÚ PRINCIPAL"
        COMMAND "Regresar al formulario" "Volver a mostrar el formulario de registro"
            CALL main()
        
        COMMAND "Salir" "Salir de la aplicación"
            EXIT MENU
    END MENU

END MAIN

FUNCTION campo_invalido(p_rec)
    DEFINE p_rec RECORD LIKE cliente.*
    
    IF p_rec.cliente_id IS NULL THEN
        ERROR "El ID del cliente no puede estar vacío"
        RETURN TRUE
    END IF
    
    IF p_rec.nombre IS NULL THEN
        ERROR "El nombre del cliente no puede estar vacío"
        RETURN TRUE
    END IF
    
    IF p_rec.apellido IS NULL THEN
        ERROR "El apellido del cliente no puede estar vacío"
        RETURN TRUE
    END IF
    
    RETURN FALSE
    
END FUNCTION

FUNCTION mostrar_ayuda()
    DEFINE tecla CHAR(1)
    
    OPEN WINDOW w_ayuda AT 5,10 WITH 10 ROWS, 60 COLUMNS
        ATTRIBUTE (BORDER, COMMENT LINE LAST)
    
    DISPLAY "AYUDA DEL FORMULARIO" AT 1, 20 ATTRIBUTE (REVERSE)
    DISPLAY " F1     - Mostrar esta ayuda" AT 3, 5
    DISPLAY " TAB    - Moverse al siguiente campo" AT 4, 5
    DISPLAY " SHIFT+TAB - Moverse al campo anterior" AT 5, 5
    DISPLAY " ENTER  - Confirmar entrada" AT 6, 5
    DISPLAY " ESC    - Salir del formulario" AT 7, 5
    
    DISPLAY "Presione cualquier tecla para continuar..." AT 9, 10
    LET tecla = INKEY()
    
    CLOSE WINDOW w_ayuda
    
END FUNCTION

FUNCTION clear_screen()
    CLEAR SCREEN
END FUNCTION

# Explicación del Formulario en i4GL
-- El código que he creado es un formulario para registro de clientes desarrollado en Informix-4GL (i4GL), un lenguaje de programación diseñado específicamente para crear aplicaciones de bases de datos empresariales. A continuación, explico sus componentes principales:
-- Estructura General

-- Conexión a la base de datos: DATABASE sales conecta el programa a la base de datos llamada "sales".
-- Función Principal (MAIN): Define el flujo principal del programa, donde se establece:

-- Una variable de registro (p_cliente) basada en la estructura de la tabla "cliente"
-- La interfaz gráfica para ingreso de datos
-- La lógica de validación de campos


-- Ventana de Interfaz: Se crea mediante OPEN WINDOW con dimensiones específicas (18 filas, 76 columnas) y atributos como bordes y línea de comentarios.

-- Manejo de Entradas
-- El formulario utiliza la instrucción INPUT BY NAME para capturar los datos del cliente con varias características:

-- Validaciones por campo:

-- BEFORE FIELD: Muestra instrucciones antes de que el usuario ingrese a un campo específico
-- AFTER FIELD: Valida el dato ingresado después de que el usuario complete un campo


-- Validaciones implementadas:

-- Campos obligatorios (ID, nombre y apellido)
-- Formato de teléfono (XXX-XXX-XXXX)
-- Valor numérico positivo para límite de crédito


-- Teclas especiales:

-- F1: Muestra un menú de ayuda
-- ESC: Permite salir del formulario con confirmación



-- Funciones Auxiliares

-- campo_invalido(): Verifica si algún campo obligatorio está vacío
-- mostrar_ayuda(): Despliega una ventana con información sobre las teclas disponibles
-- clear_screen(): Limpia la pantalla

-- Características Destacadas

-- Feedback al usuario: Proporciona mensajes claros sobre los datos esperados
-- Validación completa: Tanto a nivel de campo como antes de guardar el registro
-- Manejo de errores: Captura errores de la base de datos (campo sqlca.sqlerrm)
-- Confirmaciones: Solicita confirmación antes de acciones importantes (salir, guardar)
-- Navegación sencilla: Incluye un menú principal para regresar al formulario o salir

-- Este formulario demuestra las capacidades fundamentales de i4GL para crear interfaces de usuario robustas y validaciones de entrada para aplicaciones de base de datos profesionales.