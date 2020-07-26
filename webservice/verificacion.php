<?php
header('Content-Type: text/html; charset=utf-8');
// Archivo de variables de configuracion
require_once('../config/config.php');
$obj_config= new  ConfigVars();

// Directorio de las librerias para la funcion "__autoload()"
define(DIR_LIBRERIA,$obj_config->GetVar('ruta_libreria'));

/**
* LLamada automatica de los archivos de las clases a utilizar.
*
* @param string $className
*/
function __autoload($class_name) {
	require_once ('.'.DIR_LIBRERIA.$class_name.".php");
}

// Conexion a la base de datos
$obj_conexion= new Bd();
if( $obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db')) ){
	
	// Clases a utilizar
	$obj_date= new Fecha();
	$obj_generico= new Generica();
	$obj_sigelab= new ClassWebService();
	$obj_correo= new ClassMail();
		
	// Modelo asignado
	require('.'.$obj_config->GetVar('ruta_modelo').'ServicioWeb.php');
	$obj_modelo= new ServicioWeb($obj_conexion,$obj_config->GetVar('esquema'));
	
	
	//**********************************************//
	//******* Inicio Solicitudes Registradas *******//
	
	// Verifica las solicitudes que han sido registradas en sigelab
	$solicitudes= array();
	if($arreglo_lista= $obj_sigelab->ListadoSolicitudesRegistradas()){
		foreach($arreglo_lista as $llave => $valor){
			// Base de Datos
			$codigo_sigelab= $valor->codigo_sigelab;
			$fecha_registro= $obj_date->changeFormatDate($valor->fecha,2);
			if($obj_modelo->ActualizaEstatus($codigo_sigelab,$fecha_registro)){
				$solicitudes[]= array("codigo_sigelab"=>$codigo_sigelab, "fecha"=>date("d/m/Y"));
			}
		}
	}
	
	// Si consiguio solicitudes registradas y actualizo la BD de Lubrialertas
	if(count($solicitudes)>0){
		$solicitudes= array("solicitud"=>$solicitudes);
		
		// Confirma que se leyo un nuevo listado de registros de solicitudes en sigelab
		if(!$arreglo_codigos= $obj_sigelab->ConfirmarRegSolicitud($solicitudes)){
			// Registros confirmados
			//echo "Registros confirmados...<br>";
			
		}
		else{
			// Registros no confirmados
			//echo "Registros no confirmados...<br>";
		}
		
		unset($solicitudes);
	}
	
	//******* Fin Solicitudes Registradas *******//
	//*******************************************//
	
	
	
	
	
	//***********************************//
	//******* Inicio Certificados *******//
	
	// Certificaciones de solicitudes
	if($arreglo_certificado= $obj_sigelab->ConsultarCertificados()){
		$muestrasCert= array();
		foreach($arreglo_certificado as $llave=>$valor){
			// Limpia los acentos y otros caracteres especiales
			$laboratorio= $obj_generico->CleanText($valor->laboratorio);
			$cliente= $obj_generico->CleanText($valor->cliente);
			$representante= $obj_generico->CleanText($valor->representante);
			$contacto= $obj_generico->CleanText($valor->contacto);
			$direccion= $obj_generico->CleanText($valor->direccion);
			$fecha_recepcion= $obj_date->changeFormatDate($valor->fecha_recepcion,2);
			$numero_informe= $obj_generico->CleanText($valor->numero_informe);
			$fecha_emision= $obj_generico->CleanText($valor->fecha_emision);
			$numero_solicitud= $obj_generico->CleanText($valor->numero_solicitud);
			$codigo_muestra= $obj_generico->CleanText($valor->codigo_muestra);
			$codigo_muestra_lubrialertas= $obj_generico->CleanText($valor->codigo_muestra_cliente);
			$muestra= $obj_generico->CleanText($valor->muestra);
			$fecha_actual= date("Y-m-d");
			
			// Almacena la informacion del certificado en la BD
			if( $id_certificado= $obj_modelo->GuardaCertificado($laboratorio, $cliente, $representante, $contacto, $direccion, $fecha_recepcion, $numero_informe, $fecha_emision, $numero_solicitud, $codigo_muestra, $muestra, $fecha_actual, $codigo_muestra_lubrialertas) ){
				
				// Metodos
				foreach($valor->metodos as $llaveMetodo=>$valorMetodo){
					// Limpia los acentos y otros caracteres especiales
					$codigo_metodo= $obj_generico->CleanText($valorMetodo->codigo_metodo);
					$nombre= $obj_generico->CleanText($valorMetodo->nombre);
					$aprobado= $obj_generico->CleanText($valorMetodo->aprobado);
					
					//Verificar  si ya existe el metodo.
					if(!$existe_metodo= $obj_modelo->VerificarMetodo($id_certificado,$codigo_metodo)){  
						// Almacena la informacion del metodo en la BD
						if($id_metodo= $obj_modelo->GuardaMetodoCertificado($id_certificado,$codigo_metodo,$nombre,$aprobado)){
							
							// Resultados
							foreach($valorMetodo->resultados as $llaveResultado=>$valorResultado){
								// Limpia los acentos y otros caracteres especiales
								$codigo_metodo= $obj_generico->CleanText($valorResultado->codigo_metodo);
								$idprueba= $obj_generico->CleanText($valorResultado->idprueba);
								$prueba= $obj_generico->CleanText($valorResultado->prueba);
								$resultado= $obj_generico->CleanText($valorResultado->resultado);
								$fecha_emision= $obj_date->changeFormatDate($valor->fecha_emision,2);							
								$incertidumbre= $obj_generico->CleanText($valorResultado->incertidumbre);
								$fecha_reporte= $obj_date->changeFormatDate($valorResultado->fecha_reporte,2);
								$observacion= $obj_generico->CleanText($valorResultado->observacion);
								
								// Almacena la informacion del resultado en la BD
								$obj_modelo->GuardaResultadoMetodo($id_metodo, $codigo_metodo, $prueba, $resultado, $incertidumbre, $fecha_reporte, $observacion, $idprueba);
							}
						}
					}//END IF 
				}
				
				$codigo_muestra= str_replace('M','',$codigo_muestra);
				$muestrasCert[]= array("codigo_sigelab"=>$codigo_muestra,"fecha"=>date("d/m/Y"));
				$obj_modelo->ActualizaEstatusResultados($numero_solicitud,$codigo_muestra_lubrialertas,$fecha_actual);
			}
		}
		
		// Si guardo los certificados en la BD los confirma
		if(count($muestrasCert)>0){
			$muestrasCert= array("solicitud"=>$muestrasCert);
			
			// Confirma los certificados de las solicitudes
			if(!$arreglo_codigos= $obj_sigelab->ConfirmarCertSolicitud($muestrasCert)){
				// Certificados confirmados
				//echo "Certificados confirmados...<br>";
				$id_solicitudd= $obj_generico->CleanTextDb($obj_modelo->GetIdSolicitud($codigo_muestra_lubrialertas));
				$id_cliente= $obj_generico->CleanTextDb($obj_modelo->GetIdCliente($id_solicitudd['id_Solicitud']));
				$nombre_cliente= $obj_generico->CleanTextDb($obj_modelo->GetCliente($id_cliente['id_Cliente']));
	
	       //enviar correo a todos los asesores técnicos registrados en el sistema
				$personal= $obj_modelo->GetPersonal() ;
        if ($personal= $obj_modelo->GetPersonal()){     
      	  $obj_correo->sendMailSolicitudesporRecomendarTodos($personal,$nombre_cliente);
        }  			

			}
			else{
				// Certificados no confirmados
				//echo "Certificados no confirmados...<br>";
			}
			
			unset($muestrasCert);
		} 
	}
	
	//******* Fin Certificados *******//
	//********************************//

	if ($personal= $obj_modelo->GetPersonal()){ 
  
  $obj_correo->sendMailSolicitudesporRecomendarTodos($personal,'cliente prueba');

  }  
	
	
	//**********************************************//
	//******* Inicio PreRegistro Solicitudes *******//
	
	// Busca las solicitudes sin pre-registro
	$solicitudesPre= array();
	if( $result_solicitud= $obj_modelo->SolicitudSinPreRegistro() ){
		while($row_solicitud= $obj_conexion->GetArrayInfo($result_solicitud)){
			$codigo_solicitud= $row_solicitud["Cod_Solicitud"];
			$id_solicitud= $row_solicitud["id_Solicitud"];
			$motivo_analisis= $row_solicitud["Motivo_Analisis"];
			$cliente_solicitud= $row_solicitud["id_Cliente"];
			$cantidad_muestra= $row_solicitud["Cantidad_Muestras"];
			$muestras= array();
			
			// Busca las muestras de la solicitud
			if( $result_muestra= $obj_modelo->BuscarMuestras($id_solicitud) ){
				while($row_muestra= $obj_conexion->GetArrayInfo($result_muestra)){
					$muestras[]= array("codigo_muestra"=>$row_muestra["Cod_Muestra"], "tipo_muestra"=>$row_muestra["Producto_Grado"]);
				}
			}
			
			// Verifica que existan las muestras
			if( count($muestras)>0 ){
				// Si devuelve el codigo de sigelab se almacenaria en la BD
				if($codigo_sigelab= $obj_sigelab->PreRegistroSolicitud($codigo_solicitud,$motivo_analisis,$muestras)){
					// Guarda en un arreglo las solicitudes almacenadas en la BD para su confirmacion
					if($obj_modelo->ActualizaInfoSolicitud($codigo_sigelab,$id_solicitud)){
						$solicitudesPre[]= array("codigo_sigelab"=>$codigo_sigelab, "fecha"=>date("d/m/Y"));
						
						// Aqui viene la funcion para enviar el email de notificacion al transportista
						$transporte= $obj_generico->CleanTextDb( $obj_modelo->GetTransportista() );
						$cliente= $obj_generico->CleanTextDb( $obj_modelo->GetCliente($cliente_solicitud) );
						$obj_correo->sendMailSolicitudHecha($cliente['Nombre_Cliente'], $cliente['Email'], $cliente['Direccion_Cliente'], $cliente['Telefono_Oficina_Cliente'], $transporte['Nombre_Empresa'], $transporte['Persona_Contacto'], $transporte['Email'],$cantidad_muestra);
					}
				}
			}
		}
	}
	
	// Verifica que existan solicitudes en el arreglo para confirmarlas
	if( count($solicitudesPre)>0 ){
		$solicitudesPre= array("solicitud"=>$solicitudesPre);
		
		// Confirma el pre-registro de la solicitud
		if(!$arreglo_codigos= $obj_sigelab->ConfirmarPreSolicitud($solicitudesPre)){
			// Preregistros confirmados
			//echo "Preregistros confirmados...<br>";
		}
		else{
			// Preregistros no confirmados
			//echo "Preregistros no confirmados...<br>";
		}
		
		unset($solicitudesPre);
	}
	
	//******* Fin PreRegistro Solicitudes *******//
	//*******************************************//
	
}
?>