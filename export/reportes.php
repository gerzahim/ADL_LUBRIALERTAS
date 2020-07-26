<?php

$marcador= base64_decode($_GET['marca']);

if( is_numeric($marcador) && strlen($marcador)==4 && ($marcador>=1000 || $marcador<=2000) ){

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
	
	// Libreria para generar pdf
	include ('.'.$obj_config->GetVar('ruta_libreria').'class.ezpdf.php');
	
	// Hoja tipo carta
	$pdf=& new Cezpdf('LETTER');
	
	// Fuente
	$pdf->selectFont('../fonts/Helvetica.afm');
	
	// Margenes
	$pdf->ezSetMargins(50,50,50,50);
	
	// Header
	$pdf->ezImage('../images/header_oficial2.jpg',5,500);
	$pdf->ezImage('../images/banner_pdf.jpg',5,500);
	$pdf->ezText(html_entity_decode('Sistema '.$obj_config->GetVar('titulo_sistema')),18,array('justification'=>'center'));
	$pdf->ezText('');
	
	switch(base64_decode($_GET['reporte'])){
		case 'CME01':
		
			if( is_numeric(base64_decode($_GET['dst'])) ){
				$distribuidor= base64_decode($_GET['dst']);
			}
			else{
				$distribuidor= false;
			}
			
			if( is_numeric(base64_decode($_GET['asr'])) ){
				$asesor= base64_decode($_GET['asr']);
			}
			else{
				$asesor= false;
			}
			
			if( is_numeric(base64_decode($_GET['clt'])) ){
				$cliente= base64_decode($_GET['clt']);
			}
			else{
				$cliente= false;
			}
			
			
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetCantidadMuestraPorEquipo(false,false,$distribuidor,$asesor,$cliente,true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Nombre del cliente
				$cliente= $obj_modelo->GetNombreCliente($row['id_Cliente']);
				$cliente= html_entity_decode($cliente["Nombre_Cliente"]);
				
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				$data[]= array(
					"Codigo Equipo"=>$datos['Codigo_Equipo'],
					"Nombre Equipo"=>$datos['Nombre_Equipo'],
					"Tipo"=>$datos['Tipo'],
					"Marca"=>$datos['Marca'],
					"Cliente"=>$cliente,
					"Cantidad Muestras"=>$datos['cantidad']
				);
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Reporte Cantidad de Muestras por Equipo', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("Cantidad Muestras"=>array('justification'=>'center', 'width'=>80))
				) 
			);
			$archivo= true;
			break;
			
			
		
		case 'CMC02':
			if( is_numeric(base64_decode($_GET['dst'])) ){
				$distribuidor= base64_decode($_GET['dst']);
			}
			else{
				$distribuidor= false;
			}
			
			if( is_numeric(base64_decode($_GET['asr'])) ){
				$asesor= base64_decode($_GET['asr']);
			}
			else{
				$asesor= false;
			}
			
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetCantidadMuestraPorCliente(false,false,$distribuidor,$asesor,true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				$data[]= array(
					"Cliente"=>$datos['Nombre_Cliente'], 
					"Rif"=>$datos['Rif'], 
					"Email"=>$datos['Email'], 
					"Cantidad Muestras"=>$datos['cantidad'] 
				);
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Reporte Cantidad de Muestras por Cliente', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("Cantidad Muestras"=>array('justification'=>'center', 'width'=>80))
				) 
			);
			$archivo= true;
			break;
			
			
		
		case 'FTME03':
			if( is_numeric(base64_decode($_GET['dst'])) ){
				$distribuidor= base64_decode($_GET['dst']);
			}
			else{
				$distribuidor= false;
			}
			
			if( is_numeric(base64_decode($_GET['asr'])) ){
				$asesor= base64_decode($_GET['asr']);
			}
			else{
				$asesor= false;
			}
			
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetCantidadMuestraPorEquipo(false,false,$distribuidor,$asesor,false,true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				
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
				
				// Nombre del cliente
				$cliente= $obj_modelo->GetNombreCliente($row['id_Cliente']);
				$cliente= html_entity_decode($cliente["Nombre_Cliente"]);
				
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				$data[]= array(
					"Codigo Equipo"=>$datos['Codigo_Equipo'],
					"Nombre Equipo"=>$datos['Nombre_Equipo'],
					"Tipo"=>$datos['Tipo'],
					"Marca"=>$datos['Marca'],
					"Cliente"=>$cliente,
					"Cantidad Muestras"=>$datos['cantidad'],
					"Frecuencia (DIAS)"=>floor($frecuencia)
				);
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Reporte Frecuencia de Tiempo de Muestras por Equipo', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array(
						"Cantidad Muestras"=>array('justification'=>'center', 'width'=>80),
						"Frecuencia (DIAS)"=>array('justification'=>'center', 'width'=>80)
					)
				) 
			);
			$archivo= true;
			break;
			
			
		
		case 'SRC04':
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetSolicitudesCliente(false,false,base64_decode($_GET['cl']),true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				
				switch($row['Motivo_Analisis']){
					case 1:
						$motivo_analisis= 'Monitoreo';
						break;
						
					default:
						$motivo_analisis= 'Sin Especificar';
						break;
				}
				
				$data[]= array(
					"Codigo"=>$datos['Cod_Solicitud'], 
					"Fecha"=>$obj_date->changeFormatDate($datos['Fecha'],1), 
					"Motivo Analisis"=>$motivo_analisis, 
					"Cantidad Muestras"=>$datos['Cantidad_Muestras'] 
				);
			}
			
			// Nombre del cliente
			$cliente= $obj_modelo->GetNombreCliente(base64_decode($_GET['cl']));
			$cliente= html_entity_decode($cliente["Nombre_Cliente"]);
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Reporte Solicitudes Realizadas por el Cliente '.$cliente, 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array(
						"Codigo"=>array('justification'=>'center'),
						"Fecha"=>array('justification'=>'center'),
						"Motivo Analisis"=>array('justification'=>'center'),
						"Cantidad Muestras"=>array('justification'=>'center', 'width'=>80)
					)
				) 
			);
			$archivo= true;
			break;
			
			
			
		default:
			$archivo= false;
			break;
	}
	
	if($archivo){
		// Creacion del pdf, Nombre del documento
		$pdf->ezStream(array('Content-Disposition'=>'Reporte_'.date('d_m_Y').'.pdf'));
	}
	else{
		header('location:../index.php');
		exit;
	}
}
else{
	header('location:../index.php');
	exit;
}
?>