import re

variables = {}

def ejecutar_linea(linea):
    if linea.startswith("LET"):
        # LET variable = valor
        _, resto = linea.split("LET", 1)
        nombre, valor = resto.strip().split("=", 1)
        nombre = nombre.strip()
        valor = valor.strip().strip('"')
        variables[nombre] = valor

    elif linea.startswith("DISPLAY"):
        # DISPLAY "Hola, ", nombre
        _, args = linea.split("DISPLAY", 1)
        partes = [p.strip() for p in args.strip().split(",")]
        salida = ""
        for parte in partes:
            if parte.startswith('"') and parte.endswith('"'):
                salida += parte.strip('"')
            else:
                salida += variables.get(parte, f"[{parte} indefinido]")
        print(salida)

def interpretar_codigo(codigo):
    dentro_de_main = False
    for linea in codigo.splitlines():
        linea = linea.strip()
        if linea == "MAIN":
            dentro_de_main = True
        elif linea == "END MAIN":
            dentro_de_main = False
        elif dentro_de_main and linea:
            ejecutar_linea(linea)

# Ejemplo
codigo_4gl = """
MAIN
    LET nombre = "Juan"
    LET saludo = "Hola"
    DISPLAY saludo, ", ", nombre
END MAIN
"""

interpretar_codigo(codigo_4gl)
