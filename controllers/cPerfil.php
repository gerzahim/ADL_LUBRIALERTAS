<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'perfil'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Perfil.php');
$obj_modelo= new Perfil($obj_conexion,$obj_config->GetVar('esquema'));

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
			
			$obj_xtpl->assign('no_habilitado_n1','disabled="disabled"');
			$obj_xtpl->assign('no_habilitado_n2','disabled="disabled"');
			
			// Parseo del boton de accion
			if( !empty($_SESSION[OPCION.'_ADD']) ){
				$obj_xtpl->parse('main.contenido.formulario.boton');
			}
		}
		else{
			if( is_numeric($_GET['id']) && $_GET['id']!=1 ){
				
				// Asignaciones
				$obj_xtpl->assign('Nombre_Perfil', $obj_generico->CleanTextDb($obj_modelo->GetNombrePerfil($_GET['id'])));
				$obj_xtpl->assign('id_Perfil', $_GET['id']);
				$obj_xtpl->parse('main.contenido.formulario.identificador');
				
				// Modulos Asignados
				$result= $obj_modelo->GetModulosAsignados($_GET['id']);
				while($row= $obj_conexion->GetArrayInfo($result)){
					$modulos_asignados[]= $row;
				}
				
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
		
		// Modulos existentes (modulos padres)
		$result= $obj_modelo->GetModulos();
		while(	$row= $obj_conexion->GetArrayInfo($result) ){
			
			// Modulos Asignados
			foreach($modulos_asignados as $k=> $v){
				if($row['id_Modulos']==$v['id_Modulos']){
					$obj_xtpl->assign('check_box','checked="checked"');
					$obj_xtpl->assign('no_habilitado_n1','');
					
					if(!empty($v['Acceso_Agregar'])){
						$obj_xtpl->assign('check_box_add','checked="checked"');
					}
					else{
						$obj_xtpl->assign('check_box_add','');
					}
					if(!empty($v['Acceso_Modificar'])){
						$obj_xtpl->assign('check_box_mod','checked="checked"');
					}
					else{
						$obj_xtpl->assign('check_box_mod','');
					}
					if(!empty($v['Acceso_Eliminar'])){
						$obj_xtpl->assign('check_box_del','checked="checked"');
					}
					else{
						$obj_xtpl->assign('check_box_del','');
					}
					break;
				}
				else{
					$obj_xtpl->assign('check_box','');
					$obj_xtpl->assign('check_box_add','');
					$obj_xtpl->assign('check_box_mod','');
					$obj_xtpl->assign('check_box_del','');
					$obj_xtpl->assign('no_habilitado_n1','disabled="disabled"');
				}
			}
			
			// Modulos hijos
			$i=1;
			$result_nivel1= $obj_modelo->GetModulos($row['id_Modulos']);
			while(	$row_nivel1= $obj_conexion->GetArrayInfo($result_nivel1) ){
				// Modulos Asignados
				foreach($modulos_asignados as $k=> $v){
					if($row_nivel1['id_Modulos']==$v['id_Modulos']){
						$obj_xtpl->assign('check_box_n1','checked="checked"');
						$obj_xtpl->assign('no_habilitado_n2','');
					
						if(!empty($v['Acceso_Agregar'])){
							$obj_xtpl->assign('check_box_add_n1','checked="checked"');
						}
						else{
							$obj_xtpl->assign('check_box_add_n1','');
						}
						if(!empty($v['Acceso_Modificar'])){
							$obj_xtpl->assign('check_box_mod_n1','checked="checked"');
						}
						else{
							$obj_xtpl->assign('check_box_mod_n1','');
						}
						if(!empty($v['Acceso_Eliminar'])){
							$obj_xtpl->assign('check_box_del_n1','checked="checked"');
						}
						else{
							$obj_xtpl->assign('check_box_del_n1','');
						}
						break;
					}
					else{
						$obj_xtpl->assign('check_box_n1','');
						$obj_xtpl->assign('check_box_add_n1','');
						$obj_xtpl->assign('check_box_mod_n1','');
						$obj_xtpl->assign('check_box_del_n1','');
						$obj_xtpl->assign('no_habilitado_n2','disabled="disabled"');
					}
				}
				
				// Modulos subhijos 
				$j=1;
				$result_nivel2= $obj_modelo->GetModulos($row_nivel1['id_Modulos']);
				while(	$row_nivel2= $obj_conexion->GetArrayInfo($result_nivel2) ){
					// Modulos Asignados
					foreach($modulos_asignados as $k=> $v){
						if($row_nivel2['id_Modulos']==$v['id_Modulos']){
							$obj_xtpl->assign('check_box_n2','checked="checked"');
						
							if(!empty($v['Acceso_Agregar'])){
								$obj_xtpl->assign('check_box_add_n2','checked="checked"');
							}
							else{
								$obj_xtpl->assign('check_box_add_n2','');
							}
							if(!empty($v['Acceso_Modificar'])){
								$obj_xtpl->assign('check_box_mod_n2','checked="checked"');
							}
							else{
								$obj_xtpl->assign('check_box_mod_n2','');
							}
							if(!empty($v['Acceso_Eliminar'])){
								$obj_xtpl->assign('check_box_del_n2','checked="checked"');
							}
							else{
								$obj_xtpl->assign('check_box_del_n2','');
							}
							break;
						}
						else{
							$obj_xtpl->assign('check_box_n2','');
							$obj_xtpl->assign('check_box_add_n2','');
							$obj_xtpl->assign('check_box_mod_n2','');
							$obj_xtpl->assign('check_box_del_n2','');
						}
					}
				
					// Asignaciones y parseo
					$obj_xtpl->assign($obj_generico->CleanTextDb($row_nivel2));
					$obj_xtpl->assign('num',$j);
					$obj_xtpl->assign('padre_modulo',$row_nivel1['id_Modulos']);
					if($row_nivel2['Referencia_Modulos']!=''){
						$obj_xtpl->parse('main.contenido.formulario.lista.nivel1.nivel2.casillas');
					}
					else{
						$obj_xtpl->parse('main.contenido.formulario.lista.nivel1.nivel2.sin_casillas');
					}
					$obj_xtpl->parse('main.contenido.formulario.lista.nivel1.nivel2');
					$j++;
				}
				
				// Asignaciones y parseo
				$obj_xtpl->assign($obj_generico->CleanTextDb($row_nivel1));
				$obj_xtpl->assign('num',$i);
				$obj_xtpl->assign('padre_modulo',$row['id_Modulos']);
				if($row_nivel1['Referencia_Modulos']!=''){
					$obj_xtpl->parse('main.contenido.formulario.lista.nivel1.casillas');
				}
				else{
					$obj_xtpl->parse('main.contenido.formulario.lista.nivel1.sin_casillas');
					$obj_xtpl->assign('script_activar','onClick="act_mod(this.value,'.($j-1).',2,'.$row['id_Modulos'].','.$i.');"');
				}
				$obj_xtpl->parse('main.contenido.formulario.lista.nivel1');
				$i++;
			}
					
			// Asignaciones y parseo
			$obj_xtpl->assign($obj_generico->CleanTextDb($row));
			if($row['Referencia_Modulos']!=''){
				$obj_xtpl->parse('main.contenido.formulario.lista.casillas');
			}
			else{
				$obj_xtpl->parse('main.contenido.formulario.lista.sin_casillas');
				$obj_xtpl->assign('script_activar','onClick="act_mod(this.value,'.($i-1).',1,1,1);"');
			}
			$obj_xtpl->parse('main.contenido.formulario.lista');
		}
		
		// Parseo del formulario
		$obj_xtpl->parse('main.contenido.formulario');
		break;
	
	
	
	// Guarda los datos del perfil
	case 'save':
						
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_ADD'])){
			$nombre= $obj_generico->CleanText($_POST['txtname']);
			if(!$obj_generico->IsEmpty( $nombre )){
				
				// Verifica que no este repetido el nombre
				if( $obj_modelo->VerificaNombreRepetido($nombre) ){
					$_SESSION['mensaje']= $mensajes['perfil_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
					if( $id_perfil= $obj_modelo->GuardaNombrePerfil($nombre) ){
	
						// Guarda los modulos a los que tiene acceso y sus respectivos permisos
						if($_POST['chk']){
							foreach($_POST['chk'] as $key=>$value){
								if(!empty($_POST['add_'.$value])){
									$add_acceso= $_POST['add_'.$value];
								}
								else{
									$add_acceso= 0;
								}
								if(!empty($_POST['upd_'.$value])){
									$upd_acceso= $_POST['upd_'.$value];
								}
								else{
									$upd_acceso= 0;
								}
								if(!empty($_POST['del_'.$value])){
									$del_acceso= $_POST['del_'.$value];
								}
								else{
									$del_acceso= 0;
								}
								$obj_modelo->GuardaPerfilModulo($id_perfil,$value,$add_acceso,$upd_acceso,$del_acceso);
							}
						}
					// Para el historial
					$detalle=$nombre;
	
					$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 50, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
				
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
	
	
	
	// Para la actualizacion de la informacion
	case 'upd':
						
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado (tambien en caso de que sea el perfil del administrador)
		if(!empty($_SESSION[OPCION.'_MOD']) && $_POST['referencia'] !=1){
			$nombre= $obj_generico->CleanText($_POST['txtname']);
			if(!$obj_generico->IsEmpty( $nombre ) && !$obj_generico->IsEmpty( $_POST['referencia'] )){
				
				// Verifica que no este repetido el nombre
				if( $obj_modelo->VerificaNombreRepetido($nombre,$_POST['referencia']) ){
					$_SESSION['mensaje']= $mensajes['perfil_repetido'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
				
					// Actualiza el nombre en caso de ser necesario
					if( $obj_modelo->ActualizaNombrePerfil($nombre,$_POST['referencia']) ){
						
						// Guarda los modulos a los que tiene acceso y sus respectivos permisos
						if($_POST['chk']){
							
							if( $obj_modelo->EliminaPerfilModulo($_POST['referencia']) ){
								foreach($_POST['chk'] as $key=>$value){
									if(!empty($_POST['add_'.$value])){
										$add_acceso= $_POST['add_'.$value];
									}
									else{
										$add_acceso= 0;
									}
									if(!empty($_POST['upd_'.$value])){
										$upd_acceso= $_POST['upd_'.$value];
									}
									else{
										$upd_acceso= 0;
									}
									if(!empty($_POST['del_'.$value])){
										$del_acceso= $_POST['del_'.$value];
									}
									else{
										$del_acceso= 0;
									}
									$obj_modelo->GuardaPerfilModulo($_POST['referencia'],$value,$add_acceso,$upd_acceso,$del_acceso);
								}
								
								// Para el historial
								$detalle=$nombre;
								$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 51, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
								
								$_SESSION['mensaje']= $mensajes['info_modificada'];
								header('location:'.$_SESSION['Ruta_Lista']);
							}
							else{
								$_SESSION['mensaje']= $mensajes['fallo_modificar'];
								header('location:'.$_SESSION['Ruta_Form']);
							}
							
						}
						else{
							$_SESSION['mensaje']= $mensajes['info_modificada'];
							header('location:'.$_SESSION['Ruta_Lista']);
						}
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
	
		// Parseo del bloque en caso de tener el permiso de lo contrario lo devuelve al listado (tambien en caso de que sea el perfil del administrador)
		if( !empty($_SESSION[OPCION.'_DEL']) && (is_numeric($_GET['id']) || is_numeric($_POST['referencia'])) && $_POST['referencia']!=1 && $_GET['id']!=1 ){
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
			
			if( $obj_modelo->VerificaRelacionUsuario($_GET['id']) ){
				// Si encuentra relacion perfil-usuario no permite eliminar
				$obj_xtpl->parse('main.contenido.vinculacion');
			}
			else{
				
				// Confirmacion de la eliminacion
				if(!$_POST['btneliminar']){
					$obj_xtpl->assign('id_registro', $_GET['id']);
					$obj_xtpl->parse('main.contenido.eliminacion');
				}
				else{
					if( $obj_modelo->ActualizaEstatusEliminado($_POST['referencia']) ){
						
						// Para el historial
						$nombre=$obj_modelo->GetNombrePerfilEliminar($_POST['referencia']);
						
						$detalle=$nombre;
						$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 52, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
						
						$_SESSION['mensaje']= $mensajes['info_eliminada'];
					}
					else{
						$_SESSION['mensaje']= $mensajes['fallo_eliminar'];
					}
					header('location:'.$_SESSION['Ruta_Lista']);
				}
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
			
			// Busca los perfiles creados
			$lista= $obj_modelo->GetPerfiles($obj_config->GetVar('num_registros'),$pag);
			$i=1;
			while($row= $obj_conexion->GetArrayInfo($lista['result'])){
				if( ($i % 2) >0){
					$obj_xtpl->assign('estilo_fila', 'odd');
				}
				else{
					$obj_xtpl->assign('estilo_fila', 'even');
				}
				
				// Asignacion de los datos
				$obj_xtpl->assign($obj_generico->CleanTextDb($row));
					
				// Parseo del bloque del enlace de eliminar en caso de tener el permiso
				if($_SESSION[OPCION.'_DEL']){
					$obj_xtpl->parse('main.contenido.listado.lista.eliminar_02');
				}
				
				// Modulos del perfil
				if( $result_modulos= $obj_modelo->GetModulosPorPerfil($row['id_Perfil']) ){
					$modulos="";
					$total_modulos= $obj_conexion->GetNumberRows($result_modulos);
					$j=1;
					while($row_modulos= $obj_conexion->GetArrayInfo($result_modulos)){
						if($j<$total_modulos){
							$modulos.= $obj_generico->CleanTextDb($row_modulos['Nombre_Modulos'])." * ";
						}
						else{
							$modulos.= $obj_generico->CleanTextDb($row_modulos['Nombre_Modulos']);
						}
						$j++;
					}
					
					// Asignacion de los datos
					$obj_xtpl->assign('Modulos_Acceso', $modulos);
				}
				
				// Parseo del bloque de la fila
				$obj_xtpl->parse('main.contenido.listado.lista');
				
				$i++;
			}
		
			// Datos para la paginacion
			$paginacion= $obj_generico->paginacion($lista['pagina'],$lista['total_paginas'],$lista['total_registros'],$obj_generico->urlPaginacion());
			$obj_xtpl->assign('paginacion',$paginacion);
			
			// Parseo del bloque
			$obj_xtpl->parse('main.contenido.listado');
			
			// Para el historial
			$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 3, $obj_conexion, $obj_config->GetVar('esquema'));
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>