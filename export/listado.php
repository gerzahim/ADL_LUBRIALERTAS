<?php

$marcador= base64_decode($_GET['marcador']);

if( is_numeric($marcador) && strlen($marcador)==4 && ($marcador>=6000 || $marcador<=8000) ){

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
	$pdf->ezText(html_entity_decode('Sistema '.$obj_config->GetVar('titulo_sistema')),18,array('justification'=>'center'));
	$pdf->ezText('');
	
	switch($_GET['m']){
	
		case 'cl':
		
			// Modelo asignado
			require('.'.$obj_config->GetVar('ruta_modelo').'Cliente.php');
			$obj_modelo= new Cliente($obj_conexion,$obj_config->GetVar('esquema'));
			
			$distribuidor=false;
			$asesor=false;
			
			// Verifica si es un Distribuidor	
			if( base64_decode($_GET['tu']) == 'd'){
				$distribuidor= $obj_modelo->GetIdDistribuidor(base64_decode($_GET['iu']));
			}
			elseif(base64_decode($_GET['tu']) == 'p'){
				$asesor= $obj_modelo->GetIdAsesor(base64_decode($_GET['iu']));
			}
			
			// Para la busqueda
			$rif= $obj_generico->CleanText($obj_generico->ToUpper($_GET['rif']));
			$nombre= $obj_generico->CleanText($_GET['nombre']);
			$indicador= $obj_generico->CleanText($obj_generico->ToLower($_GET['indicador']));
			
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetListado(false,false,$distribuidor,$asesor,$nombre,$indicador,$rif,true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Informacion de la tabla
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				$data[]= array(
					"Cliente"=>$datos['Nombre_Cliente'],
					"RIF"=>$datos['Rif'],
					"Correo"=>$datos['Email']
				);
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Listado de Clientes', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("RIF"=>array('justification'=>'center', 'width'=>80))
				) 
			);
			$archivo= true;
			break;
			
			
			
			
		case 'eq':
			
			// Tipo de usuario
			$tipo_usuario= base64_decode($_GET['tu']);
			
			// Modelo asignado
			require('.'.$obj_config->GetVar('ruta_modelo').'Equipo.php');
			$obj_modelo= new Equipo($obj_conexion,$obj_config->GetVar('esquema'));
			
			$distribuidor=false;
			$asesor=false;
			$cliente=false;
			
			// Busca el id correspondiente
			switch ($tipo_usuario){
				case "c":
					$cliente= $obj_modelo->GetIdCliente(base64_decode($_GET['iu']));
					break;
			
				case "d":
					$distribuidor= $obj_modelo->GetIdDistribuidor(base64_decode($_GET['iu']));
					break;
					
				case "p":
					$asesor= $obj_modelo->GetIdAsesor(base64_decode($_GET['iu']));
					break;
			}
			
			// Para la busqueda
			$codigo= $obj_generico->CleanText( $obj_generico->ToUpper($_GET['codigo']) );
			$tipo= $obj_generico->CleanText($_GET['tipo']);
			$marca= $obj_generico->CleanText($_GET['marca']);
			$modelo= $obj_generico->CleanText( $obj_generico->ToUpper($_GET['modelo']) );
			$numero= $obj_generico->CleanText($_GET['numero']);
			$search_cliente= $obj_generico->CleanText($_GET['cliente']);
			$nombre= $obj_generico->CleanText( $obj_generico->FirstUpper($_GET['nombre']) );
			
			// Busqueda de la informacion a mostrar
			$data= array();
			$result= $obj_modelo->GetListado(false, false, $codigo, $tipo, $marca, $modelo, $numero, $cliente, $distribuidor, $asesor, $search_cliente, $nombre, true);
			while($row= $obj_conexion->GetArrayInfo($result)){
				// Limpia los caracteres html
				$datos= array_map('html_entity_decode',$row);
				$datos= $obj_generico->CleanTextDb($datos);
				
				// Dato de la ultima columna
				if($tipo_usuario=='d' || $tipo_usuario=='p'){
					$titulo_columna= "Cliente";
					$dato_columna= $datos['Nombre_Cliente'];
				}
				elseif($tipo_usuario=='c'){
					$titulo_columna= "Capacidad";
					$dato_columna= $datos['Capacidad_Sistema'];
				}
				
				// Informacion de la tabla
				$data[]= array(
					"Codigo Equipo"=>$datos['Codigo_Equipo'],
					"Nombre Equipo"=>$datos['Nombre_Equipo'],
					"Tipo"=>$datos['Tipo'],
					"Marca"=>$datos['Marca'],
					$titulo_columna=>$dato_columna
				);
			}
			
			// Creacion de la tabla
			$pdf->ezTable(
				$data, '', 'Listado de Equipos', 
				array(
					'width'=>500, 'shaded'=>2, 
					'shadeCol'=>array(0.85,0.85,0.85), 'shadeCol2'=>array(0.95,0.95,0.95),
					'cols'=> array("Codigo Equipo"=>array('justification'=>'center', 'width'=>100))
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
		$pdf->ezStream(array('Content-Disposition'=>'Listado_'.date('d_m_Y').'.pdf'));
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