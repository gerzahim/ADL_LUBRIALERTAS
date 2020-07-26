<?php

$marcador= base64_decode($_GET['marca']);

if( is_numeric($marcador) && strlen($marcador)==4 && ($marcador>=1000 || $marcador<=2000) ){

	include('../libraries/InfoLogin.php');

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
	
	// Clases a utilizar
	$obj_generico= new Generica();
	$obj_date= new Fecha();
	$obj_conexion= new Bd();
	$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db'));
	
	// Modelo asignado
	require('.'.$obj_config->GetVar('ruta_modelo').'Reporte.php');
	$obj_modelo= new Reporte($obj_conexion,$obj_config->GetVar('esquema'));
	
	
	switch(base64_decode($_GET['reporte'])){
	
		case 'CET05':
			
			$equipo= base64_decode($_GET['e']);
			$componente= $obj_generico->CleanText($_GET['param']);
		
			if( !empty($equipo) && is_numeric($equipo) ){
			
				// Vista asignada
				$obj_xtpl = new XTemplate('.'.$obj_config->GetVar('ruta_vista').'graph_page'.$obj_config->GetVar('ext_vista'));
				$obj_xtpl->assign('fecha_hoy',$obj_date->FechaActual());
				
				// Datos del eqquipo para el titulo
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
						$obj_xtpl->assign('estilo_row_res', 'odd');
					}
					else{
						$obj_xtpl->assign('estilo_row_res', 'even');
					}
					$i++;
					
					// Asignacion para la tabla
					$obj_xtpl->assign('fecha',$obj_date->changeFormatDate($row['Fecha'],1));
					$obj_xtpl->assign($row);
						
						// Parseo de la lista
						$obj_xtpl->parse('main.grafico_comportamiento.lista');
						$obj_xtpl->parse('main.grafico_comportamiento.param_aditivos.listab');
						$obj_xtpl->parse('main.grafico_comportamiento.listaa');
					}
					
					
					($componente) ? $tipo_graph='code=1&amp;param='.$componente :  $tipo_graph="code=2";
				
					if($componente){
						// Imagen grafico
						$obj_xtpl->assign('imagen','./Grafico.php?'.$tipo_graph.$data_link);
						
						$obj_xtpl->parse('main.grafico_comportamiento.imagen_grafico');
					}
					
				}
				//parseo del select de los aditivos y  
				if ($_SESSION['InfoLogin']->GetTipo() == 'd' || $_SESSION['InfoLogin']->GetTipo() == 'p'){
							$obj_xtpl->parse('main.grafico_comportamiento.param_aditivos');
					}
				
				// Parseo del bloque
				$obj_xtpl->parse('main.grafico_comportamiento');
				
				// Parseo de la pagina
				$obj_xtpl->parse('main');
				$obj_xtpl->out('main');
			}
			else{
				echo("<br/><center>SIN INFORMACION</center>");
			}
			break;
			
			
		default:
			echo("<br/><center>SIN INFORMACION</center>");
			break;
	}
}
else{
	echo("<br/><center>SIN INFORMACION</center>");
}

?>