<?php

// Sesion e informacion del usuario conectado
include('./libraries/InfoLogin.php');

// Comprueba si es un usuario conectado o no.
if(isset($_SESSION['InfoLogin'])){
	// Redireccionamiento
	header('location:index.php');
}
/*
else{
	// Destruye la sesion
	unset($_SESSION['InfoLogin']);
	session_destroy();
}
*/
//print_r( $_SESSION['Iteracion'] );
// Archivo de variables de configuracion
require_once('./config/config.php');
$obj_config= new  ConfigVars();

// Archivo de mensajes
require_once($obj_config->GetVar('ruta_config').'mensajes.php');

// Muestra el formulario
if( !isset($_POST['btnentrar']) ){
	
	// Directorio de las librerias para la funcion "__autoload()"
	define(DIR_LIBRERIA,$obj_config->GetVar('ruta_libreria'));
	
	/**
	 * LLamada automatica de los archivos de las clases a utilizar.
	 *
	 * @param string $className
	 */
	function __autoload($class_name) {
		require_once (DIR_LIBRERIA.$class_name.".php");
	}
	
	// Objetos de clases
	$obj_xtpl = new XTemplate($obj_config->GetVar('ruta_vista')."login".$obj_config->GetVar('ext_vista'));
	$obj_date= new Fecha();
	
	// Asignaciones
	$obj_xtpl->assign('titulo_web',$obj_config->GetVar('titulo_sistema'));
	$obj_xtpl->assign('titulo_banner',$obj_config->GetVar('titulo_banner'));
	$obj_xtpl->assign('fecha_hoy',$obj_date->FechaActual());
	
	// Header de la Pagina
	include($obj_config->GetVar('ruta_controlador').'cHeader.php');
	
	switch ($_GET['msj']){
		case 185:
			$obj_xtpl->assign('msj_uno','block');
			$obj_xtpl->assign('mensaje', $mensajes['campos_vacios']);
			break;
			
		case 207:
			$obj_xtpl->assign('msj_uno','block');
			$obj_xtpl->assign('mensaje', $mensajes['acceso_invalido']);
			break;
			
		case 327:
			$obj_xtpl->assign('msj_uno','block');
			$obj_xtpl->assign('mensaje', $mensajes['acceso_conectado']);
			break;
			
		case 404:
			$obj_xtpl->assign('msj_uno','block');
			$obj_xtpl->assign('mensaje', $mensajes['acceso_bloqueado']);
			break;
			
		case 469:
			$obj_xtpl->assign('msj_uno','block');
			$obj_xtpl->assign('mensaje', $mensajes['sin_conexion_bd']);
			break;
			
		default:
			$obj_xtpl->assign('msj_uno','none');
			break;
	}
	
	// Pie de Pagina
	$obj_xtpl->assign_file('BOTTOM', $obj_config->GetVar('ruta_vista').'bottom'.$obj_config->GetVar('ext_vista'));
	
	// Parseo  final del  documento
	$obj_xtpl->parse('main');
	$obj_xtpl->out('main');
}
else{
	//  Verificacion de acceso al sistema
	include($obj_config->GetVar('ruta_controlador').'cLogin.php');
}
?>