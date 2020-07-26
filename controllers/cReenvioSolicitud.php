<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'reenvio_solicitud'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'ServicioWeb.php');
$obj_modelo= new ServicioWeb($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){


	// Para verificar los preregistros y registros de solicitudes
	case 'retrans':
		// Clase para web service de SIGELAB
		$obj_sigelab= new ClassWebService('usuario_portal');
		
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
		
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 53, $obj_conexion, $obj_config->GetVar('esquema'));
		
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