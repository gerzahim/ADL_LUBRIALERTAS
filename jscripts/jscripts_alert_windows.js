// ClosingVar =true
// window.onbeforeunload = ExitCheck;
// function ExitCheck()
// {  
// ///control de cerrar la ventana///
//  if(ClosingVar == true) 
//   { ExitCheck = false
//     return "Recuerde que para el buen desempeño del sistema Lubrialertas, Usted para salir del sistema primero debe CERRAR SESION !!! (Boton Superior a la Derecha) ";
//   }
// }
var d = document;

function cmdata(pag,escribir,elementos){

// Podríamos indicar que estamos cargando los datos.... que espere, :p, pero no lo haremos a
// d.getElementById(escribir).innerHTML='Cargando datos...';

// Compatibilidad con firefox, opera y cualquier otro BUEN navegador
if(typeof(XMLHttpRequest)!='undefined'){
try
{
var pet = new XMLHttpRequest();
} catch(e) {}
} else {
// Compatibilidad para el navegador más asqueroso del planeta [ IE ]
try
{
var pet = new ActiveXObject('Microsoft.XMLHTTP'); } catch(e){
var pet = new ActiveXObject('Msxml2.XMLHTTP');
}
}
// una vez incializado el objeto y definido en el contexto de nuestro script
// Intentaremos abrir la conexión a la dirección indicada por la variable 'pag'

try
{
// esto bien podría cambiar a "pet.open('GET',pag,true);" si se desea pasar los datos mediante método GET
pet.open('POST',pag,true);

}
catch(e)
{
return false;
}
// Esta variable envía una cabecera indicando que enviaremos los datos método 'post' en forma urlencoded
// ejemplo ("mi_variable=cosa&otra_variable=otra_cosa");
pet.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
// Enviamos los datos 'elementos'
pet.send(elementos);
try {
// Justo cuando el estatus de la petición cambia esperamos a que sea igual a 4 que es igual a OK.
pet.onreadystatechange = function (){
if(pet.readyState == 4){
// ¡¡¡ Listo !!!, ahora ya tenemos el resultado y podemos acceder a él desde 'pet.responseText'
// El resultado lo vamos a escribir en el elemento 'escribir' ...
d.getElementById(escribir).innerHTML = pet.responseText;
}
}
} catch(e) {
return false;
}
return;
}
// Con esta función crearemos algo como un 'bucle' de tiempo
// Esto para que se ejecute cada 'ptimer' segundos.
function setTimer(cad,ptimer){
eval(cad);
setTimeout("setTimer('"+cad+"',"+ptimer+")",ptimer);
} 