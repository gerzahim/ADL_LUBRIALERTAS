<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'reporte'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Reporte.php');
$obj_modelo= new Reporte($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){
	
	// Graficos del comportamiento
	case 'grafico':
		$equipo= $_GET['id'];
		$componente= $obj_generico->CleanText($_GET['param']);
		
		if( !empty($equipo) && is_numeric($equipo) ){
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso',$_SESSION['Ruta_Comportamiento']);
			
			// Asignaciones
			$obj_xtpl->assign('accion_sistema','grafico');
			$obj_xtpl->assign('equipo',$equipo);
			($componente) ? $seleccion='selected="selected"' :  $seleccion="";
			$obj_xtpl->assign('seleccionado_'.$componente,$seleccion);
			
			// Datos del equipo para el titulo
			$obj_xtpl->assign($obj_generico->CleanTextDb($obj_modelo->GetDatosEquipo($equipo)));
			
			$data_link="";
			if($result= $obj_modelo->GetCertificadosEquipo($equipo)){
				$i=0;
				while($row= $obj_conexion->GetArrayInfo($result)){
					if( ($i % 2) >0){
						$obj_xtpl->assign('estilo_fila', 'odd');
					}
					else{
						$obj_xtpl->assign('estilo_fila', 'even');
					}
					// Link para crear el grafico
					$data_link.='&amp;f[]='.$obj_date->changeFormatDate($row['Fecha'],1);
					
					$result_res= $obj_modelo->GetResultadosEquipo($row['id_certificado']);
					while($row_res= $obj_conexion->GetArrayInfo($result_res)){
						$prueba = $row_res['idprueba'];
						switch ($prueba) {
				 			
				 			case (1045):
				     			$obj_xtpl->assign('FE', $row_res['resultado']);
				     		   if($componente=='fe') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
				     			break;
				     		case (1089):
				     		   $obj_xtpl->assign('CR', $row_res['resultado']);
				     		   if($componente=='cr') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
				     			break;
			        		case (1046):
			        		   $obj_xtpl->assign('PB', $row_res['resultado']);
			        		   if($componente=='pb') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1044):
			        		   $obj_xtpl->assign('CU', $row_res['resultado']);
			        		   if($componente=='cu') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1056):
			        		   $obj_xtpl->assign('SN', $row_res['resultado']);
			        		   if($componente=='sn') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1039):
								$obj_xtpl->assign('AL', $row_res['resultado']);
			        		   if($componente=='al') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1042):
			        		   $obj_xtpl->assign('CA', $row_res['resultado']);
			        		   if($componente=='ca') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1047):
			        		   $obj_xtpl->assign('MG', $row_res['resultado']);
			        		   if($componente=='mg') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1053):
			        		   $obj_xtpl->assign('SI', $row_res['resultado']);
			        		   if($componente=='si') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1041):
			        		   $obj_xtpl->assign('B', $row_res['resultado']);
			        		   if($componente=='b') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1055):
			        		   $obj_xtpl->assign('NA', $row_res['resultado']);
			        		   if($componente=='na') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1051):
			        		   $obj_xtpl->assign('P', $row_res['resultado']);
			        		   if($componente=='p') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1088):
			        		   $obj_xtpl->assign('ZN', $row_res['resultado']);
			        		   if($componente=='zn') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (959):
			        		   $obj_xtpl->assign('VISC100', str_replace("mm&amp;sup2;/s", "+/- ".$row_res['incertidumbre']." cSt.", $row_res['resultado']));
			        		   if($componente=='visc100') $resultado= trim($obj_generico->ConvertirANumero(substr($row_res['resultado'],0,5)));
			        			break;
			        		case (958): 
			        			$obj_xtpl->assign('VISC40', str_replace("mm&amp;sup2;/s", "+/- ".$row_res['incertidumbre']." cSt.", $row_res['resultado']));
								if($componente=='visc40') $resultado= trim($obj_generico->ConvertirANumero(substr($row_res['resultado'],0,5)));
			        			break;
			        		case (1034):
			        		   $obj_xtpl->assign('WATER', $row_res['resultado']);
			        		   if($componente=='water') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1049):
			        		   $obj_xtpl->assign('MO', $row_res['resultado']);
			        		   if($componente=='mo') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1037):
			        		   $obj_xtpl->assign('CREPITACION', $row_res['resultado']);
			        		   if($componente=='crepitacion') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1068):
			        		   $obj_xtpl->assign('HO', $row_res['resultado']);
			        		   if($componente=='ho') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (999):
			        		   $obj_xtpl->assign('NB', str_replace("&lt;br /&gt;", "",$row_res['resultado']));
			        		   if($componente=='nb') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
			        		case (1059):
			        		   $obj_xtpl->assign('AC', str_replace("&lt;br /&gt;", "",$row_res['resultado']));
			        		   if($componente=='ac') $resultado= trim($obj_generico->ConvertirANumero($row_res['resultado']));
			        			break;
				     		default:
				     			break;
				     	}
				     	
					}
					
					
					if($componente){
						//$data_link.='&amp;'.$componente.'[]='.$row[$obj_generico->ToUpper($componente)];
						$data_link.='&amp;'.$componente.'[]='.$resultado;
					}
					else{
					/*
						$data_link.='&amp;al[]='.$row['AL'];
						$data_link.='&amp;cr[]='.$row['CR'];
						$data_link.='&amp;cu[]='.$row['CU'];
						$data_link.='&amp;fe[]='.$row['FE'];
						$data_link.='&amp;sn[]='.$row['SN'];
						$data_link.='&amp;pb[]='.$row['PB'];
						$data_link.='&amp;na[]='.$row['NA'];
						$data_link.='&amp;si[]='.$row['SI'];
						$data_link.='&amp;b[]='.$row['B'];
						$data_link.='&amp;mg[]='.$row['MG'];
						$data_link.='&amp;visc100[]='.$row['VISC100'];
						*/
					}
					
					// Estilo css de la row_res
					if( ($i % 2) >0){
						$obj_xtpl->assign('estilo_fila', 'odd');
					}
					else{
						$obj_xtpl->assign('estilo_fila', 'even');
					}
					$i++;
					
					// Asignacion para la tabla
					$obj_xtpl->assign('fecha',$obj_date->changeFormatDate($row['Fecha'],1));
					$obj_xtpl->assign($row);
					
					// Parseo de la lista
					$obj_xtpl->parse('main.contenido.grafico_comportamiento.lista');
					$obj_xtpl->parse('main.contenido.grafico_comportamiento.param_aditivos.listab');
					$obj_xtpl->parse('main.contenido.grafico_comportamiento.listaa');
				}
				
				($componente) ? $tipo_graph='code=1&amp;param='.$componente:$tipo_graph="code=2";
			
				if($componente){
					// Imagen grafico
					$obj_xtpl->assign('imagen','./export/Grafico.php?'.$tipo_graph.$data_link);
				
					$obj_xtpl->parse('main.contenido.grafico_comportamiento.imagen_grafico');
				}
				
				// Para marca aleatoria
				$obj_xtpl->assign('aleatorio', base64_encode(rand(1000,2000)));
				
				// Para tipo de reporte
				$obj_xtpl->assign('tipo_reporte', base64_encode('CET05'));
			
				// Id del equipo
				$obj_xtpl->assign('id_equipo', base64_encode($equipo));
				
				($componente) ? $param='&amp;param='.$componente :  $param="";
				$obj_xtpl->assign('parametro', $param);
				
				// Parseo del link de exportar
				$obj_xtpl->parse('main.contenido.grafico_comportamiento.enlace_exportar');
			}
			//parseo del select de los aditivos y  
			if ($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){
						$obj_xtpl->parse('main.contenido.grafico_comportamiento.param_aditivos');
						$obj_xtpl->parse('main.contenido.grafico_comportamiento.select_aditivos');
			}
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.grafico_comportamiento');
		}
		else{
			header('location:'.$_SESSION['Ruta_Tipo']);
		}
		break;
		
	
	// Busqueda de la informacion de los reportes
	case 'ver':
		if($_GET['tipo'] && is_numeric($_GET['tipo'])){
			
			// Ruta actual
			$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
		
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso',$_SESSION['Ruta_Tipo']);
			
			// Para la paginacion
			if(empty($_GET['pg'])){
				$pag= 1;
			}
			else{
				$pag= $_GET['pg'];
			}
			
			$distribuidor=false;
			$asesor=false;
			
			// Verifica si es un Distribuidor o asesor
			if($_SESSION['InfoLogin']->GetTipo() == 'd'){
				$distribuidor= $obj_modelo->GetIdDistribuidor($_SESSION['InfoLogin']->GetCuenta());
				$obj_xtpl->assign('complemento','dst='.base64_encode($distribuidor));
			}
			elseif($_SESSION['InfoLogin']->GetTipo() == 'p'){
				$asesor= $obj_modelo->GetIdAsesor($_SESSION['InfoLogin']->GetCuenta());
				$obj_xtpl->assign('complemento','asr='.base64_encode($asesor));
			}
			
			// Para marca aleatoria
			$obj_xtpl->assign('aleatorio', base64_encode(rand(1000,2000)));
			
			// Tipos de reportes
			switch($_GET['tipo']){
				case 1:
					
					// Para tipo de reporte
					$obj_xtpl->assign('tipo_reporte', base64_encode('CME01'));
					
					// Busca el id del cliente
					if($_SESSION['InfoLogin']->GetTipo()=='c'){
						$cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
						$obj_xtpl->assign('complemento','clt='.base64_encode($cliente));
					}
					
					// Busca el listado de la informacion
					$lista= $obj_modelo->GetCantidadMuestraPorEquipo($obj_config->GetVar('num_registros'),$pag,$distribuidor,$asesor,$cliente);
					if( $lista['total_registros']>0 ){
						$i=1;
						while($row= $obj_conexion->GetArrayInfo($lista['result'])){
							if( ($i % 2) >0){
								$obj_xtpl->assign('estilo_fila', 'odd');
							}
							else{
								$obj_xtpl->assign('estilo_fila', 'even');
							}
							
							// Nombre del cliente
							$obj_xtpl->assign($obj_generico->CleanTextDb($obj_modelo->GetNombreCliente($row['id_Cliente'])));
							
							// Asignacion de datos
							$obj_xtpl->assign($obj_generico->CleanTextDb($row));
							
							// Parseo del bloque de la row_res
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.lista');
							
							$i++;
						}
						
						// Datos para la paginacion
						$paginacion= $obj_generico->paginacion($lista['pagina'], $lista['total_paginas'], $lista['total_registros'], $obj_generico->urlPaginacion());
						$obj_xtpl->assign('paginacion',$paginacion);
						
						// Parseo del link de exportar
						$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.enlace_exportar');
					}
					else{
						// Mensaje
						$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
						
						// Parseo del bloque de la row_res
						$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.no_lista');
					}
					
					// Para el historial
					$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 18, $obj_conexion, $obj_config->GetVar('esquema'));
					break;
					
					
				case 2:
					
					if($_SESSION['InfoLogin']->GetTipo()!='c'){
						// Para tipo de reporte
						$obj_xtpl->assign('tipo_reporte', base64_encode('CMC02'));
						
						// Busca el listado de la informacion
						$lista= $obj_modelo->GetCantidadMuestraPorCliente($obj_config->GetVar('num_registros'),$pag,$distribuidor,$asesor);
						if( $lista['total_registros']>0 ){
							$i=1;
							while($row= $obj_conexion->GetArrayInfo($lista['result'])){
								if( ($i % 2) >0){
									$obj_xtpl->assign('estilo_fila', 'odd');
								}
								else{
									$obj_xtpl->assign('estilo_fila', 'even');
								}
								
								// Asignacion de datos
								$obj_xtpl->assign($obj_generico->CleanTextDb($row));
								
								// Parseo del bloque de la row_res
								$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.lista');
								
								$i++;
							}
							
							// Datos para la paginacion
							$paginacion= $obj_generico->paginacion($lista['pagina'], $lista['total_paginas'], $lista['total_registros'], $obj_generico->urlPaginacion());
							$obj_xtpl->assign('paginacion',$paginacion);
							
							// Parseo del link de exportar
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.enlace_exportar');
						}
						else{
							// Mensaje
							$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
							
							// Parseo del bloque de la row_res
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.no_lista');
						}
						
						// Para el historial
						$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 19, $obj_conexion, $obj_config->GetVar('esquema'));
					}
					else{
						header('location:'.$_SESSION['Ruta_Tipo']);
					}
					break;
				
				
					
				case 3:
				
					if($_SESSION['InfoLogin']->GetTipo()!='c'){
						// Para tipo de reporte
						$obj_xtpl->assign('tipo_reporte', base64_encode('FTME03'));
						
						// Busca el listado de la informacion
						$lista= $obj_modelo->GetCantidadMuestraPorEquipo($obj_config->GetVar('num_registros'),$pag,$distribuidor,$asesor);
						if( $lista['total_registros']>0 ){
							$i=1;
							while($row= $obj_conexion->GetArrayInfo($lista['result'])){
								if( ($i % 2) >0){
									$obj_xtpl->assign('estilo_fila', 'odd');
								}
								else{
									$obj_xtpl->assign('estilo_fila', 'even');
								}
								
								// Frecuencia de tiempo
								// Obtiene las fechas
								$fechas= array();
								$result_fecha= $obj_modelo->GetFechasMuestra($row['id_Equipo']);
								while($row_fecha= $obj_conexion->GetArrayInfo($result_fecha)){
									$fechas[]= $row_fecha['Fecha'];
								}
								$cantidad= count($fechas);
								
								// Calculo del tiempo transcurrido
								$frecuencia="";
								for($j=0; $j<$cantidad; $j++){
									$frecuencia+= $obj_date->RestaFechas($fechas[$j],$fechas[$j+1]);
								}
								
								if(($cantidad-1)>0){
									$frecuencia= $frecuencia / ($cantidad-1);
								}
								
								// Asignacion de la frecuencia de tiempo
								$obj_xtpl->assign('frecuencia',floor($frecuencia));
								
								// Nombre del cliente
								$obj_xtpl->assign($obj_generico->CleanTextDb($obj_modelo->GetNombreCliente($row['id_Cliente'])));
								
								// Asignacion de datos
								$obj_xtpl->assign($obj_generico->CleanTextDb($row));
								
								// Parseo del bloque de la row_res
								$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.lista');
								
								$i++;
							}
							
							// Datos para la paginacion
							$paginacion= $obj_generico->paginacion($lista['pagina'], $lista['total_paginas'], $lista['total_registros'], $obj_generico->urlPaginacion());
							$obj_xtpl->assign('paginacion',$paginacion);
								
							// Parseo del link de exportar
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.enlace_exportar');
						}
						else{
							// Mensaje
							$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
							
							// Parseo del bloque de la row_res
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.no_lista');
						}
						
						// Para el historial
						$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 20, $obj_conexion, $obj_config->GetVar('esquema'));
					}
					else{
						header('location:'.$_SESSION['Ruta_Tipo']);
					}
					break;
					
					
				case 4:
					
					if($_SESSION['InfoLogin']->GetTipo()!='c'){
						// Para la validacion con el javascript
						$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
						
						$x=false;
						
						// Listado de clientes
						$result= $obj_modelo->GetClientes($distribuidor,$asesor);
						while($row= $obj_conexion->GetArrayInfo($result)){
							if($_GET['cliente']==$row['id_Cliente']){
								$obj_xtpl->assign('seleccion','selected="selected"');
							}
							else{
								$obj_xtpl->assign('seleccion','');
							}
							
							// Asignacion de datos
							$obj_xtpl->assign($obj_generico->CleanTextDb($row));
							
							// Parseo del bloque de la row_res
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.lista_clientes');
							
							$x=true;
						}
						
						if($x && !empty($_GET['cliente']) && is_numeric($_GET['cliente'])){
						
							// Para tipo de reporte
							$obj_xtpl->assign('tipo_reporte', base64_encode('SRC04'));
							
							// Busca el listado de la informacion
							$lista= $obj_modelo->GetSolicitudesCliente($obj_config->GetVar('num_registros'),$pag,$_GET['cliente']);
							if( $lista['total_registros']>0 ){
								$i=1;
								while($row= $obj_conexion->GetArrayInfo($lista['result'])){
									if( ($i % 2) >0){
										$obj_xtpl->assign('estilo_fila', 'odd');
									}
									else{
										$obj_xtpl->assign('estilo_fila', 'even');
									}
									
									// Asignacion de datos
									$obj_xtpl->assign($obj_generico->CleanTextDb($row));
									$obj_xtpl->assign('Fecha',$obj_date->changeFormatDate($row['Fecha'],1));
									switch($row['Motivo_Analisis']){
										case 1:
											$obj_xtpl->assign('Motivo_Analisis','Monitoreo');
											break;
											
										default:
											$obj_xtpl->assign('Motivo_Analisis','Sin Especificar');
											break;
									}
									
									// Parseo del bloque de la row_res
									$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte.lista');
									
									$i++;
								}
								
								// Datos para la paginacion
								$paginacion= $obj_generico->paginacion($lista['pagina'], $lista['total_paginas'], $lista['total_registros'], $obj_generico->urlPaginacion());
								$obj_xtpl->assign('paginacion',$paginacion);
								
								// Para el ID del cliente
								$obj_xtpl->assign('cliente', base64_encode($_GET['cliente']));
								
								// Parseo del link de exportar
								$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte.enlace_exportar');
							}
							else{
								// Mensaje
								$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
								
								// Parseo del bloque de la row_res
								$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte.no_lista');
							}
							
							// Parseo del reporte
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte');
						}
						
						// Para el historial
						$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 21, $obj_conexion, $obj_config->GetVar('esquema'));
					}
					else{
						header('location:'.$_SESSION['Ruta_Tipo']);
					}
					break;
					
					
				case 5:
					
					// Ruta actual
					$_SESSION['Ruta_Comportamiento']= $obj_generico->RutaRegreso();
					
					// Para la validacion con el javascript
					//$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
					
					$x=false;
					
					// Listado de clientes
					$result= $obj_modelo->GetClientes($distribuidor,$asesor);
					while($row= $obj_conexion->GetArrayInfo($result)){
						if($_GET['cliente']==$row['id_Cliente']){
							$obj_xtpl->assign('seleccion','selected="selected"');
						}
						else{
							$obj_xtpl->assign('seleccion','');
						}
						
						// Asignacion de datos
						$obj_xtpl->assign($obj_generico->CleanTextDb($row));
						
						// Parseo del bloque de la row_res
						$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.seleccion_cliente.lista_clientes');
						
						$x=true;
					}
					
					// Busca el id del cliente
					if($_SESSION['InfoLogin']->GetTipo()=='c'){
						$_GET['cliente']= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
					}
					//if($x && !empty($_GET['cliente']) && is_numeric($_GET['cliente'])){
					
						// Busca el listado de la informacion
						$lista= $obj_modelo->GetEquipoConParametros($obj_config->GetVar('num_registros'),$pag,$_GET['cliente'],$distribuidor,$asesor);
						if( $lista['total_registros']>0 ){
							$i=1;
							while($row= $obj_conexion->GetArrayInfo($lista['result'])){
								if( ($i % 2) >0){
									$obj_xtpl->assign('estilo_fila', 'odd');
								}
								else{
									$obj_xtpl->assign('estilo_fila', 'even');
								}
								
								// Nombre del cliente
								$obj_xtpl->assign($obj_generico->CleanTextDb($obj_modelo->GetNombreCliente($row['id_Cliente'])));
								
								// Asignacion de datos
								$obj_xtpl->assign($obj_generico->CleanTextDb($row));
								
								// Parseo del bloque de la row_res
								$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte.lista');
								
								$i++;
							}
							
							// Datos para la paginacion
							$paginacion= $obj_generico->paginacion($lista['pagina'], $lista['total_paginas'], $lista['total_registros'], $obj_generico->urlPaginacion());
							$obj_xtpl->assign('paginacion',$paginacion);
						}
						else{
							// Mensaje
							$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
							
							// Parseo del bloque de la fila
							$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte.no_lista');
						}
						
						// Parseo del reporte
						$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.tabla_reporte');
					//}
					
					
					// Muestra todos los clientes
					if($_SESSION['InfoLogin']->GetTipo()=='p'){
						$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo'].'.seleccion_cliente');
					}
		
					// Para el historial
					$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 22, $obj_conexion, $obj_config->GetVar('esquema'));
					break;
						
						
						
				default:
					// Redirecciona al listado de reportes
					header('location:'.$_SESSION['Ruta_Tipo']);
					break;
			}
			
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.reporte_'.$_GET['tipo']);
		}
		else{
			// Redirecciona al listado de reportes
			header('location:'.$_SESSION['Ruta_Tipo']);
		}
		break;
	
	
	
	// Muestra el listado de los tipos de reportes
	default:
		// Ruta actual
		$_SESSION['Ruta_Comportamiento']= $obj_generico->RutaRegreso();
		
		// Para la validacion con el javascript
		$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
		
		// Muestra todos los reportes si el usuario es de personal
		if($_SESSION['InfoLogin']->GetTipo()=='p'){
			$obj_xtpl->parse('main.contenido.seleccion.lista_seleccion');
		}
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.seleccion');
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 17, $obj_conexion, $obj_config->GetVar('esquema'));
		break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>