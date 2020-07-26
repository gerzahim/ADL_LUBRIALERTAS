<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'distribuidor'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Distribuidor.php');
$obj_modelo= new Distribuidor($obj_conexion,$obj_config->GetVar('esquema'));

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
				$row_datos= $obj_modelo->GetDatosDistribuidor($_GET['id']);
				$obj_xtpl->assign($obj_generico->CleanTextDb($row_datos));
				
				// ID en el hidden
				$obj_xtpl->parse('main.contenido.formulario.identificador');
				
				// Accion a realizar
				$obj_xtpl->assign('tipo_accion', 'upd');
				$obj_xtpl->assign('tag_boton', 'Modificar');
				
				// Parseo del boton de accion
				if( !empty($_SESSION[OPCION.'_MOD']) ){
					$obj_xtpl->parse('main.contenido.formulario.generar');
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
		$obj_xtpl->assign('rif_requerido', 'class="{required:true,numerorif:true}"');
		$obj_xtpl->assign('email_requerido', 'class="{required:true,email:true}"');
		$obj_xtpl->assign('login_requerido', 'class="{loginformat:true,required:true}"');
		
		// Listado de Zonas
		if( $result= $obj_modelo->GetZonas() ){
			while($row= $obj_conexion->GetArrayInfo($result)){
				if( $row['id_zona'] == $row_datos['Zona']){
					$obj_xtpl->assign('seleccion','selected="selected"');
				}
				else{
					$obj_xtpl->assign('seleccion','');
				}
				$obj_xtpl->assign($obj_generico->CleanTextDb($row));
				$obj_xtpl->parse('main.contenido.formulario.lista_zonas');
			}
		}
		
		// Listado de Perfiles
		if( $result= $obj_modelo->GetPerfiles() ){
			while($row= $obj_conexion->GetArrayInfo($result)){
				if( $row['id_Perfil'] == $row_datos['Perfil']){
					$obj_xtpl->assign('seleccion','selected="selected"');
				}
				else{
					$obj_xtpl->assign('seleccion','');
				}
				$obj_xtpl->assign($obj_generico->CleanTextDb($row));
				$obj_xtpl->parse('main.contenido.formulario.lista_perfiles');
			}
		}
		
		// Parseo del formulario
		$obj_xtpl->parse('main.contenido.formulario');
		break;
	
	
	
	// Guarda los datos
	case 'save':
						
		// Realiza la accion en caso de tener el permiso de lo contrario lo devuelve al listado
		if(!empty($_SESSION[OPCION.'_ADD'])){
			$nombre= $obj_generico->CleanText($_POST['txt_name']);
			$rif= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_rif']) );
			$telf_ofc= $obj_generico->CleanText($_POST['txt_telf_ofc']);
			$telf_cel= $obj_generico->CleanText($_POST['txt_telf_cel']);
			$email= $obj_generico->CleanText( $obj_generico->ToLower($_POST['txt_email']) );
			$direccion= $obj_generico->CleanText($_POST['area_dir']);
			$zona= $obj_generico->CleanText($_POST['op_zona']);
			$contacto= $obj_generico->CleanText($_POST['txt_contacto']);
			$indicador= $obj_generico->CleanTextLogin( $_POST['txt_indicador'] );
			$perfil= $obj_generico->CleanText($_POST['op_perfil']);
			$fax= $obj_generico->CleanText($_POST['txt_fax']);
					
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($rif) && !$obj_generico->IsEmpty($email) && !$obj_generico->IsEmpty($direccion) && !$obj_generico->IsEmpty($contacto) && !$obj_generico->IsEmpty($indicador) && !$obj_generico->IsEmpty($perfil) ){
				
				/*
				$trozos= explode("@",$email);
				
				// Verifica que  el indicador sea igual a la primera parte del correo (antes del @)
				if($indicador != $trozos[0]){
					$_SESSION['mensaje']= $mensajes['email_indicador'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
				*/
					// Verifica que no este repetido el email
					if( $obj_modelo->VerificaEmailRepetido($email) ){
						$_SESSION['mensaje']= $mensajes['email_repetido'];
						header('location:'.$_SESSION['Ruta_Form']);
					}
					else{
						// Verifica el formato del indicador
						if($indicador!=trim($_POST['txt_indicador'])){
							$_SESSION['mensaje']= $mensajes['formato_indicador'];
							header('location:'.$_SESSION['Ruta_Form']);
						}
						else{
							// Verifica que no este repetido el indicador
							if( $obj_modelo->VerificaIndicadorRepetido($indicador) ){
								$_SESSION['mensaje']= $mensajes['indicador_repetido'];
								header('location:'.$_SESSION['Ruta_Form']);
							}
							else{
								$clave= $obj_generico->GenerarPassword();
								
								// Crea la cuenta de acceso
								if( $id_cuenta= $obj_modelo->GuardarDatosAcceso($nombre,md5($clave),$indicador,$perfil) ){
									
									// Almacena la informacion
									if( $obj_modelo->GuardarDatosDistribuidor($nombre, $rif, $telf_ofc, $telf_cel, $email, $direccion, $zona, $contacto, $fax, $id_cuenta) ){
										// Envia mensaje con datos de acceso al distribuidor
										$obj_correo->sendMailUsuario($obj_generico->CleanTextDb($nombre),$email,$indicador,$clave);
										
									// Para el historial
									$detalle=$nombre;
									$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 38, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
										
										$_SESSION['mensaje']= $mensajes['info_agregada'];
										header('location:'.$_SESSION['Ruta_Lista']);
									}
									else{
										$_SESSION['mensaje']= $mensajes['fallo_agregar'];
										header('location:'.$_SESSION['Ruta_Form']);
									}
								}
								else{
									$_SESSION['mensaje']= $mensajes['fallo_agregar'];
									header('location:'.$_SESSION['Ruta_Form']);
								}
								
							}
						}
					}
					
				//}
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
			$nombre= $obj_generico->CleanText($_POST['txt_name']);
			$rif= $obj_generico->CleanText( $obj_generico->ToUpper($_POST['txt_rif']) );
			$telf_ofc= $obj_generico->CleanText($_POST['txt_telf_ofc']);
			$telf_cel= $obj_generico->CleanText($_POST['txt_telf_cel']);
			$email= $obj_generico->CleanText( $obj_generico->ToLower($_POST['txt_email']) );
			$direccion= $obj_generico->CleanText($_POST['area_dir']);
			$zona= $obj_generico->CleanText($_POST['op_zona']);
			$contacto= $obj_generico->CleanText($_POST['txt_contacto']);
			$indicador= $obj_generico->CleanTextLogin( $_POST['txt_indicador'] );
			$perfil= $obj_generico->CleanText($_POST['op_perfil']);
			$fax= $obj_generico->CleanText($_POST['txt_fax']);
					
			// Verifica que los datos requeridos no este vacios
			if(!$obj_generico->IsEmpty($nombre) && !$obj_generico->IsEmpty($rif) && !$obj_generico->IsEmpty($email) && !$obj_generico->IsEmpty($direccion) && !$obj_generico->IsEmpty($contacto) && !$obj_generico->IsEmpty($indicador) && !$obj_generico->IsEmpty($perfil) ){
				/*
				$trozos= explode("@",$email);
				
				// Verifica que  el indicador sea igual a la primera parte del correo (antes del @)
				if($indicador != $trozos[0]){
					$_SESSION['mensaje']= $mensajes['email_indicador'];
					header('location:'.$_SESSION['Ruta_Form']);
				}
				else{
				*/
					// Verifica que no este repetido el email
					if( $obj_modelo->VerificaEmailRepetido($email,$id) ){
						$_SESSION['mensaje']= $mensajes['email_repetido'];
						header('location:'.$_SESSION['Ruta_Form']);
					}
					else{
						// Verifica el formato del indicador
						if($indicador!=trim($_POST['txt_indicador'])){
							$_SESSION['mensaje']= $mensajes['formato_indicador'];
							header('location:'.$_SESSION['Ruta_Form']);
						}
						else{
							// Verifica que no este repetido el indicador
							if( $obj_modelo->VerificaIndicadorRepetido($indicador,$obj_modelo->GetCuentaAcceso($id)) ){
								$_SESSION['mensaje']= $mensajes['indicador_repetido'];
								header('location:'.$_SESSION['Ruta_Form']);
							}
							else{
								
								// Actualiza los datos de la cuenta de acceso
								if( $obj_modelo->ActualizaDatosAcceso($nombre,$indicador,$perfil,$obj_modelo->GetCuentaAcceso($id)) ){
									
									// Actualiza la informacion del personal
									if( $obj_modelo->ActualizaDatosDistribuidor($nombre, $rif, $telf_ofc, $telf_cel, $email, $direccion, $zona, $contacto, $fax, $id) ){
										
									// Para el historial
									$detalle=$nombre;
									$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 39, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
										
										$_SESSION['mensaje']= $mensajes['info_modificada'];
										header('location:'.$_SESSION['Ruta_Lista']);
									}
									else{
										$_SESSION['mensaje']= $mensajes['fallo_modificar'];
										header('location:'.$_SESSION['Ruta_Form']);
									}
									
								}
								else{
									$_SESSION['mensaje']= $mensajes['fallo_modificar'];
									header('location:'.$_SESSION['Ruta_Form']);
								}
								
							}
						}
					}
				//}
				
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
			
			if( $obj_modelo->VerificaRelacionCliente($_GET['id']) ){
				// Si encuentra relacion distribuidor-cliente no permite eliminar
				$obj_xtpl->parse('main.contenido.vinculacion');
			}
			else{
				// Confirmacion de la eliminacion
				if(!$_POST['btneliminar']){
					$obj_xtpl->assign('id_registro', $_GET['id']);
					$obj_xtpl->parse('main.contenido.eliminacion');
				}
				else{
					
					// Cuenta de acceso
					$cuenta= $obj_modelo->GetCuentaAcceso($_POST['referencia']);
					
					// Actualiza el estatus como eliminado
					if( $obj_modelo->ActualizaEstatusEliminado($cuenta) ){
						
						// Para el historial
						$nombre=$obj_modelo->GetNombreDistribuidorEliminar($_POST['referencia']);
						$detalle=$nombre;
						$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 41, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);
					
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
	
	
	
	// Para la busqueda
	case 'buscar':
		
		// Ruta regreso
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Para la validacion con javascript
		$obj_xtpl->assign('rif_requerido', 'class="{numerorif:true}"');
		
		// Parseo del bloque
		$obj_xtpl->parse('main.contenido.busqueda');	
		break;
	
	
	
	// Para la cambio de status
	case 'status':
	
		// Parseo del bloque en caso de tener el permiso de lo contrario lo devuelve al listado
		if( !empty($_SESSION[OPCION.'_MOD']) && (is_numeric($_GET['id']) || is_numeric($_POST['referencia'])) ){
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
							
			// Confirmacion de la eliminacion
			if(!$_POST['btncambiar']){
				$obj_xtpl->assign('id_registro', $_GET['id']);
				$obj_xtpl->parse('main.contenido.cambio_status');
			}
			else{
				
				// Cuenta acceso
				$cuenta= $obj_modelo->GetCuentaAcceso($_POST['referencia']);
				
				// Actualiza el estatus como eliminado
				if( $obj_modelo->CambioEstatus($cuenta) ){
					$_SESSION['mensaje']= $mensajes['cambio_status'];
				}
				else{
					$_SESSION['mensaje']= $mensajes['fallo_estatus'];
				}
				header('location:'.$_SESSION['Ruta_Lista']);
			}
			
		}
		else{
			header('location:'. $_SESSION['Ruta_Lista']);
		}
		break;
	
	
	
	
	// Para la generacion de una nueva clave
	case 'newpass':
	
		// Parseo del bloque en caso de tener el permiso de lo contrario lo devuelve al listado
		if( !empty($_SESSION[OPCION.'_MOD']) && (is_numeric($_GET['id']) || is_numeric($_POST['referencia'])) ){
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
							
			// Confirmacion de la eliminacion
			if(!$_POST['btngenerar']){
				$obj_xtpl->assign('id_registro', $_GET['id']);
				$obj_xtpl->parse('main.contenido.generar_clave');
			}
			else{
				
				// Clave de acceso
				$clave= $obj_generico->GenerarPassword();
				
				// Cuenta acceso
				//Busca y guarda en 2 variables el valor de las claves antiguas
				$cuenta= $obj_modelo->GetCuentaAcceso($_POST['referencia']);
				$pass= $obj_modelo->GetPassados($id_cuenta_acceso);
				$passw=$pass['Password'];
				$passA=$pass['PasswordA'];
				
				
				
				// Actualiza el estatus como eliminado
				if( $obj_modelo->ActualizarClave($cuenta,md5($clave)) ){
					// Envia los datos de acceso por correo.
					$datos= $obj_modelo->GetDatosDistribuidor($_POST['referencia']);
					//Pasa las claves de un campo para otro con el objetivo de ir guardando las claves pasadas
					$obj_modelo->GuardarPassTOPassA($passw,$cuenta);
					$obj_modelo->GuardarPassATOPassB($passA,$cuenta);
					$obj_correo->sendMailNuevaClave($obj_generico->CleanTextDb($datos['Nombres_Apellidos']),$datos['Email'],$datos['Indicador_PDVSA'],$clave);
					$_SESSION['mensaje']= $mensajes['nueva_clave'];
					
					// Para el historial
					$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 40, $obj_conexion, $obj_config->GetVar('esquema'));
					
					$_SESSION['mensaje']= $mensajes['nueva_clave'];
				}
				else{
					$_SESSION['mensaje']= $mensajes['fallo_nueva_clave'];
				}
				header('location:'.$_SESSION['Ruta_Form']);
			}
			
		}
		else{
			header('location:'. $_SESSION['Ruta_Form']);
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
			$rif= $obj_generico->CleanText($obj_generico->ToUpper($_GET['rif']));
			$nombre= $obj_generico->CleanText($_GET['nombre']);
			$indicador= $obj_generico->CleanText( $obj_generico->ToLower($_GET['indicador']) );
			
			// Busca el listado de la informacion
			$lista= $obj_modelo->GetListado($obj_config->GetVar('num_registros'),$pag,$nombre,$indicador,$rif);
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
					
					// Status
					if( !empty($row["Conectado"]) ){
						$obj_xtpl->assign('status', 'CONECTADO');
						$obj_xtpl->assign('estilo_status', 'conectado');
											
						// Parseo del enlace de cambio de estatus en caso de tener el permiso a modificar
						if($_SESSION[OPCION.'_MOD']){
							$obj_xtpl->parse('main.contenido.listado.lista.enlace_estatus');
						}
						else{
							$obj_xtpl->parse('main.contenido.listado.lista.no_enlace_estatus');
						}
					}
					elseif( !empty($row["Bloqueado"]) ){
						$obj_xtpl->assign('status', 'BLOQUEADO');
						$obj_xtpl->assign('estilo_status', 'bloqueado');
						$obj_xtpl->parse('main.contenido.listado.lista.no_enlace_estatus');
					}
					else{
						$obj_xtpl->assign('status', 'DESCONECTADO');
						$obj_xtpl->assign('estilo_status', 'desconectado');
						$obj_xtpl->parse('main.contenido.listado.lista.no_enlace_estatus');
					}
					
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
			$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 37, $obj_conexion, $obj_config->GetVar('esquema'));
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>