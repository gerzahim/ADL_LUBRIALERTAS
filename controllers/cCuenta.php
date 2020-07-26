<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'cuenta'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Cuenta.php');
$obj_modelo= new Cuenta($obj_conexion,$obj_config->GetVar('esquema'));

// Acciones del modulo
switch (ACCION){
	
	// Actualiza los datos
	case 'upd':
	
		$oldpass= $obj_generico->CleanTextPassword($_POST['txt_oldpass']);
		$newpass= $obj_generico->CleanTextPassword($_POST['txt_newpass']);
		$repeatpass= $obj_generico->CleanTextPassword($_POST['txt_repeatpass']);
		
		$id_cuenta_acceso=$_SESSION['InfoLogin']->GetCuenta();
		
		$pass= $obj_modelo->GetPassados($id_cuenta_acceso);
		$passw=$pass['Password'];
		$passA=$pass['PasswordA'];
		$passB=$pass['PasswordB'];
		/*echo $passA;
		echo "<br>";
		echo $passB;*/
		
		// Verifica que los datos requeridos no este vacios
		if(!$obj_generico->IsEmpty($oldpass) && !$obj_generico->IsEmpty($newpass) && !$obj_generico->IsEmpty($repeatpass) ){
			
			// Verifica que no contengan caracteres especiales y que la longitud sea mayor o igual a 10
			if($newpass!=$_POST['txt_newpass'] || $oldpass!=$_POST['txt_oldpass'] || $repeatpass!=$_POST['txt_repeatpass'] || $obj_generico->SizeText($repeatpass)<10){
				$_SESSION['mensaje']= $mensajes['clave_erronea'];
			}
			else{
			
				// Verifica que la clave nueva sea igual a la repeticion
				if($newpass!=$repeatpass){
					$_SESSION['mensaje']= $mensajes['sin_repetir'];
				}
				else{
					// Verifica que la clave nueva sea diferente a la actual
					if($newpass==$oldpass){
						$_SESSION['mensaje']= $mensajes['clave_ciclica'];
					}
					else{
						if(md5($repeatpass)==$passA||md5($repeatpass)==$passB){
							$_SESSION['mensaje']= $mensajes['clave_ciclica_old'];
						}else{
							// Verifica que la clave actual sea igual a la de la BD.
							if( !$obj_modelo->VerificaClaveActual($_SESSION['InfoLogin']->GetCuenta(),md5($oldpass)) ){
								$_SESSION['mensaje']= $mensajes['clave_invalida'];
							}
							else{
							
								// Almacena la informacion
								if( $obj_modelo->ActualizarClaveUsuario($_SESSION['InfoLogin']->GetCuenta(),md5($repeatpass)) ){
									$_SESSION['mensaje']= $mensajes['clave_modificada'];
									
									$_SESSION['InfoLogin']->SetPrimerAcceso('0');
									//Pasa las claves de un campo para otro con el objetivo de ir guardando las claves pasadas
									$obj_modelo->GuardarPassTOPassA($passw,$id_cuenta_acceso);
									$obj_modelo->GuardarPassATOPassB($passA,$id_cuenta_acceso);
									
									$user= $obj_modelo->GetDatosUsuario($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetTipo());
									$obj_correo->sendMailCambioClave($obj_generico->CleanTextDb($_SESSION['InfoLogin']->GetUsuario()), $user['Email'], $user['Indicador_PDVSA'], $newpass);
								}
								else{
									$_SESSION['mensaje']= $mensajes['fallo_clave'];
								}
								
							}
						}
					}
				}
			}
			
		}
		else{
			$_SESSION['mensaje']= $mensajes['info_requerida'];
		}
		
		// Redirecciona al formulario.
		header( 'location:'.$obj_config->GetVar('index_page').'?op=cuenta' );
		break;
	
	
	
	// Muestra el formulario
	default:
			
			// Ruta regreso
			$obj_xtpl->assign('ruta_regreso', $obj_config->GetVar('index_page'));
			
			// Campos requeridos y formato del campo para el javascript
			$obj_xtpl->assign('clave_requerido', 'class="{required:true,alfanumerico:true,minLength:10}"');
			$obj_xtpl->assign('reclave_requerido','class="{required:true,alfanumerico:true,minLength:10,equalTo:\'#txt_newpass\'}"');
			
			// Parseo del formulario
			if( $_SESSION['InfoLogin']->GetPrimerAcceso()==0 ){
				$obj_xtpl->parse('main.contenido.formulario.boton');
			}
			$obj_xtpl->parse('main.contenido.formulario');
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>