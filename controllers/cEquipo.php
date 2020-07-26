<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'equipo'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Equipo.php');
$obj_modelo= new Equipo($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){

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
				$row_datos= $obj_modelo->GetDatosEquipo($_GET['id']);
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
		$obj_xtpl->assign('alfanumerico_requerido', 'class="{alfanumerico:true}"');
		$obj_xtpl->assign('codigo_campo_requerido', 'class="{codigofield:true,required:true}"');
		$obj_xtpl->assign('numerico_campo_requerido', 'class="{numerofloat:true,required:true}"');
		
		// Si no es cliente muestra el listado para seleccion
		if($_SESSION['InfoLogin']->GetTipo()!='c'){
			
			$distribuidor=false;
			$asesor=false;
			
			// Busca el id correspondiente
			switch ($_SESSION['InfoLogin']->GetTipo()){
			
				case "d":
					$distribuidor= $obj_modelo->GetIdDistribuidor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
					
				case "p":
					$asesor= $obj_modelo->GetIdAsesor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
			}
			
			// Listado de Clientes
			if( $result= $obj_modelo->GetClientes($distribuidor,$asesor) ){
				while($row= $obj_conexion->GetArrayInfo($result)){
					if( $row['id_Cliente'] == $row_datos['id_Cliente']){
						$obj_xtpl->assign('seleccion','selected="selected"');
					}
					else{
						$obj_xtpl->assign('seleccion','');
					}
					$obj_xtpl->assign($obj_generico->CleanTextDb($row));
					$obj_xtpl->parse('main.contenido.formulario.cliente.lista');
				}
			}
			if(ACCION=='mod'){
				$obj_xtpl->assign('permiso','disabled="disabled"');
			}
			$obj_xtpl->parse('main.contenido.formulario.cliente');
		}
		
		// Parseo del formulario
		$obj_xtpl->parse('main.contenido.formulario');
		break;
	
	
	
	// Guarda los datos
	case 'save':
	
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_ADD'])){
		
			$codigo= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_codigo']) );
			$tipo= $obj_generico->CleanText($_POST['txt_tipo']);
			$marca= $obj_generico->CleanText($_POST['txt_marca']);
			$modelo= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_modelo']) );
			$numero= $obj_generico->CleanText($_POST['txt_numero']);
			$capacidad= $obj_generico->CambioNumerico( $obj_generico->CleanText($_POST['txt_capacidad']),1 );
			$nombre= $obj_generico->FirstUpper( $obj_generico->CleanText($_POST['txt_nombre']));
			$descripcion= $obj_generico->CleanText($_POST['area_descrip']);
			
			if( $obj_generico->IsNumerico($_POST['op_cliente']) ){
				$cliente= $_POST['op_cliente'];
			}
			else{
				$cliente= 0;
			}
			
			if($_SESSION['InfoLogin']->GetTipo()=='c'){
				$cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
			}
			
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($codigo) && !$obj_generico->IsEmpty($tipo) && !$obj_generico->IsEmpty($marca) && !$obj_generico->IsEmpty($modelo) && !$obj_generico->IsEmpty($capacidad) && !$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($descripcion) ){
				
				// Verifica que no este repetido el codigo
				if( $obj_modelo->VerificaCodigoRepetido($codigo,$cliente) ){
					$_SESSION['mensaje']= $mensajes['codigo_equipo_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
					// Almacena la informacion
					if( $obj_modelo->GuardarDatosEquipo($codigo,$tipo,$marca,$modelo,$numero,$capacidad,$cliente,$descripcion,$nombre) ){
						// Para el historial
						$detalle=$nombre;
						
						$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 31, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
						
						$_SESSION['mensaje']= $mensajes['info_agregada'];
						header('location:'.$_SESSION['Ruta_Lista']);
					}
					else{
						$_SESSION['mensaje']= $mensajes['fallo_agregar'].'<br/>'.$obj_conexion->vTextError;
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
	
	
	
	// Para la actualizacion de la informacion
	case 'upd':

		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_MOD'])){
			
			$id= $obj_generico->CleanText($_POST['referencia']);
			$codigo= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_codigo']) );
			$tipo= $obj_generico->CleanText($_POST['txt_tipo']);
			$marca= $obj_generico->CleanText($_POST['txt_marca']);
			$modelo= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_modelo']) );
			$numero= $obj_generico->CleanText($_POST['txt_numero']);
			$capacidad= $obj_generico->CambioNumerico( $obj_generico->CleanText($_POST['txt_capacidad']),1 );
			$nombre= $obj_generico->CleanText( $obj_generico->FirstUpper($_POST['txt_nombre']) );
			$descripcion= $obj_generico->CleanText($_POST['area_descrip']);
					
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($tipo) && !$obj_generico->IsEmpty($marca) && !$obj_generico->IsEmpty($modelo) && !$obj_generico->IsEmpty($capacidad) && !$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($descripcion) ){
				
				// Verifica que no este repetido el codigo
				if( $obj_modelo->VerificaCodigoRepetido($codigo,$cliente,$id) ){
					$_SESSION['mensaje']= $mensajes['codigo_equipo_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
				
					// Almacena la informacion
					if( $obj_modelo->ActualizaDatosEquipo($codigo,$tipo,$marca,$modelo,$numero,$capacidad,$descripcion,$nombre,$id) ){
						
						// Para el historial
						$detalle=$nombre;
						
						$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 30, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
						
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
						$nombre=$obj_modelo->GetNombreEquipoEliminar($_POST['referencia']);
						$detalle=$nombre;
						$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 29, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
					
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
	
	
	
	// Para la busqueda
	case 'buscar':
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Campos requeridos y formato del campo para el javascript
		$obj_xtpl->assign('codigo_campo_requerido', 'class="{codigofield:true}"');
		$obj_xtpl->assign('alfanumerico_requerido', 'class="{alfanumerico:true}"');
		
		// Si no es cliente muestra el listado para seleccion
		if($_SESSION['InfoLogin']->GetTipo()!='c'){
			
			$distribuidor=false;
			$asesor=false;
			
			// Busca el id correspondiente
			switch ($_SESSION['InfoLogin']->GetTipo()){
			
				case "d":
					$distribuidor= $obj_modelo->GetIdDistribuidor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
					
				case "p":
					$asesor= $obj_modelo->GetIdAsesor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
			}
			
			// Listado de Clientes
			if( $result= $obj_modelo->GetClientes($distribuidor,$asesor) ){
				while($row= $obj_conexion->GetArrayInfo($result)){
					$obj_xtpl->insert_loop('main.contenido.busqueda.listado_clientes.lista', $obj_generico->CleanTextDb($row) );
				}
			}
			
			// Parseo del listado
			$obj_xtpl->parse('main.contenido.busqueda.listado_clientes');
		}
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.busqueda');
		break;
		
	
	
	// Muestra el listado
	default:
	
			// Ruta actual
			$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
			
			// Enlace para exportar listado
			$link= $obj_generico->GetParamSearch($_GET);
			$ruta_exportar = "marcador=".base64_encode(rand(6000,8000));
			$ruta_exportar.= "&amp;m=eq&amp;tu=".base64_encode($_SESSION['InfoLogin']->GetTipo());
			$ruta_exportar.= "&amp;iu=".base64_encode($_SESSION['InfoLogin']->GetCuenta());
			$obj_xtpl->assign('ruta_exportacion', $ruta_exportar.$link);
			
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
			$codigo= $obj_generico->CleanText( $obj_generico->ToUpper($_GET['codigo']) );
			$tipo= $obj_generico->CleanText($_GET['tipo']);
			$marca= $obj_generico->CleanText($_GET['marca']);
			$modelo= $obj_generico->CleanText( $obj_generico->ToUpper($_GET['modelo']) );
			$numero= $obj_generico->CleanText($_GET['numero']);
			$search_cliente= $obj_generico->CleanText($_GET['cliente']);
			$nombre= $obj_generico->CleanText( $obj_generico->FirstUpper($_GET['nombre']) );
			
			$distribuidor=false;
			$asesor=false;
			$cliente=false;
			
			// Busca el id correspondiente
			switch ($_SESSION['InfoLogin']->GetTipo()){
				case "c":
					$cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_02');
					break;
			
				case "d":
					$distribuidor= $obj_modelo->GetIdDistribuidor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
					
				case "p":
					$asesor= $obj_modelo->GetIdAsesor($_SESSION['InfoLogin']->GetCuenta());
					$obj_xtpl->parse('main.contenido.listado.ultimo_titulo_01');
					break;
			}
			
			// Busca el listado de la informacion
			$lista= $obj_modelo->GetListado($obj_config->GetVar('num_registros'),$pag,$codigo,$tipo,$marca,$modelo,$numero,$cliente,$distribuidor,$asesor,$search_cliente,$nombre);
			if( $lista['total_registros']>0 ){
				$i=1;
				while($row= $obj_conexion->GetArrayInfo($lista['result'])){
					if( ($i % 2) >0){
						$obj_xtpl->assign('estilo_fila', 'odd');
					}
					else{
						$obj_xtpl->assign('estilo_fila', 'even');
					}
					
					// Asignacion de los datos
					$obj_xtpl->assign( $obj_generico->CleanTextDb($row) );
					$obj_xtpl->assign('Capacidad_Sistema', $obj_generico->CambioNumerico( $obj_generico->CleanTextDb($row['Capacidad_Sistema']),2 ));
					
					// Parseo del bloque del enlace de eliminar en caso de tener el permiso
					if($_SESSION[OPCION.'_DEL']){
						$obj_xtpl->parse('main.contenido.listado.lista.eliminar_02');
					}
					
					// Parseo de la ultima columna
					if($_SESSION['InfoLogin']->GetTipo()=='d' || $_SESSION['InfoLogin']->GetTipo()=='p'){
						$obj_xtpl->parse('main.contenido.listado.lista.ultima_columna_01');
					}
					elseif($_SESSION['InfoLogin']->GetTipo()=='c'){
						$obj_xtpl->parse('main.contenido.listado.lista.ultima_columna_02');
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
			$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 28, $obj_conexion, $obj_config->GetVar('esquema'));
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>