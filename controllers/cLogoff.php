<?php
// Ruta de redireccionamiento
$ruta_inicio= $obj_config->GetVar('index_page');

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'LoginAcceso.php');
$obj_modelo= new LoginAcceso($obj_conexion,$obj_config->GetVar('esquema'));

// Coloca al usuario como desconectado
if( $obj_modelo->ActualizaEstatusConectado($_SESSION['InfoLogin']->GetCuenta(),0) ){
	
	// Para el historial
	$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 2, $obj_conexion, $obj_config->GetVar('esquema'));
	
	// Destruye la sesion
	unset($_SESSION['InfoLogin']);
	session_unset();
	session_destroy();
}

// Redireccionamiento
header('Location:'.$ruta_inicio);
?>