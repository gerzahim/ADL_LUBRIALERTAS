$(document).ready(function(){
	BorderFooter();
	auditoria();
	segDate();
	ValidarFormularios();
});


function BorderFooter(){
	$("#container #footer").corner("6px");
}

// Para los sub-modulos
function act_mod(valor,cantidad,nivel,id,num){
	var i;
	var refer;
	
	if(nivel==2){
		refer= id+'_'+num;
	}
	else{
		refer= valor;
	}
		
	if($('#mod_'+refer).attr("checked")){
		for(i=1; i<=cantidad; i++){
			$('#mod_'+valor+'_'+i).attr("disabled","");
			$('#add_'+valor+'_'+i).attr("disabled","");
			$('#upd_'+valor+'_'+i).attr("disabled","");
			$('#del_'+valor+'_'+i).attr("disabled","");
		}
	}
	else{
		for(i=1; i<=cantidad; i++){
			$('#mod_'+valor+'_'+i).attr("disabled","disabled");
			$('#add_'+valor+'_'+i).attr("disabled","disabled");
			$('#upd_'+valor+'_'+i).attr("disabled","disabled");
			$('#del_'+valor+'_'+i).attr("disabled","disabled");
		}
	}
	
}

// Para buscar la informacion de la persona si cambia el tipo de Personal 
function auditoria(){
	$('#selectCargo').change(
		function(){
				// Datos para la busqueda de los municipios
				var cargo= $("#selectCargo").val();
				$.ajax({
					beforeSend: function(){
						$('#selectPersona').val("Cargando.....");
					},
					type: 'POST',
					url: 'ajax/Ajax.php',
					data: 'opcion=auditoria&cargo='+cargo,
					dataType: 'xml',
					success: function(xml){ procesaXml(xml); }
				});
			$('#selectPersona').focus();
		}
	);
}

//  Agrega las opciones de resultado procesando el XML
function procesaXml(xml) {
	var clave= $("resultado",xml).text();
	var ident= "#"+clave;
	
	// Remueve las opciones antes creadas e ingresa una de default
	$(ident).removeOption(/./);
	
	// Ingresa las opciones de el resultado de busqueda
	$("item",xml).each(
		function(id){
			var num= $("item",xml).get(id);
			$(ident).addOption($("codigo",num).text(), $("nombre",num).text(), false);
		}
	);
}

// Para la fecha
function segDate(){
	// Referencia de idioma
	popUpCal.regional['es']= {
		clearText: '', closeText: '',
		//clearText: 'Limpiar', closeText: 'Cerrar',
		prevText: '&lt;Ant', nextText: 'Sig&gt;', currentText: '', //currentText: 'Hoy',
		dayNames: ['Dom','Lun','Mar','Mie','Jue','Vie','Sab'],
		monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
		closeAtTop: false,
		speed: 'fast'
	};
	popUpCal.setDefaults(popUpCal.regional['es']);
	
	// Cuando se ejecute el formulario
	$('input.fecha2').calendar({
		autoPopUp: 'button', 
		buttonImageOnly: true, 
		//buttonImage: 'images/calendar2.png', 
		buttonImage: 'images/calendar.gif', 
		buttonText: 'Calendario'
	});
}

// Para validar fecha 
function ValiDate(){
		var fechaA= $('#date1').val();
		var fechaB= $('#date2').val();
		
		var fecha1= fechaA.toString();
		fecha1= fecha1.split("/");
		var dia1= fecha1[0];
		var mes1= fecha1[1];
		var anyo1= fecha1[2];
		
		var fecha2= fechaB.toString();
		fecha2= fecha2.split("/");
		var dia2= fecha2[0];
		var mes2= fecha2[1];
		var anyo2= fecha2[2];
		
		if(anyo1 < anyo2){ var x=true; }
		else{
			if(mes1 > mes2){ var x=false; }
			else{
				if((mes1 == mes2) && (dia1 > dia2)){ var x=false; }
				else{ var x=true; }
			}
		}
		
		if(!x){
			$('#fecha_incorrecta').show('slow');
			$(fechaA).focus();
			return false;
		}
		else{
		return true;
		}
}

// Para validar los formularios
function ValidarFormularios(){
	// Metodo para validar que solo sean numeros y letras
	jQuery.validator.addMethod(
		"alfanumerico",
		function(value, element) {
			return this.required(element) || /^[a-z\d]+$/i.test(value);
		},
		"Por favor solo letras y numeros, sin caracteres especiales!!"
	);
	
	// Metodo para validar que solo sean los caracteres para el rif
	jQuery.validator.addMethod(
		"codempresa", 
		function(value, element) {
			return this.required(element) || /^[a-z\-\d]+$/i.test(value);
		}, 
		"Por favor, ingrese numeros o letras (incluyendo el guion) sin caracteres especiales"
	);
	
	// Metodo para validar que solo sean los caracteres para el rif
	jQuery.validator.addMethod(
		"numerorif", 
		function(value, element) {
			return this.required(element) || /^[jve\-\d]+$/i.test(value);
		}, 
		"Por favor, ingrese correctamente el RIF!!"
	);
	
	// Metodo para validar que solo sean numeros,letras o guion
	jQuery.validator.addMethod(
		"codigofield",
		function(value, element) {
			return this.required(element) || /^[a-z\-\d]+$/i.test(value);
		},
		"Por favor solo letras, numeros o guion, sin caracteres especiales!!"
	);
	
	// Metodo para validar que solo sean numeros con comas
	jQuery.validator.addMethod(
		"numerofloat",
		function(value, element) {
			return this.required(element) || /^[.\d]+$/i.test(value);
		},
		"Por favor solo numeros y punto, sin letras ni caracteres especiales!!"
	);
	
	// Metodo para validar que solo sean numeros y letras
	jQuery.validator.addMethod(
		"loginformat",
		function(value, element) {
			return this.required(element) || /^[_\.a-z\d]+$/i.test(value);
		},
		"Por favor solo letras o numeros (se incluye el underscore y el punto)"
	);
	
	// formulario a validar
	$("#frm1").validate();
	
	// propone un indicador tomando en cuenta el email
	$("#txt_indicador").focus(function() {
		var correo= $("#txt_email").val();
		if ( correo && !this.value ){
			var posicion= correo.indexOf ("@");
			this.value= correo.substr (0, posicion);
		}
	});
}

// Para automarcar accesos
function act_access(refer){
	$('#mod_'+refer).attr("checked","checked");
}


function deleteCookie( name, path, domain ) {
	if ( getCookie( name ) ) document.cookie = name + '=' +
			( ( path ) ? ';path=' + path : '') +
			( ( domain ) ? ';domain=' + domain : '' ) +
			';expires=Thu, 01-Jan-1970 00:00:01 GMT';
}