# pide un número y muestra el cuadrado, cuarta potencia del número

DEFINE given, product FLOAT , power INTEGER # las varibales son declaradas por nombre y tipo
    MAIN # cada programa tiene una sección MAIN, donde comienza la ejecución
        PROMPT "Enter a decimal number: " FOR given # lo que el usuario escribe se convierte en flotante en given
        LET product = given # la asignación se realiza con LET
        DISPLAY " Exponent value"
        FOR power = 2 TO 4
            LET product = product * given
            DISPLAY power, product
        END FOR
        SLEEP 5
END MAIN
