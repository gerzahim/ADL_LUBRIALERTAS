<?php

$id_Muestra= base64_decode($_GET['id_Muestra']);
$tipo= $_GET['tipo'];

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
	$obj_conexion= new Bd();
	$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db'));
	
	// Libreria para generar pdf
	include ('.'.$obj_config->GetVar('ruta_libreria').'class.ezpdf.php');
	
	// Hoja tipo carta
	$pdf=& new Cezpdf('LETTER');
	
	// Fuente
	$pdf->selectFont('../fonts/Helvetica.afm');
	
	// Margenes
	$pdf->ezSetMargins(60,80,50,50);
	
	// Header
	$pdf->ezImage('../images/header_oficial2.jpg',5,500);
	$pdf->ezImage('../images/banner_pdf_new.jpg',5,500);
	$pdf->ezText(html_entity_decode('Sistema '.$obj_config->GetVar('titulo_sistema')),16,array('justification'=>'center'));
	$pdf->ezText('');      
	// Modelo asignado
	require('.'.$obj_config->GetVar('ruta_modelo').'ResultadoSolicitud.php');
	$obj_modelo= new ResultadoSolicitud($obj_conexion,$obj_config->GetVar('esquema'));


	$id_Muestra=base64_decode($_GET['id_Muestra']);
				

	
		// Busqueda de la informacion a mostrar
		$data= array();
		$result= $obj_modelo->GetMuestrasaRecomendar($id_Muestra);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				$data[]= array(
					"Cod_Muestra"=>$datos['Cod_Muestra'],
					"Lubricante y Tipo"=>$datos['Producto_Grado'],
					"Horas"=>$datos['Horas'],
					"km"=>$datos['km'],
					"Recomendacion"=>$datos['Recomendacion']
				);
				
				$equipo= $obj_modelo->GetNombreEquipoRecomendacion( $datos['id_Equipo']);
				$date[]= array(
				"Codigo Equipo"=>$equipo[Codigo_Equipo],
				"Nombre Equipo"=>$equipo[Nombre_Equipo],
				"Marca"=>$equipo[Marca],
				"Modelo"=>$equipo[Modelo],
				"Capacidad del Sistema"=>$equipo[Capacidad_Sistema],
				);
				/*,Nombre_EquipoTipoMarcaModeloCapacidad_SistemaProducto_Grado*/						
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Datos de la muestra', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
				) 
			);
			
			$pdf->ezText('');
			
				$pdf->ezTable(
				$date, '', 'Datos del Equipo', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
				) 
			);
			
			
	      // Para obtener los parametros de resultados
	
			//Funcion para obtener el codigo de la muestra 			
			$codigom =$obj_modelo->GetCodMuestra($id_Muestra);
			//echo $codigom;
			// Funcion para obtener el numero de certificado segun el codigo de la muestra 			
			$idcertificado =$obj_modelo->ObtenerCertificado($codigom);
			//echo $idcertificado; 
			
			
			// Funcion para obtener el numero del metodo segun el numero de certificado
			$metodo =$obj_modelo->ObtenerMetodo_Certificado($idcertificado);
			while($rew= $obj_conexion->GetArrayInfo($metodo)){
									
					// Funcion para obtener los resultados de cada elemento del certificado 
					$parametros =$obj_modelo->ObtenerResultados($rew['id_metodo']);					
					
					
					// Busqueda de la informacion a mostrar
		
					while($fila= $obj_conexion->GetArrayInfo($parametros)){
					
						$prueba = $fila['idprueba'];
						
		        	   switch ($prueba) {
		    				
		    				case (1039):
								$result_al= $fila[resultado];
		        				break;
		        			case (1089):
								$result_cr= $fila[resultado];				
		        				break;
		        			case (1044):
								$result_cu= $fila[resultado];
		        				break;    				
			    			case (1045):
			        			$result_fe= $fila[resultado];
			        			break;
			        		case (1046):
			        		   $result_pb= $fila[resultado];
			        			break;
			        		case (1056):
			        		   $result_sn= $fila[resultado];
			        			break;
			        		case (1042):
			        		   $result_ca= $fila[resultado];
			        			break;
			        		case (1047):
			        		   $result_mg= $fila[resultado];
			        			break;
			        		case (1053):
			        		   $result_si= $fila[resultado];
			        			break;
			        		case (1041):
			        		   $result_b= $fila[resultado];
			        			break;
			        		case (1055):
			        		   $result_na= $fila[resultado];
			        			break;
			        		case (1051):
			        		   $result_p= $fila[resultado];
			        			break;
			        		case (1088):
			        		   $result_zn= $fila[resultado];
			        			break;
							case (959):
								$result_viscien= $fila[resultado];
								$incert_viscien= $fila[incertidumbre];
								$result_viscien = str_replace("mm&amp;sup2;/s", "+/- ".$incert_viscien." cSt.", $result_viscien);
								break;
							case (958):
								$result_viscuarenta= $fila[resultado];
								$incert_viscuarenta= $fila[incertidumbre];
								$result_viscuarenta = str_replace("mm&amp;sup2;/s", "+/- ".$incert_viscuarenta." cSt.", $result_viscuarenta);
								break;
			        		case (1034):
			        		   $result_water= $fila[resultado];
			        			break;
			        		case (1049):
			        		   $result_mo= $fila[resultado];
			        			break;
			        		case (1037):
			        		   $result_crepita= $fila[resultado];
			        			break;
			        		case (1068):
			        		   $result_ho= $fila[resultado];
			        			break;
			        		case (999):
			        		   $result_nb= $fila[resultado];
			        		   $result_nb= str_replace("&lt;br /&gt;", "", $result_nb);
			        			break;
			        		case (1059):
			        		   $result_ac= $fila[resultado];
			        		   $result_ac= str_replace("&lt;br /&gt;", "", $result_ac);
			        			break;		        			
		        			default:
		        				break;
		        	   }	   
		        	
		    		}
			}
				
					$pdf->ezText('');
					
					$contenido[]= array(
						"Aluminio"=>$result_al,
						"Cromo"=>$result_cr,
						"Cobre"=>$result_cu,
						"Hierro"=>$result_fe,
						"Plomo"=>$result_pb,
						utf8_decode("Estaño")=>$result_sn,
						);
						
					$contaminantes[]= array(
						"Silicio"=>$result_si,
						"Boro"=>$result_b,
						"Sodio"=>$result_na,
						);
						
					$aditivos[]= array(
						"Magnesio"=>$result_mg,
						"Calcio"=>$result_ca,
						"Zinc"=>$result_zn,
						"Fosforo"=>$result_p,
						"Molibdeno"=>$result_mo,
						);

					$propiedades[]= array(
						"Crepitacion"=>$result_crepita,
						utf8_decode("Visc.100 ºC")=>$result_viscien,
						utf8_decode("Visc.40 ºC")=>$result_viscuarenta,
						"Agua Karl Fisher"=>$result_water,
						"Hollin"=>$result_ho,
						"Acidez"=>$result_ac,
						"Num. Bas."=>$result_nb,
						);	

											
					$pdf->ezText('Resultados de la muestra',11,array('justification'=>'center'));
					$pdf->ezText('');
							
					$pdf->ezText('');		
					$pdf->ezTable(
						$contenido, '', 'Contenido de Metales ', 
						array(
							'width'=>500, 'shaded'=>2, 
							'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
							'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
						) 
					);
					
					$pdf->ezText('');
					$pdf->ezTable(
						$contaminantes, '', 'Contaminantes', 
						array(
							'width'=>500, 'shaded'=>2, 
							'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
							'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
						) 
					);
					if ($tipo!='c'){
						$pdf->ezText('');
						$pdf->ezTable(
							$aditivos, '', 'Aditivos ', 
							array(
								'width'=>500, 'shaded'=>2, 
								'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
								'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
							) 
						);
					}
					$pdf->ezText('');
					$pdf->ezTable(
						$propiedades, '', 'Propiedades Fisicas', 
						array(
							'width'=>500, 'shaded'=>2, 
							'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
							'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
						) 
					);					
							
					

	
	//Para generar el pdf
	$archivo= true;
	
	if($archivo){
		// Creacion del pdf, Nombre del documento
		$pdf->ezStream(array('Content-Disposition'=>'Listado_'.date('d_m_Y').'.pdf'));
	}	

?>