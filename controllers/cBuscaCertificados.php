<?php
header('Content-Type: text/html; charset=utf-8');

// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'busca_certificados'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'ServicioWeb.php');
$obj_modelo= new ServicioWeb($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){


	// Para verificar los preregistros y registros de solicitudes
	case 'retrans':
		// Clase para web service de SIGELAB
		$obj_sigelab= new ClassWebService('usuario_portal');
		
		
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
				//$fecha_emision= $obj_generico->CleanText($valor->fecha_emision);
				$fecha_emision= $obj_date->changeFormatDate($valor->fecha_emision,2);
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
							if( $id_metodo= $obj_modelo->GuardaMetodoCertificado($id_certificado,$codigo_metodo,$nombre,$aprobado) ){
								
								// Resultados
								foreach($valorMetodo->resultados as $llaveResultado=>$valorResultado){
									// Limpia los acentos y otros caracteres especiales
									$codigo_metodo= $obj_generico->CleanText($valorResultado->codigo_metodo);
									$idprueba= $obj_generico->CleanText($valorResultado->idprueba);
									$prueba= $obj_generico->CleanText($valorResultado->prueba);
									$resultado= $obj_generico->CleanText($valorResultado->resultado);
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
		/*
		// Si guardo los certificados en la BD los confirma
		if(count($muestrasCert)>0){
			$muestrasCert= array("solicitud"=>$muestrasCert);
			
			// Confirma los certificados de las solicitudes
			if(!$arreglo_codigos= $obj_sigelab->ConfirmarCertSolicitud($muestrasCert)){
				// Certificados confirmados
				//echo "Certificados confirmados...<br>";
				$personal= $obj_generico->CleanTextDb($obj_modelo->GetPersonal());
				
				$id_solicitudd= $obj_generico->CleanTextDb($obj_modelo->GetIdSolicitud($codigo_muestra_lubrialertas));
				$id_cliente= $obj_generico->CleanTextDb($obj_modelo->GetIdCliente($id_solicitudd['id_Solicitud']));
				$nombre_cliente= $obj_generico->CleanTextDb($obj_modelo->GetCliente($id_cliente['id_Cliente']));
				
				$obj_correo->sendMailSolicitudesporRecomendar($personal['Email'],$personal['Nombres_Apellidos'],$nombre_cliente['Nombre_Cliente']);
			}
			else{
				// Certificados no confirmados
				//echo "Certificados no confirmados...<br>";
			}
			
			unset($muestrasCert);
		}*/
		}
		
		//******* Fin Certificados *******//
		//********************************//
		
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 54, $obj_conexion, $obj_config->GetVar('esquema'));
			
		// Redireccionamiento
		header('location:'.$obj_config->GetVar('index_page')."?op=".OPCION."&accion=ready");
		exit();
		break;
	
	
	// Para verificar los preregistros y registros de solicitudes
	case 'ready':
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.mensaje_listo');
		break;
		
	
	// Informacion Principal
	default:
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.mensaje_default');
		break;
		
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>