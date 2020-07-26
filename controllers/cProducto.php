<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'producto'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Producto.php');
$obj_modelo= new Producto($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){

	// Para la busqueda
	case 'buscar':
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.busqueda');	
		break;
		
		
		
	// Para la eliminacion de la informacion
	case 'del':
	
		// Parseo del bloque en caso de tener el permiso de lo contrario lo devuelve al listado
		if( !empty($_SESSION[OPCION.'_DEL']) && (is_numeric($_GET['id']) || is_numeric($_POST['referencia'])) ){
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
			
			// Confirmacion de la eliminacion
			if(!$_POST['btneliminar']){
				$obj_xtpl->assign('id_registro', $_GET['id']);
				$obj_xtpl->parse('main.contenido.eliminacion');
			}
			else{				
				// Actualiza el estatus como eliminado
				if( $obj_modelo->ActualizaEstatusEliminado($_POST['referencia']) ){
					
					// Para el historial
					$codigo_pro= $obj_modelo->GetCodProducto($_POST['referencia']);
					$detalle=$codigo_pro;
					
					$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 45, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
							
					$_SESSION['mensaje']= $mensajes['info_eliminada'];
				}
				else{
					$_SESSION['mensaje']= $mensajes['fallo_eliminar'];
				}
				header('location:'.$_SESSION['Ruta_Lista']);
			}
			
		}
		else{
			header('location:'. $_SESSION['Ruta_Lista']);
		}
		break;
		
		
		
		
	// Muetra del formulario
	case 'add':
	case 'mod':
		$modulos_asignados= array();
	
		if(ACCION=='add'){
			// Accion a realizar
			$obj_xtpl->assign('tipo_accion', 'save');
			$obj_xtpl->assign('tag_boton', 'Guardar');
			
			// Parseo del boton de accion
			if( !empty($_SESSION[OPCION.'_ADD']) ){
				$obj_xtpl->parse('main.contenido.formulario.boton');
			}
		}
		else{
			if( is_numeric($_GET['id']) ){
				
				// Asignaciones
				$row_datos= $obj_modelo->GetDatosProducto($_GET['id']);
				$obj_xtpl->assign($obj_generico->CleanTextDb($row_datos));
				
				// ID en el hidden
				$obj_xtpl->parse('main.contenido.formulario.identificador');
				
				// Accion a realizar
				$obj_xtpl->assign('tipo_accion', 'upd');
				$obj_xtpl->assign('tag_boton', 'Modificar');
				
				// Parseo del boton de accion
				if( !empty($_SESSION[OPCION.'_MOD']) ){
					$obj_xtpl->parse('main.contenido.formulario.boton');
				}
			}
			else{
				header('location:'.$_SESSION['Ruta_Lista']);
			}
		}
				
		// Ruta actual
		$_SESSION['Ruta_Form']= $obj_generico->RutaRegreso();
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Campos requeridos y formato del campo para el javascript
		$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
		
		// Parseo del formulario
		$obj_xtpl->parse('main.contenido.formulario');
		break;
	
	
	
	// Guarda los datos
	case 'save':
						
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_ADD'])){
			$nombre= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_name']) );
			$codigo= $obj_generico->CleanText($_POST['txt_codigo']);
			$descripcion= $obj_generico->CleanText($_POST['area_descrip']);
					
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($codigo) ){
				
				// Verifica que no este repetido el email
				if( $obj_modelo->VerificaCodigoRepetido($codigo) ){
					$_SESSION['mensaje']= $mensajes['codigo_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
					
					// Almacena la informacion
					if( $obj_modelo->GuardarDatosProducto($nombre,$codigo,$descripcion) ){
						
					// Para el historial
					$detalle=$nombre;
					
					$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 43, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
						
					$_SESSION['mensaje']= $mensajes['info_agregada'];
					header('location:'.$_SESSION['Ruta_Lista']);
					}
					else{
						$_SESSION['mensaje']= $mensajes['fallo_agregar'];
						header('location:'.$_SESSION['Ruta_Form']);
					}
					
				}
			}
			else{
				$_SESSION['mensaje']= $mensajes['info_requerida'];
				header('location:'.$_SESSION['Ruta_Form']);
			}
		}
		else{
			header('location:'. $_SESSION['Ruta_Lista']);
		}
		break;
	
	
	
	// Actualiza los datos
	case 'upd':
						
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_ADD'])){
		
			$id= $obj_generico->CleanText($_POST['referencia']);
			$nombre= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_name']) );
			$codigo= $obj_generico->CleanText($_POST['txt_codigo']);
			$descripcion= $obj_generico->CleanText($_POST['area_descrip']);
					
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($codigo) ){
				
				// Verifica que no este repetido el email
				if( $obj_modelo->VerificaCodigoRepetido($codigo,$id) ){
					$_SESSION['mensaje']= $mensajes['codigo_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
					
					// Almacena la informacion
					if( $obj_modelo->ActualizarDatosProducto($nombre,$codigo,$descripcion,$id) ){
						
					// Para el historial
					$detalle=$nombre;
					
					$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 44, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
			
						$_SESSION['mensaje']= $mensajes['info_modificada'];
						header('location:'.$_SESSION['Ruta_Lista']);
					}
					else{
						$_SESSION['mensaje']= $mensajes['fallo_modificar'];
						header('location:'.$_SESSION['Ruta_Form']);
					}
					
				}
			}
			else{
				$_SESSION['mensaje']= $mensajes['info_requerida'];
				header('location:'.$_SESSION['Ruta_Form']);
			}
		}
		else{
			header('location:'. $_SESSION['Ruta_Lista']);
		}
		break;
	
	
	
	// Muestra el listado
	default:
	
			// Ruta actual
			$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
			
			// Para la paginacion
			if(empty($_GET['pg'])){
				$pag= 1;
			}
			else{
				$pag= $_GET['pg'];
			}
			
			// Parseo del enlace de agregar en caso de tener el permiso
			if($_SESSION[OPCION.'_ADD']){
				$obj_xtpl->parse('main.contenido.listado.agregar');
			}
			
			// Parseo de la fila de eliminar en caso de tener el permiso
			if($_SESSION[OPCION.'_DEL']){
				$obj_xtpl->parse('main.contenido.listado.eliminar_01');
			}
			
			// Para la busqueda
			$codigo= $obj_generico->CleanText($_GET['codigo']);
			$nombre= $obj_generico->CleanText( $obj_generico->ToUpper($_GET['nombre']) );
			
			// Busca el listado de la informacion
			$lista= $obj_modelo->GetListado($obj_config->GetVar('num_registros'),$pag,$nombre,$codigo);
			if( $lista['total_registros']>0 ){
				$i=1;
				while($row= $obj_conexion->GetArrayInfo($lista['result'])){
					if( ($i % 2) >0){
						$obj_xtpl->assign('estilo_fila', 'odd');
					}
					else{
						$obj_xtpl->assign('estilo_fila', 'even');
					}
					
					$datos= $obj_generico->CleanTextDb($row);
					
					// Asignacion de los datos
					$obj_xtpl->assign('id_Producto',$datos['id_Producto']);
					$obj_xtpl->assign('Codigo_Producto',$datos['Codigo_Producto']);
					$obj_xtpl->assign('Nombre_Producto',$datos['Nombre_Producto']);
					$obj_xtpl->assign( 'Descripcion', $obj_generico->CortarTexto($datos['Descripcion_Producto'],30) );
					
					// Parseo del bloque del enlace de eliminar en caso de tener el permiso
					if($_SESSION[OPCION.'_DEL']){
						$obj_xtpl->parse('main.contenido.listado.lista.eliminar_02');
					}
					
					// Parseo del bloque de la fila
					$obj_xtpl->parse('main.contenido.listado.lista');
					
					$i++;
				}
			}
			else{
				// Mensaje
				$obj_xtpl->assign('sin_listado',$mensajes['sin_lista']);
				
				// Parseo del bloque de la fila
				$obj_xtpl->parse('main.contenido.listado.no_lista');
			}
		
			// Datos para la paginacion
			$paginacion= $obj_generico->paginacion($lista['pagina'],$lista['total_paginas'],$lista['total_registros'],$obj_generico->urlPaginacion());
			$obj_xtpl->assign('paginacion',$paginacion);
			
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.listado');
			
			// Para el historial
			$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 42, $obj_conexion, $obj_config->GetVar('esquema'));
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>