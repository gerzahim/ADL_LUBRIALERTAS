<?php

	$id_Solicitud= $_GET['id_Solicitud'];
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
	$pdf=& new Cezpdf('POWER');
	$pdf->ezStartPageNumbers(700,80,12,'','',1);
		// Fuente
	$pdf->selectFont('../fonts/Helvetica.afm');
		
	
	// Margenes
	$pdf->ezSetMargins(60,80,50,50);
	
	// Header
	//$pdf->ezImage('../images/header_oficial2.jpg',5,500);
	$pdf->ezImage('../images/banner_pdf_new.jpg',4,550);
	$pdf->ezText(html_entity_decode('Sistema '.$obj_config->GetVar('titulo_sistema')),10,array('justification'=>'center'));
	
	// Modelo asignado
	require('.'.$obj_config->GetVar('ruta_modelo').'ResultadoSolicitud.php');
	$obj_modelo= new ResultadoSolicitud($obj_conexion,$obj_config->GetVar('esquema'));

  //Numero de Solicitud
  $cod_solicitud= $obj_modelo->GetCodSolicitud($id_Solicitud); 
	$pdf->ezText('Num. Solicitud : '.$cod_solicitud,10,array('justification'=>'center'));
	$pdf->ezText('');	
	// Obtiene el Id del cliente de la tabla solicitud	
	$id_cliente= $obj_modelo->GetIdClienteFromTablaSolicitud($id_Solicitud);

	// Obtiene el datos del cliente segun el id dado 
	$datos_cliente= $obj_modelo->GetDatosCliente($id_cliente);
	//$pdf->ezText('Cliente - Direccion - Email',12,array('justification'=>'left'));
	//$pdf->ezText(html_entity_decode($id_cliente),10,array('justification'=>'left'));
	$cliente= html_entity_decode($datos_cliente['Nombre_Cliente']);
	$direccion_cliente= html_entity_decode($datos_cliente['Direccion_Cliente']);
	$email_cliente= html_entity_decode($datos_cliente['Email']);
	$date=date('d-m-Y');
	$fecha="  -    FECHA: ";
	$cl="CLIENTE: ";
	$dr="  -   DIRECCION: ";
	$em="  -   EMAIL: ";
	$cliente_date=$cl.$cliente.$fecha.$date.$dr.$direccion_cliente.$em.$email_cliente;
	$pdf->ezText($cliente_date,10,array('justification'=>'left'));
	$pdf->ezText('');
	
	//Obtiene el array de las muestras bajo el parametro de solicitud
	$muestras= $obj_modelo->GetMuestras($id_Solicitud);	
	
	$pdf->ezText(html_entity_decode('Descripci&oacute;n de Muestras'),10,array('justification'=>'left'));

	while($row= $obj_conexion->GetArrayInfo($muestras)){
		$datos= array_map('html_entity_decode',$row);
	
		$equipo= $obj_modelo->GetNombreEquipo($datos['id_Equipo']);
		$esp=" ";
		$descripcion= $datos['Cod_Muestra'].$esp.$equipo['Nombre_Equipo'].$esp.$equipo['Codigo_Equipo'];

		$pdf->ezText($descripcion,10,array('justification'=>'left'));
	
	}
	$membretetext="El An&aacute;lisis de las muestras fue realizado por INTEVEP, Certificado N&deg; : ";
	$codigo_sigelab= $obj_modelo->GetCodigoSigelabFromTablaSolicitud($id_Solicitud);
	$membrete=$membretetext.$codigo_sigelab;
	
///////////////////////////////////////////////////////////////////////////////////////
	
	$pdf->ezText('');
	

	$muestra_met= $obj_modelo->GetMuestras($id_Solicitud);
	$j=1;
	while($row= $obj_conexion->GetArrayInfo($muestra_met)){
		$dates= array_map('html_entity_decode',$row);
		$id_Muestra= $dates['id_Muestra'];
		$Cod_Muestra=$dates['Cod_Muestra'];
		if($obj_generico->IsEmpty($nombre_asesor)){
			$id_CuentaAcceso= $obj_modelo->GetIdCuentaAccesoFromMuestra($id_Muestra);
			$nombre_asesor= $obj_modelo->GetNombreCuentaAcceso($id_CuentaAcceso);
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
		        		   $result_crepita= str_replace("&lt;br /&gt;", "", $result_crepita);
		        			break;
		        		case (1068):
		        		   $result_ho= $fila[resultado];
		        		   $result_ho= str_replace("&lt;br /&gt;", "", $result_ho);
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
	
			//para correrlo a una nueva pagina 4, 12, 19, 26, 33, 40, 47 
/*			if($j==4||$j==12||$j==19||$j==26||$j==33||$j==40||$j==47){
				$pdf->ezText('');
				$asesor_recomendador="Asesor t&eacute;cnico  que realiz&oacute; las recomendaciones : ";
				$pdf->ezText(html_entity_decode($asesor_recomendador.$nombre_asesor),10,array('justification'=>'left'));
				$pdf->ezText(html_entity_decode($membrete),10,array('justification'=>'left'));
				$pdf->ezNewPage();
				$pdf->ezText('');
				
	    	}*/
	
	    		$call=$pata.$i;
				if ($tipo!='c'){
		    		$call[]= array(
		    	"Metodo,Norma"=>"Result.,Unid.",	
					"Aluminio, ASTM D 6595"=>$result_al,
					"Cromo, ASTM D 6595"=>$result_cr,
					"Cobre, ASTM D 6595"=>$result_cu,
					"Hierro, ASTM D 6595"=>$result_fe,
					"Plomo, ASTM D 6595"=>$result_pb,
					html_entity_decode("Esta&ntilde;o, ASTM D 6595")=>$result_sn,
					"Silicio, ASTM D 6595"=>$result_si,
					"Boro, ASTM D 6595"=>$result_b,
					"Magnesio, ASTM D 6595"=>$result_mg,
					"Calcio, ASTM D 6595"=>$result_ca,
					"Zinc, ASTM D 6595"=>$result_zn,
					"Fosforo, ASTM D 6595"=>$result_p,
					"Molibdeno, ASTM D 6595"=>$result_mo,
					"Crepitacion, LAB Adim."=>$result_crepita,
					utf8_decode("Visc.40 ºC, ASTM D-445-06")=>$result_viscuarenta,
					utf8_decode("Visc.100 ºC, ASTM D-445-06")=>$result_viscien,
					"Hollin"=>$result_ho,
					"Agua Karl Fisher, ASTM D 4928"=>$result_water,
					"Num. Basico, ASTM D-2896-06"=>$result_nb,
					"Acidez, ASTM D-974"=>$result_ac,
					);
				}else{
		    		$call[]= array(
		    		"Metodo,Norma"=>"Result.,Unid.",	
						"Aluminio, ASTM D 6595"=>$result_al,
						"Cromo, ASTM D 6595"=>$result_cr,
						"Cobre, ASTM D 6595"=>$result_cu,
						"Hierro, ASTM D 6595"=>$result_fe,
						"Plomo, ASTM D 6595"=>$result_pb,
						html_entity_decode("Esta&ntilde;o, ASTM D 6595")=>$result_sn,
						"Silicio, ASTM D 6595"=>$result_si,
						"Boro, ASTM D 6595"=>$result_b,
						"Crepitacion, LAB Adim."=>$result_crepita,
						utf8_decode("Visc.40 ºC, ASTM D-445-06")=>$result_viscuarenta,
						utf8_decode("Visc.100 ºC, ASTM D-445-06")=>$result_viscien,
						"Hollin"=>$result_ho,
						"Agua Karl Fisher, ASTM D 4928"=>$result_water,
						"Num. Basico, ASTM D-2896-06"=>$result_nb,
						"Acidez, ASTM D-974"=>$result_ac,
						);				
				}

			$pdf->ezText('');
			$pdf->ezTable(
				$call, '', 'Resultados de la muestra '.$Cod_Muestra, 
				array(
					'width'=>750, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85),
					'fontSize' => 7,
					'titleFontSize' => 10,
					'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>6))
				) 
			);
		

	$j++;
	}
	$pdf->ezText('');
	$asesor_recomendador="Asesor t&eacute;cnico  que realiz&oacute; las recomendaciones : ";
	$pdf->ezText(html_entity_decode($asesor_recomendador.$nombre_asesor.". Gerencia de Tecnolog&iacute;a de Productos. Deltaven"),10,array('justification'=>'left'));
	$pdf->ezText(html_entity_decode($membrete),10,array('justification'=>'left'));

	
///////////////////////////////////////////////////////////////////////////////////////	
	//$pdf->ezNewPage();
  $pdf->ezText('');	
	$muestra_obs= $obj_modelo->GetMuestras($id_Solicitud);
	$pdf->ezText('');
	$pdf->ezText('Observaciones',10,array('justification'=>'left'));
	$pdf->ezText('');
	while($row= $obj_conexion->GetArrayInfo($muestra_obs)){
		$datas= array_map('html_entity_decode',$row);
	
		$id_Muestra= $datas['id_Muestra'];

		//Para Obtener las Recomendaciones
		$result= $obj_modelo->GetMuestrasaRecomendar($id_Muestra);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Informacion de la tabla
				$patos= array_map('html_entity_decode',$row);
				$patos= $obj_generico->CleanTextDb($patos);
	
				$esp=" ";
				$observacion= $patos['Cod_Muestra'].$esp.$patos['Recomendacion'];

				$pdf->ezText($observacion,10,array('justification'=>'left'));
			}
	}
	

/////////////////////////////////////////////////////////////////////////////////////////////							
	$archivo= true;				
	
	
	//Para generar el pdf
	if($archivo){
		// Creacion del pdf, Nombre del documento
		$pdf->ezStream(array('Content-Disposition'=>'Certificado_'.date('d_m_Y').'.pdf'));
	}	

?>