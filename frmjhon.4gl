DATABASE FORMONLY
SCREEN
{  # lo que se muestra al usuario es lo que estará dentro de las llaves
    --------------------------------------------------
    titulo
    Nombre....................: [var1         ] # nombre del atributo que se declara local - en los corchetes aparecen la cantidad de campos mostrar 
    --------------------------------------------------
}
ATTRIBUTES
var1 = formonly.nom_pro TYPE CHAR; # a var1 le asigno formonly.nom_pro
var3 = formonly.fec_empaque TYPE FORMAT="yyyy/mm/dd";
var4 = formonly.bolsa_num TYPE INTEGER;
# f1 = formonly.cliente_id, CHAR(5), REQUIRED;
# formonly.nom_pro = viene siendo la variable pero de cara a 4GL

END

# para llamar un formulario, debe llamarlo un módulo