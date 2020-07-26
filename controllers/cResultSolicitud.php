<?php
//print_r( $_SESSION);
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'resultadosolicitud'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'ResultadoSolicitud.php');
$obj_modelo= new ResultadoSolicitud($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){

	case 'print':
	
		// Ruta actual
		//$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso',$_SESSION['Ruta_Tipo']);

		$id_Solicitud=$_GET['id'];
		$result =$obj_modelo->GetMuestras($id_Solicitud);

		// Determina el valor de las filas
		$i=1;
		while($row= $obj_conexion->GetArrayInfo($result)){
			if( ($i % 2) >0){
				$obj_xtpl->assign('estilo_fila', 'odd');
			}
			else{
				$obj_xtpl->assign('estilo_fila', 'even');
			}
			//Funcion para obtener el nombre de los equipos desde la tabla
			$equipo=$obj_modelo->GetNombreEquipo( $row['id_Equipo']);
			$obj_xtpl->assign( $obj_generico->CleanTextDb($equipo) );
			$obj_xtpl->assign('id_Muestra', $row['id_Muestra']);
			$obj_xtpl->assign('Capacidad_del_Sistema',  $equipo['Capacidad_Sistema']);
			$obj_xtpl->assign('Cod_Muestra', $row['Cod_Muestra']);
			$obj_xtpl->assign('Producto_Grado', $row['Producto_Grado']);	
			$obj_xtpl->assign('hora', $row['Horas']);
			$obj_xtpl->assign('km', $row['km']);
			$obj_xtpl->parse('main.contenido.tabla_muestra.lista_muestra');
			$i++;
			$arregloCod[]= array(
				"codigo"=>$row['Cod_Muestra'], 
				"equipo"=>'Equipo: '.$equipo['Codigo_Equipo'].' * '.$equipo['Nombre_Equipo']
			);
		}
		
		$codigo =$obj_modelo->GetCodSolicitud($id_Solicitud);
		$obj_xtpl->assign('Cod_Solicitud', $codigo);
		if(count($arregloCod)>0){
			foreach	($arregloCod as $i ){
				$obj_xtpl->assign('titulo', $i['equipo']);
				$obj_xtpl->assign('imagen', './export/image.php?code='.$i['codigo']);
				$obj_xtpl->parse('main.contenido.tabla_muestra.lista_codigo');
			}
		}
		
		//Asignacion para recibirlos despues en la opcion de exportar por el Get
		$obj_xtpl->assign('opciones','marca='.base64_encode(rand(3000,4000)).'&amp;sol='.base64_encode($id_Solicitud));
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.tabla_muestra');
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 13, $obj_conexion, $obj_config->GetVar('esquema'));
		break;



	case 'modificar':
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Status']);
		
		// Recibe el valor de la solicitud
		$id_Solicitud=$_GET['id_solicitud'];
		
		//Asigna el valor del id_solicitud
		$obj_xtpl->assign('id_Solicitud', $id_Solicitud);
	
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.modificacion');
		break;
	
	
	case 'cambiar':
		//funcion que actualiza el status
		$obj_modelo->ActualizaEntregaTransporte($_POST['id_solicitud'], date('Y-m-d'));
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 5, $obj_conexion, $obj_config->GetVar('esquema'));
		
		header('location:'.$_SESSION['Ruta_Status']);
		break;
		
	
	case 'status':
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Ruta actual Status
		$_SESSION['Ruta_Status']= $obj_generico->RutaRegreso();
		
		//Obtiene el id de la solicitud enviado por la url 
		$id_Solicitud=$_GET['id'];
		
		//llamada a la funcion para determinar el Id del Status y Codigo
		$arreglo = $obj_modelo->GetStatuSolicitud($id_Solicitud);
		
		//Asigna el valor del codigo 
		$obj_xtpl->assign('codigo_solicitud', $arreglo['Cod_Solicitud']);
		
		//Asigna el valor del id_solicitud
		$obj_xtpl->assign('id_Solicitud', $id_Solicitud);
		
		//llamada para saber el listado de todos los estatus
		$result = $obj_modelo->GetAllStatus();
		
		// Compara el Status de la Solicitud con respecto a todos los Status posibles en la Bd
		while($row= $obj_conexion->GetArrayInfo($result)){
		
			switch($row['id_Status']){
				case '1':
					$obj_xtpl->assign('fecha_estatus', $obj_date->changeFormatDate($arreglo['Fecha'],1) );
					$obj_xtpl->parse('main.contenido.status.lista_status.fecha_status_operacion');
					break;
					
				case '2':
					$obj_xtpl->assign('fecha_estatus', $obj_date->changeFormatDate($arreglo['fecha_transporte'],1) );
					$obj_xtpl->parse('main.contenido.status.lista_status.fecha_status_operacion');
					break;
					
				case '3':
					$obj_xtpl->assign('fecha_estatus', $obj_date->changeFormatDate($arreglo['fecha_registro'],1) );
					$obj_xtpl->parse('main.contenido.status.lista_status.fecha_status_operacion');
					break;
					
				case '5':
					$obj_xtpl->assign('fecha_estatus', $obj_date->changeFormatDate($arreglo['fecha_certificado'],1) );
					$obj_xtpl->parse('main.contenido.status.lista_status.fecha_status_operacion');
					break;
					
				case '6':
					$obj_xtpl->assign('fecha_estatus', $obj_date->changeFormatDate($arreglo['fecha_final'],1) );
					$obj_xtpl->parse('main.contenido.status.lista_status.fecha_status_operacion');
					break;
				
				default:
					break;
			}
			
			if($row['id_Status'] <= $arreglo['Status_Solicitud']){
				$obj_xtpl->assign('nombre_imagen', 'check');
			}
			else{
				$obj_xtpl->assign('nombre_imagen', 'spinner_16');
			}
			
			if($arreglo['Status_Solicitud']==1 && $row['id_Status']==2 && $_SESSION[OPCION.'_MOD']){
				$obj_xtpl->parse('main.contenido.status.lista_status.modificar_status');
			}
			$obj_xtpl->assign('nombre_status', $obj_generico->CleanTextDb($row['Nombre_Status']));
			$obj_xtpl->parse('main.contenido.status.lista_status');
		}
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.status');
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 4, $obj_conexion, $obj_config->GetVar('esquema'));
		break;




	case 'lista_muestra_recomendacion':
	
	
		// Ruta actual
		$_SESSION['Ruta_listas_recomendadas']= $obj_generico->RutaRegreso();
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso',$_SESSION['Ruta_Tipo']);
		
		$id_Solicitud=$_GET['id_sol'];
		$obj_xtpl->assign('id_Solicitud', $id_Solicitud);
		$result =$obj_modelo->GetMuestras($id_Solicitud);
		
		//Asignacion tipo de cuenta	
		$tipo=$_SESSION['InfoLogin']->GetTipo();
		$obj_xtpl->assign('tipo', $tipo);
		$obj_xtpl->assign('id_Solicitud', $id_Solicitud);		

		// Determina el valor de las filas
		$i=1;		
		while($row= $obj_conexion->GetArrayInfo($result)){
					if( ($i % 2) >0){
				$obj_xtpl->assign('estilo_fila', 'odd');
			}
			else{
				$obj_xtpl->assign('estilo_fila', 'even');
			}
			//Funcion para obtener el nombre de los equipos desde la tabla
			$equipo=$obj_modelo->GetNombreEquipo( $row['id_Equipo']);
			$obj_xtpl->assign( $obj_generico->CleanTextDb($equipo) );
			$obj_xtpl->assign('id_Muestras', $row['id_Muestra']);
			$obj_xtpl->assign('Cod_Muestra', $row['Cod_Muestra']);
			$obj_xtpl->assign('hora', $row['Horas']);
			$obj_xtpl->assign('km', $row['km']);
			$obj_xtpl->parse('main.contenido.lista_muestra_recomendacion.listas_muestras');
			$i++;
		}
				
		$codigo =$obj_modelo->GetCodSolicitud($id_Solicitud);
		$obj_xtpl->assign('Cod_Solicitud', $codigo);
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.lista_muestra_recomendacion');
		break;



	case 'ver_recomendacion':

		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_listas_recomendadas']);
		
		// Ruta actual
		$_SESSION['Ruta_Recomendacion']= $obj_generico->RutaRegreso();
		
		// Recibe el valor de la solicitud
		$id_Muestra=$_GET['id_Mues'];
				
		//echo $id_Muestra;
		// Asignacion de la variable
		$obj_xtpl->assign('id_Muestra', $id_Muestra);
		
		//Asignacion tipo de cuenta	
		$tipo=$_SESSION['InfoLogin']->GetTipo();
		$obj_xtpl->assign('tipo', $tipo);
				
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
			}
			
		//Funcion para obtener el codigo de la muestra 			
		$codigom =$obj_modelo->GetCodMuestra($id_Muestra);
		//echo $codigom;
		
		//*****************************************//
		//////////// Para el historial///////////////
		
		$detalle=$codigom;
		
		$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 7, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
		
		//*****************************************//
		
		// Funcion para obtener el numero de certificado segun el codigo de la muestra 			
		$idcertificado =$obj_modelo->ObtenerCertificado($codigom);
		//echo $idcertificado; 
		
		// Funcion para obtener el numero del metodo segun el numero de certificado
		$metodo =$obj_modelo->ObtenerMetodo_Certificado($idcertificado);
		while($rew= $obj_conexion->GetArrayInfo($metodo)){
				//echo $metodo;
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
				        		   $obj_xtpl->assign('NB', str_replace("&lt;br /&gt;", "",$fila['resultado']));
				        			break;
				        		case (1059):
				        		   $obj_xtpl->assign('AC', str_replace("&lt;br /&gt;", "",$fila['resultado']));
				        			break;
				        			
				        		default:
				        			break;
		        	      } 
				
				$i++;
				}
		}

		// Parseo del bloque de ver aditivos
		if($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){ 
			$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar.ver_aditivos');
		}

		
		// Parseo del enlace de modificacion
		if($_SESSION['InfoLogin']->GetTipo() == 'p'){
			$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar.enlace_modificar');

			$obj_xtpl->assign('id_equipo',$row['id_Equipo']);
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar.enlace_comportamiento');
		}
	
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.tabla_muestra_recomendar');
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 14, $obj_conexion, $obj_config->GetVar('esquema'));
		break;
		
				
	case 'modrec':
		$id_Muestra= base64_decode($_GET['muestra']);
		if( is_numeric($id_Muestra) ){
			// Ruta actual
			$_SESSION['Ruta_Form']= $obj_generico->RutaRegreso();
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Recomendacion']);
			
			// Campos requeridos y formato del campo para el javascript
			$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
		
			// Asignacion de la variable
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
					}
					
					//Funcion para obtener el codigo de la muestra 			
					$codigom =$obj_modelo->GetCodMuestra($id_Muestra);
					//echo $codigom;
					// Funcion para obtener el numero de certificado segun el codigo de la muestra 			
					$idcertificado =$obj_modelo->ObtenerCertificado($codigom);
					//echo $idcertificado; 
					// Funcion para obtener el numero del metodo segun el numero de certificado
					$metodo =$obj_modelo->ObtenerMetodo_Certificado($idcertificado);
					while($rew= $obj_conexion->GetArrayInfo($metodo)){
							//echo $metodo;
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
							        		case (1043):
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
							        		case (555):
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
							        		   $obj_xtpl->assign('NB', str_replace("&lt;br /&gt;", "",$fila['resultado']));
							        			break;
							        		case (1059):
							        		   $obj_xtpl->assign('AC', str_replace("&lt;br /&gt;", "",$fila['resultado']));
							        			break;
							        		default:
							        			break;
					        	      } 
							
							$i++;
							}
					}
		
						
						// Verifica si ya ha sido muestrado el equipo para parsear el enlace.
			if($obj_modelo->VerificaComportamiento($row['id_Equipo'])){
							// Para marca aleatoria
				$obj_xtpl->assign('aleatorio', base64_encode(rand(1000,2000)));
							
				// Para tipo de reporte
				$obj_xtpl->assign('tipo_reporte', base64_encode('CET05'));
							
				// Id del equipo
				$obj_xtpl->assign('id_equipo', base64_encode($row['id_Equipo']));
							
				// Parseo del bloque
				$obj_xtpl->parse('main.contenido.modifica_muestra_recomendar.enlace_comportamiento');
			}
						
			// Parseo del bloque de ver aditivos
			if($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){ 
				$obj_xtpl->parse('main.contenido.modifica_muestra_recomendar.ver_aditivos_modificar');
			}
						
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.modifica_muestra_recomendar');
						
			// Para el historial
			$detalle=$codigom;
			
			$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 7, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
			
		}else{
					header("location:".$_SESSION['Ruta_Recomendacion']);
					exit();
				}
				break;
		
	case "update":
		$registro= $_POST['muestra'];
		$recomendacion= $obj_generico->CleanText($_POST['txtrecomendacion']);
		if( is_numeric($registro) && !$obj_generico->IsEmpty($recomendacion)){
			// Para modificar la recomendacion
			$obj_modelo->ModificarRecomendacion($registro, $recomendacion);
			$_SESSION['mensaje']= $mensajes['recomendacion_modificada'];
			header("location:".$_SESSION['Ruta_Recomendacion']);
			exit();
		}
		else{
			header("location:".$_SESSION['Ruta_Lista']);
			exit();
		}
		break;
		
	case 'buscar':
		
		$clientes= $obj_modelo->ObtenerClientes();
		
		$raw= $obj_conexion->GetArrayInfo($clientes);
		
				
		while($raw= $obj_conexion->GetArrayInfo($clientes)){
			
			$obj_xtpl->assign('Id', $raw['id_Cliente']);
			$obj_xtpl->assign('Nombre', $raw['Nombre_Cliente']);
			$obj_xtpl->parse('main.contenido.buscar.permutar');
		}
		
		// Parseo final del status		
		$obj_xtpl->parse('main.contenido.buscar');
		break;
		
	case 'avanzada':
		
		$id = $_GET['id_nombre'];
		
		$tipo_usuario = "c";
			
		// Para la paginacion
		if(empty($_GET['pg'])){
			$pag= 1;
		}
		else{
			$pag= $_GET['pg'];
		}
		//Obtiene el numero de solicitudes
		$solicitudes = $obj_modelo->GetSolicitudes($obj_config->GetVar('num_registros'),$pag,$tipo_usuario,$id);
		
		if($solicitudes['total_registros']>0){
			// Determina el valor de las filas
			$i=1;
			while($row= $obj_conexion->GetArrayInfo($solicitudes['result'])){
				if( ($i % 2) >0){
					$obj_xtpl->assign('estilo_fila', 'odd');
				}
				else{
					$obj_xtpl->assign('estilo_fila', 'even');
				}
				$obj_xtpl->assign('cod_solcitud', $row['Cod_Solicitud']);
				$obj_xtpl->assign('id_Cliente', $row['id_Cliente']);
				$status=$row['Status_Solicitud'];
				
				// Switch Para determinar el valor en porcentaje
				switch($status){

					case 1:
					$porcentaje="10%";
					break;
					
					case 2:
					$porcentaje="20%";
					break;
					
					case 3:
					$porcentaje="40%";
					break;
					
					case 4:
					$porcentaje="60%";
					break;
					
					case 5:
					$porcentaje="80%";
					break;
					
					case 6:
					$porcentaje="100%";
					break;	
				}
				$obj_xtpl->assign('status', $porcentaje);	
				$obj_xtpl->assign('nombre_actor', $obj_generico->CleanTextDb($obj_modelo->GetNombreCliente($row['id_Cliente'])));
				$obj_xtpl->assign('fecha', $obj_date->changeFormatDate($row['Fecha'],1));
				$obj_xtpl->assign('id_Solicitud', $row['id_Solicitud']);
				$obj_xtpl->assign('hora', $row['Hora']);	
				$obj_xtpl->assign('cantidad_muestras', $row['Cantidad_Muestras']);	
				if ($porcentaje=="100%") $obj_xtpl->parse('main.contenido.tabla_solicitud.lista_solicitud.ver_recomendacion');
				$obj_xtpl->parse('main.contenido.tabla_solicitud.lista_solicitud');
				$i++;
			}

			// Datos para la paginacion
			$paginacion= $obj_generico->paginacion($solicitudes['pagina'],$solicitudes['total_paginas'],$solicitudes['total_registros'],$obj_generico->urlPaginacion());
			$obj_xtpl->assign('paginacion',$paginacion);
			if($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){			
				$obj_xtpl->parse('main.contenido.tabla_solicitud.agregar');
			}
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.tabla_solicitud');
			
		}
		else{
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.nosolicitudes');
		}
		
		break;
		
	
	
	// Muetra el listado de Solicitudes
	default:
	
	// Ruta actual
		$_SESSION['Ruta_Tipo']= $obj_generico->RutaRegreso();
		
		//Verificar  si es un cliente	
		if($_SESSION['InfoLogin']->GetTipo() == 'c'){
			$tipo_usuario=$_SESSION['InfoLogin']->GetTipo() ;
			//con el id_ cuenta_acceso, voy a bucar el id del cliente
			$id=$obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
			//$id retorna id cliente
		}
		
		//Verificar si es un Distribuidor	
		if($_SESSION['InfoLogin']->GetTipo() == 'd'){
			$tipo_usuario=$_SESSION['InfoLogin']->GetTipo() ;
			//con el id_ cuenta_acceso, voy a bucar en la tabla cliente y distribuidos dondel id del cliente y el id distribuidor 
			$id=$obj_modelo->GetIdDistribuidor($_SESSION['InfoLogin']->GetCuenta());
			//$id retorna id de distribuidor
		}
	
		
		// Para la paginacion
		if(empty($_GET['pg'])){
			$pag= 1;
		}
		else{
			$pag= $_GET['pg'];
		}
		
		//Obtiene el numero de solicitudes
		$solicitudes = $obj_modelo->GetSolicitudes($obj_config->GetVar('num_registros'),$pag,$tipo_usuario,$id);
		
		if($solicitudes['total_registros']>0){
			// Determina el valor de las filas
			$i=1;
			while($row= $obj_conexion->GetArrayInfo($solicitudes['result'])){
				if( ($i % 2) >0){
					$obj_xtpl->assign('estilo_fila', 'odd');
				}
				else{
					$obj_xtpl->assign('estilo_fila', 'even');
				}
				$obj_xtpl->assign('cod_solcitud', $row['Cod_Solicitud']);
				$obj_xtpl->assign('id_Cliente', $row['id_Cliente']);
				$status=$row['Status_Solicitud'];
				
				// Switch Para determinar el valor en porcentaje
				switch($status){

					case 1:
					$porcentaje="10%";
					break;
					
					case 2:
					$porcentaje="20%";
					break;
					
					case 3:
					$porcentaje="40%";
					break;
					
					case 4:
					$porcentaje="60%";
					break;
					
					case 5:
					$porcentaje="80%";
					break;
					
					case 6:
					$porcentaje="100%";
					break;	
				}
				$obj_xtpl->assign('status', $porcentaje);	
				$obj_xtpl->assign('nombre_actor', $obj_generico->CleanTextDb($obj_modelo->GetNombreCliente($row['id_Cliente'])));
				$obj_xtpl->assign('fecha', $obj_date->changeFormatDate($row['Fecha'],1));
				$obj_xtpl->assign('id_Solicitud', $row['id_Solicitud']);
				$obj_xtpl->assign('hora', $row['Hora']);	
				$obj_xtpl->assign('cantidad_muestras', $row['Cantidad_Muestras']);	
				if ($porcentaje=="100%") $obj_xtpl->parse('main.contenido.tabla_solicitud.lista_solicitud.ver_recomendacion');
				$obj_xtpl->parse('main.contenido.tabla_solicitud.lista_solicitud');
				$i++;
			}

			// Datos para la paginacion
			$paginacion= $obj_generico->paginacion($solicitudes['pagina'],$solicitudes['total_paginas'],$solicitudes['total_registros'],$obj_generico->urlPaginacion());
			$obj_xtpl->assign('paginacion',$paginacion);
			if($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){			
				$obj_xtpl->parse('main.contenido.tabla_solicitud.agregar');
			}
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.tabla_solicitud');
			
		}
		else{
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.nosolicitudes');
		}
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 10, $obj_conexion, $obj_config->GetVar('esquema'));
		break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>