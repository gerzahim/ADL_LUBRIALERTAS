<?php

// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'home'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Home.php');
$obj_modelo= new Home($obj_conexion,$obj_config->GetVar('esquema'));

//  Nombre del perfil
$obj_xtpl->assign( 'Nombre_Perfil', $obj_generico->CleanTextDb( $obj_modelo->GetNombrePerfil($_SESSION['InfoLogin']->GetPerfil()) ));

// Modulos asignados
$result= $obj_modelo->GetModulos($_SESSION['InfoLogin']->GetPerfil());
while(	$row= $obj_conexion->GetArrayInfo($result) ){
	$obj_xtpl->insert_loop('main.contenido.lista', $obj_generico->CleanTextDb($row) );
}

// Parseo final del menu
$obj_xtpl->parse('main.contenido');
?>