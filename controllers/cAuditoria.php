<?php

// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'auditoria'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Auditoria.php');
$obj_modelo= new Auditoria($obj_conexion,$obj_config->GetVar('esquema'));


switch(ACCION) {
	
	case 'buscar':

		// Ruta actual
		$_SESSION['Ruta_Auditoria_buscar']= $obj_generico->RutaRegreso();

		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Auditoria']);

		// Parseo final del status
		$obj_xtpl->parse('main.auditoria.buscar');
		break;
		
	case 'avanzada':
	
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Auditoria_buscar']);
		
		$cargo = $_GET['cargo'];
		$id_nombre = $_GET['id_nombre'];
		$fechainicial = $obj_date->changeFormatDate($_GET['date1'], 2);
		$fechafinal = $obj_date->changeFormatDate($_GET['date2'], 2);
		
		//Asignacion para recibirlos despues en la opcion de exportar por el Get
		$obj_xtpl->assign('opciones',"cargo={$cargo}&amp;id_nombre={$id_nombre}&amp;date1={$fechainicial}&amp;date2={$fechafinal}");
		
		// Para la paginacion
		if(empty($_GET['pg'])){
			$pag= 1;
		}
		else{
			$pag= $_GET['pg'];
		}
		
		switch($cargo) {
			case 0:
				$id_cuenta_acceso= $obj_modelo->GetPersonalAvanzado($id_nombre);
				break;
			case 1:
				$id_cuenta_acceso= $obj_modelo->GetDistribuidorAvanzado($id_nombre);
				break;
			case 2:
				$id_cuenta_acceso= $obj_modelo->GetTransportistaAvanzado($id_nombre);
				break;
			case 3:
				$id_cuenta_acceso= $obj_modelo->GetClienteAvanzado($id_nombre);
				break;
		}
		
		// Funcion para llamar todos los campos de la tabla TR001_Historial
		$auditoria = $obj_modelo->GetAuditoria($obj_config->GetVar('num_registros'),$pag, $id_cuenta_acceso, $fechainicial, $fechafinal);
	
		// Busca e imprime los valores de la Tabla TR001_Historial
		$i=1;
		while($row= $obj_conexion->GetArrayInfo($auditoria['result'])){
			if( ($i % 2) >0){
				$obj_xtpl->assign('estilo_fila', 'odd');
			}
			else{
				$obj_xtpl->assign('estilo_fila', 'even');
			}
			$obj_xtpl->assign('id_evento', $row['id_Historial']);
			$obj_xtpl->assign('ip', $row['IP']);
			$obj_xtpl->assign('nombre_actor', $obj_generico->CleanTextDb($obj_modelo->GetActor($row['id_Cuenta_Acceso'])));
			$obj_xtpl->assign('fecha', $row['Fecha']);
			$obj_xtpl->assign('hora', $row['Hora']);	
			$obj_xtpl->assign('nombre_evento',  $obj_generico->CleanTextDb($obj_modelo->GetAccion($row['id_Accion'])) );
			$obj_xtpl->assign('detalle', $row['detalle_accion']);	
			$obj_xtpl->parse('main.auditoria.tabla_avanzada_auditoria.lista_avanzada_auditoria');
			$i++;
		}
		
		// Datos para la paginacion
		$paginacion= $obj_generico->paginacion($auditoria['pagina'],$auditoria['total_paginas'],$auditoria['total_registros'],$obj_generico->urlPaginacion());
		$obj_xtpl->assign('paginacion',$paginacion);

		// Parseo final del status
		$obj_xtpl->parse('main.auditoria.tabla_avanzada_auditoria');
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 12, $obj_conexion, $obj_config->GetVar('esquema'));
		break;
	
	
	
	default:

		// Ruta actual
		$_SESSION['Ruta_Auditoria']= $obj_generico->RutaRegreso();	
		
		// Para la paginacion
		if(empty($_GET['pg'])){
			$pag= 1;
		}
		else{
			$pag= $_GET['pg'];
		}
		
		// Funcion para llamar todos los campos de la tabla TR001_Historial
		$auditoria = $obj_modelo->GetAuditoria($obj_config->GetVar('num_registros'),$pag);
		
		$obj_xtpl->parse('main.auditoria.agregar');
		
		// Busca e imprime los valores de la Tabla TR001_Historial
		$i=1;
		while($row= $obj_conexion->GetArrayInfo($auditoria['result'])){
			if( ($i % 2) >0){
				$obj_xtpl->assign('estilo_fila', 'odd');
			}
			else{
				$obj_xtpl->assign('estilo_fila', 'even');
			}
			$obj_xtpl->assign('id_evento', $row['id_Historial']);
			$obj_xtpl->assign('ip', $row['IP']);
			$obj_xtpl->assign('nombre_actor', $obj_generico->CleanTextDb($obj_modelo->GetActor($row['id_Cuenta_Acceso'])));
			$obj_xtpl->assign('fecha', $row['Fecha']);
			$obj_xtpl->assign('hora', $row['Hora']);	
			$obj_xtpl->assign('nombre_evento', $obj_generico->CleanTextDb($obj_modelo->GetAccion($row['id_Accion'])) );
			$obj_xtpl->assign('detalle', $row['detalle_accion']);	
			$obj_xtpl->parse('main.auditoria.tabla_auditoria.lista_auditoria');
			$i++;
		}
		
		// Datos para la paginacion
		$paginacion= $obj_generico->paginacion($auditoria['pagina'],$auditoria['total_paginas'],$auditoria['total_registros'],$obj_generico->urlPaginacion());
		$obj_xtpl->assign('paginacion',$paginacion);
		
		// Para el historial
		$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 11, $obj_conexion, $obj_config->GetVar('esquema'));
		
		// Parseo final del status
		$obj_xtpl->parse('main.auditoria.tabla_auditoria');
		break;

}

$obj_xtpl->parse('main.auditoria');
?>