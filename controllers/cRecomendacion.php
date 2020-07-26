<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'recomendacion'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Recomendacion.php');
$obj_modelo= new Recomendacion($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){

	case 'recomendar':
	
		// Ruta actual
		$_SESSION['Ruta_Form']= $obj_generico->RutaRegreso();

		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Campos requeridos y formato del campo para el javascript
		$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
			
		// Recibe el valor de la solicitud
		$id_Muestra=$_GET['id'];
		$id_Solicitud=$_GET['id_sol'];
			
		// Asignacion de la variable
		$obj_xtpl->assign('id_Solicitud', $id_Solicitud);
		$obj_xtpl->assign('id_Muestra', $id_Muestra);
		
		//Obtiene el numero de solicitudes
		$recomendaciones = $obj_modelo->GetMuestrasaRecomendar($id_Muestra);

		// Determina el valor de las filas
		$i=1;
		while($row= $obj_conexion->GetArrayInfo($recomendaciones)){
			if( ($i % 2) >0){
				$obj_xtpl->assign('estilo_fila', 'odd');
			}
			else{
				$obj_xtpl->assign('estilo_fila', 'even');
			}
			
			//Funcion para obtener el nombre de los equipos desde la tabla
			$equipo= $obj_modelo->GetNombreEquipoRecomendacion( $row['id_Equipo']);
			$obj_xtpl->assign( $obj_generico->CleanTextDb($equipo) );
			$obj_xtpl->assign('Cod_Muestra', $row['Cod_Muestra']);
			$obj_xtpl->assign('Producto_Grado', $row['Producto_Grado']);
			$obj_xtpl->assign('hora', $row['Horas']);
			$obj_xtpl->assign('km', $row['km']);
			$obj_xtpl->assign('id_Muestra', base64_encode( $row['id_Muestra']) );
			$obj_xtpl->assign('Recomendacion', $obj_generico->CleanTextDb($row['Recomendacion']));
			$i++;
			
						// Verifica si ya ha sido muestrado el equipo para parsear el enlace.
				if($obj_modelo->VerificaComportamiento($row['id_Equipo'])){
					/*
					// Para marca aleatoria
					$obj_xtpl->assign('aleatorio', base64_encode(rand(1000,2000)));
					
					// Para tipo de reporte
					$obj_xtpl->assign('tipo_reporte', base64_encode('CET05'));
					*/
					
					// Id del equipo
	
					//$obj_xtpl->assign('id_equipo', base64_encode($row['id_Equipo']));
	
					$obj_xtpl->assign('id_equipo',$row['id_Equipo']);
					
					// Parseo del bloque
	
					$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar.enlace_comportamiento');
				}
		}
			
		//Funcion para obtener el codigo de la muestra 			
		$codigom =$obj_modelo->GetCodMuestra($id_Muestra);
		
		//*****************************************//
		//////////// Para el historial///////////////
		
		$detalle=$codigom;
		
		$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 7, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
		
		//*****************************************//
		
		// Funcion para obtener el numero de certificado segun el codigo de la muestra 			
		$idcertificado =$obj_modelo->ObtenerCertificado($codigom);
		
		// Funcion para obtener el numero del metodo segun el numero de certificado
		$metodo =$obj_modelo->ObtenerMetodo_Certificado($idcertificado);
		
		while($rew= $obj_conexion->GetArrayInfo($metodo)){
				
				// Funcion para obtener los resultados de cada elemento del certificado 
				$parametros =$obj_modelo->ObtenerResultados($rew['id_metodo']);
							
				//Asignaciones de los parametros
					
				$i=1;
				while($fila= $obj_conexion->GetArrayInfo($parametros)){
						
							$prueba = $fila['idprueba'];
							
							
							switch ($prueba) {
				    			
				    			case (1045):
				        			$obj_xtpl->assign('FE', $fila['resultado']);
				        			break;
				        		case (1089):
				        		   $obj_xtpl->assign('CR', $fila['resultado']);
				        			break;
				        		case (1046):
				        		   $obj_xtpl->assign('PB', $fila['resultado']);
				        			break;
				        		case (1044):
				        		   $obj_xtpl->assign('CU', $fila['resultado']);
				        			break;
				        		case (1056):
				        		   $obj_xtpl->assign('SN', $fila['resultado']);
				        			break;
				        		case (1039):
				        		   $obj_xtpl->assign('AL', $fila['resultado']);
				        			break;
				        		case (1042):
				        		   $obj_xtpl->assign('CA', $fila['resultado']);
				        			break;
				        		case (1047):
				        		   $obj_xtpl->assign('MG', $fila['resultado']);
				        			break;
				        		case (1053):
				        		   $obj_xtpl->assign('SI', $fila['resultado']);
				        			break;
				        		case (1041):
				        		   $obj_xtpl->assign('B', $fila['resultado']);
				        			break;
				        		case (1055):
				        		   $obj_xtpl->assign('NA', $fila['resultado']);
				        			break;
				        		case (1051):
				        		   $obj_xtpl->assign('P', $fila['resultado']);
				        			break;
				        		case (1088):
				        		   $obj_xtpl->assign('ZN', $fila['resultado']);
				        			break;
								case (959):
									$obj_xtpl->assign('VISC100', str_replace("mm&amp;sup2;/s", "+/- ".$fila['incertidumbre']." cSt.",$fila['resultado']));
									break;
								case (958):
									$obj_xtpl->assign('VISC40', str_replace("mm&amp;sup2;/s", "+/- ".$fila['incertidumbre']." cSt.",$fila['resultado']));
									break;
				        		case (1034):
				        		   $obj_xtpl->assign('WATER', $fila['resultado']);
				        			break;
				        		case (1049):
				        		   $obj_xtpl->assign('MO', $fila['resultado']);
				        			break;
				        		case (1037):
				        		   $obj_xtpl->assign('CREPITACION', $fila['resultado']);
				        			break;
				        		case (1068):
				        		   $obj_xtpl->assign('HO', $fila['resultado']);
				        			break;
				        		case (999):
				        		   $obj_xtpl->assign('NB', $fila['resultado']);
				        			break;
				        		case (1059):
				        		   $obj_xtpl->assign('AC', $fila['resultado']);
				        			break;
				        			
				        		default:
				        			break;
		        	      } 
				
				$i++;
				}
		}
				
								
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar');
		
	break;
		
	
	case 'agregar':
	
		// Ruta actual
		$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso',$_SESSION['Ruta_Tipo']);
		
//		echo $_POST['txtrecomendacion'];
		// Recibe el valor de la solicitud
		$txtrecomendacion= $obj_generico->CleanText($_POST['txtrecomendacion']);
		$id_Solicitud=$_POST['id_Solicitud'];
		$id_Muestra=base64_decode($_POST['id_Muestra']);
		$id_cuenta_acceso=$_SESSION['InfoLogin']->GetCuenta();

		//echo $id_Muestra;
		if(!$obj_generico->IsEmpty($txtrecomendacion) && $obj_generico->IsNumerico($id_Solicitud) && $obj_generico->IsNumerico($id_Muestra)){
			// Para resgistrar la recomendacion
			$obj_modelo->RegistrarRecomendacion($id_Muestra, $txtrecomendacion,$id_cuenta_acceso);
			$cantidades= $obj_modelo->TraerValoresMuestras($id_Solicitud);
			$aumenta= $cantidades['Muestras_Listas'];
			$aumenta= $aumenta+1;
			$obj_modelo->ActualizaMuestrasListas($aumenta,$id_Solicitud);
			
			// Busca los datos del cliente y la solicitud
			$data= $obj_modelo->GetDatosClienteSolicitud($id_Muestra);
			$data= $obj_generico->CleanTextDb($data);
			
			if($cantidades['Cantidad_Muestras']==$aumenta){
				// Envia email al cliente informando que la solicitud esta ya lista
				$obj_correo->sendMailMuestrasListas($data['Nombre_Cliente'],$data['Email'],$data['Cod_Solicitud']);
				$date= $obj_modelo->GetAsesor($data['Asesor_Comercial']);
				$obj_correo->sendMailMuestrasListasAsesor($date['Nombres_Apellidos'],$date['Email'],$data['Cod_Solicitud']);
				
				//Actualiza el estatus en la BD
				$obj_modelo->ActualizaEstatusFinal($id_Solicitud,date('Y-m-d'));
			}
			
			//Parsea la confirmacion 			
			$obj_xtpl->parse('main.contenido.confirmacion');
			
			//*****************************************//
		   //////////// Para el historial///////////////
		
		   $detalle= "Solicitud Nº: ".$data['Cod_Solicitud'];
		
		   $obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 6, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
		
		   //*****************************************//
			
			$_SESSION['mensaje']= $mensajes['recomendacion_ok'];
			//header('location:'.$_SESSION['Ruta_Lista']);
		}
		else{
			header('location:'.$_SESSION['Ruta_Form']);
		}
		break;
		
		
	// Muetra el listado de Solicitudes
	default:
	
		// Ruta actual
		$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
		
		// Para la paginacion
		if(empty($_GET['pg'])){
			$pag= 1;
		}
		else{
			$pag= $_GET['pg'];
		}

		//Obtiene el numero de solicitudes
		$recomendaciones = $obj_modelo->GetMuestrasporRecomendar($obj_config->GetVar('num_registros'),$pag);
		
		//Validando si no hay ninguna muestra por recomendar
		if($recomendaciones['total_registros']>0){
			// Determina el valor de las filas
			$i=1;
			while($row= $obj_conexion->GetArrayInfo($recomendaciones['result'])){
				if( ($i % 2) >0){
					$obj_xtpl->assign('estilo_fila', 'odd');
				}
				else{
					$obj_xtpl->assign('estilo_fila', 'even');
				}
				//Funcion para obtener el nombre de los equipos desde la tabla
				$equipo=$obj_modelo->GetNombreEquipo( $row['id_Equipo']);
				$obj_xtpl->assign($equipo);
				$obj_xtpl->assign('id_Muestra', $row['id_Muestra']);
				$obj_xtpl->assign('id_Solicitud', $row['id_Solicitud']);
				$obj_xtpl->assign('Cod_Muestra', $row['Cod_Muestra']);
				$obj_xtpl->assign('hora', $row['Horas']);
				$obj_xtpl->assign('km', $row['km']);	
				$obj_xtpl->parse('main.contenido.tabla_muestra.lista_muestra');
				$i++;
			}

			// Datos para la paginacion
			$paginacion= $obj_generico->paginacion($recomendaciones['pagina'],$recomendaciones['total_paginas'],	$recomendaciones['total_registros'],$obj_generico->urlPaginacion());
			$obj_xtpl->assign('paginacion',$paginacion);
			
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.tabla_muestra');
		}
		else{
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.norecomendaciones');
		}
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 9, $obj_conexion, $obj_config->GetVar('esquema'));	
		break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>