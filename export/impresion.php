<?php
$solicitud= base64_decode($_GET['sol']);
$marcador= base64_decode($_GET['marca']);

if( is_numeric($solicitud) && is_numeric($marcador) && strlen($marcador)==4 && ($marcador>=3000 || $marcador<=4000) ){

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
	
	// Libreria para crear las imagenes
	define (__TRACE_ENABLED__, false);
	define (__DEBUG_ENABLED__, false);
	require('.'.$obj_config->GetVar('ruta_libreria')."code_barras/barcode.php");
	require('.'.$obj_config->GetVar('ruta_libreria')."code_barras/c128bobject.php");

	// Modelo asignado
	require('.'.$obj_config->GetVar('ruta_modelo').'ListaSolicitud.php');
	$obj_modelo= new ListaSolicitud($obj_conexion,$obj_config->GetVar('esquema'));
	
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
	$pdf->ezText(html_entity_decode('Sistema '.$obj_config->GetVar('titulo_sistema')),18,array('justification'=>'center'));
	$pdf->ezText('');
	
	// Busqueda de la informacion a mostrar
	$data= array();
	$result= $obj_modelo->GetMuestras($solicitud);
	while($row= $obj_conexion->GetArrayInfo($result)){
		
		//Funcion para obtener los datos de los equipos
		$equipo= $obj_modelo->GetNombreEquipo( $row['id_Equipo']);
		$equipo= array_map('html_entity_decode',$equipo);
		$equipo= array_map('utf8_decode',$equipo);
		$equipo= $obj_generico->CleanTextDb($equipo);
		
		// Informacion de la tabla
		$datos= array_map('html_entity_decode',$row);
		$datos= $obj_generico->CleanTextDb($datos);
		$data[]= array(
			"Muestra"=>$datos['Cod_Muestra'],
			"Codigo Equipo"=>$equipo['Codigo_Equipo'],
			"Nombre Equipo"=>$equipo['Nombre_Equipo'],
			"Tipo"=>$equipo['Tipo'],
			"Marca"=>$equipo['Marca'],
			"Modelo"=>$equipo['Modelo'],
			"Horas"=>$datos['Horas'],
			"Km"=>$datos['km'],
		);
		
		// Datos para la imagen
		$arregloCod[]= array(
			"codigo"=>$datos['Cod_Muestra'],
			"equipo"=>'Equipo: '.$equipo['Codigo_Equipo'].' * '.$equipo['Nombre_Equipo']
		);
	}
	
	// Creacion de la tabla
	$cod_solicitud=$obj_modelo->GetCodSolicitud($solicitud);   
	$pdf->ezTable(
		$data, '', 'Solicitud de Analisis de Muestras N°: '.$cod_solicitud, 
		array(
			'width'=>500, 'shaded'=>2, 
			'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
			'cols'=> array("Muestra"=>array('justification'=>'center', 'width'=>70))
		) 
	);
	
	// Crea las imagenes
	if(count($arregloCod)>0){
		
		// Parametros de configuracion
		$style= 164;
		$width= 260;
		$height= 70;
		$xres= 1;
		$font= 3;
		$directorio= "../codigos/";
		
		$pdf->ezNewPage();
		$pdf->ezSetMargins(65,60,50,50);
		$pdf->ezColumnsStart(array('num'=>2));
		$pdf->ezText('');

		// Recorre el arreglo y crea las imagenes
		$j=1;
		foreach	($arregloCod as $i ){
			
			$pdf->ezText(html_entity_decode($i['equipo']),10,array('justification'=>'center'));
			$pdf->ezText('',8);
			$pdf->ezText('',10);
			
			// Creacion de la barra segun el codigo
			$code= $i['codigo'];
			$obj= new C128BObject($width, $height, $style, $code);
			if($obj){
				$obj->SetFont($font);
				$obj->DrawObject($xres);
				$img_name= $directorio.$code.'.jpg';
				$obj->RenderFlushObject($img_name);
				chmod($img_name, 0755);
				unset($obj);  /* clean */
			}
			
			$pdf->ezImage($img_name,2,260,'none','center');
			@unlink($img_name);
			$pdf->ezText('',32);
			
			if($j==5){
				$pdf->ezText('',10);
				$j=1;
			}
			else{
				$j++;
			}
		}
		
		$pdf->ezColumnsStop();
	}
	
	// Creacion del pdf, Nombre del documento
	if (isset($d) && $d){
		$pdfcode = $pdf->output(1);
		$pdfcode = str_replace("\n","\n<br>",htmlspecialchars($pdfcode));
		echo '<html><body>';
		echo trim($pdfcode);
		echo '</body></html>';
	}
	else{
		$pdf->ezStream(array('Content-Disposition'=>'Solicitud_'.date('dmY').'.pdf'));
	}
}
else{
	header('location:../index.php');
	exit;
}
?>