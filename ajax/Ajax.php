<?php
// Archivo de variables de configuracion
require_once('../config/config.php');
$obj_config= new  ConfigVars();

// Directorio de las librerias para la funcion "__autoload()"
define(DIR_LIBRERIA,$obj_config->GetVar('ruta_libreria'));

// Para abrir los archivos de clases a utilizar
function  __autoload($class_name){
	require_once('.'.DIR_LIBRERIA.$class_name.'.php');
}

// Clases a utilizar
$obj_xml= new ClassXml();
$obj_conexion= new Bd();
$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db'));

// Apertura de la etiqueta principal de XML
$obj_xml->setOpenTag('root');

// Opciones Generales
switch ($_POST['opcion']){
	
	// Usado al momento de mostrar el listado de estados segun la zona
	case 'auditoria':
		
		// Elemento del XML
		$obj_xml->setElement('resultado', 'selectPersona');
		
		// Modelo de la clase
		include('.'.$obj_config->GetVar('ruta_modelo').'Auditoria.php');
		$obj_modelo= new Auditoria($obj_conexion);
		
		switch ($_POST['cargo']){
		
			case 0:  
				// Nombre de las Personas
				$result= $obj_modelo->GetPersonal();
				while($row=$obj_conexion->GetArrayInfo($result)){
				$obj_xml->setOpenTag('item');
				$obj_xml->setElement('codigo',$row['id_Personal']);
				$obj_xml->setElement('nombre',$row['Nombres_Apellidos']);
				$obj_xml->setCloseTag('item');
				}
		     break;
			 
			case 1:  
				// Nombre de los Distribuidores
				$result= $obj_modelo->GetDistribuidor();
				while($row=$obj_conexion->GetArrayInfo($result)){
				$obj_xml->setOpenTag('item');
				$obj_xml->setElement('codigo',$row['id_Distribuidores']);
				$obj_xml->setElement('nombre',$row['Nombres_Apellidos']);
				$obj_xml->setCloseTag('item');
				}
		     break;
			 
			case 2:  
				// Nombre de los Transportista
				$result= $obj_modelo->GetTransportista();
				while($row=$obj_conexion->GetArrayInfo($result)){
				$obj_xml->setOpenTag('item');
				$obj_xml->setElement('codigo',$row['id_Empresa_Transporte']);
				$obj_xml->setElement('nombre',$row['Nombre_Empresa']);
				$obj_xml->setCloseTag('item');
				}
		     break;
			 
			case 3:  
				// Nombre de los Clientes
				$result= $obj_modelo->GetCliente();
				while($row=$obj_conexion->GetArrayInfo($result)){
				$obj_xml->setOpenTag('item');
				$obj_xml->setElement('codigo',$row['id_Cliente']);
				$obj_xml->setElement('nombre',$row['Nombre_Cliente']);
				$obj_xml->setCloseTag('item');
				}
		     break;
		}

		break;

	// No crea ningun cuerpo XML	
	default:
		break;
}

// Cierra la etiqueta principal de XML
$obj_xml->setCloseTag('root');

// Imprime el cuerpo del XML.
print $obj_xml->getXml();
?>