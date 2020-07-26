<?php
if( !empty($_POST['txtuser']) && !empty($_POST['txtpass']) ){
	
	// Conexion a la base de datos
	require($obj_config->GetVar('ruta_libreria').'Bd.php');
	$obj_conexion= new Bd();
	if( !$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db')) ){
		$nueva_url= "login.php?msj=469";
	}
	else{
		// Modelo asignado
		require($obj_config->GetVar('ruta_modelo').'LoginAcceso.php');
		$obj_modelo= new LoginAcceso($obj_conexion,$obj_config->GetVar('esquema'));
		
		if( $info= $obj_modelo->VerificarUsuario($_POST['txtuser'],md5($_POST['txtpass'])) ){
			
			// Destruccion de las variables de sesion
			session_unset();
			session_destroy();
			
			// Ruta en caso de no entrar en ningun condicional
			$nueva_url= "login.php";
			//Verificacion de perfil para saber si es administrador
			$perfill=$obj_modelo->VerificarPerfil($info['id_Cuenta_Acceso']);
			
			// Verificacion del usuario para ver si esta logueado o bloqueado
			if( $info['Bloqueado']==1 ){
				$nueva_url= "login.php?msj=404";
				unset($info);
			}
			elseif( $info['Conectado']==1 && $perfill!=1){
				$nueva_url= "login.php?msj=327";
				unset($info);
			}
			else{
				// Coloca al usuario como conectado
				$obj_modelo->ActualizaEstatusConectado($info['id_Cuenta_Acceso'],1);
				
				//Detecta la IP
				if(!empty($_SERVER['HTTP_X_FORWARDER_FOR'])){
					$ip = $_SERVER['HTTP_X_FORWARDER_FOR'];
				}
				elseif(!empty($_SERVER['HTTP_VIA'])){
					$ip = $_SERVER['HTTP_VIA'];
				}
				elseif(!empty($_SERVER['REMOTE_ADDR'])){
					$ip = $_SERVER['REMOTE_ADDR'];
				}
				else{
					$ip = 'Desconocida';
				}
				
				
				//Lo nuevo agregado
				session_set_cookie_params(0, "/"); 
				//session_set_cookie_params(0, "/", $HTTP_SERVER_VARS["HTTP_HOST"], 0);
				// Se define la sesion del usuario
				//include( $obj_config->GetVar('ruta_libreria').'InfoLogin.php');
				session_start();
				//Lo nuevo agregado
				
				
				$_SESSION['InfoLogin']= new InfoLogin($info['id_Cuenta_Acceso'], $info['Nombre'], $info['Perfil'], $ip,$info['Tipo_Usuario'],$info['Primer_Acceso']);
	
				// Se incluye el Archivo de la Clase Historial y se Instancia 
				include( $obj_config->GetVar('ruta_libreria').'Historial.php');
				$obj_historial= new Historial();

				// Llamamos al metodo para guardar la accion en la Bd
				$obj_historial->RegistrarEvento($info['id_Cuenta_Acceso'],$ip, 1, $obj_conexion, $obj_config->GetVar('esquema'));
	
				// Se define la fecha y hora de inicio de sesion en formato aaaa-mm-dd hh:mm:ss
				$_SESSION["UltimoAcceso"]= date("Y-n-j H:i:s");
				
				$nueva_url= $obj_config->GetVar('index_page');
			}
		}
		else{
			
			$nueva_url= "login.php?msj=207";
			
			// Verifica si existe un arreglo
			if( count($_SESSION['Iteracion'])>0 ){
				
				// Si ya se ha tratado de loguear verifica la cantidad
				if(array_key_exists($_POST['txtuser'], $_SESSION['Iteracion'])){
					
					$_SESSION['Iteracion'][$_POST['txtuser']]= $_SESSION['Iteracion'][$_POST['txtuser']]+1;
					
					// Si encuentra un elemento con 3 intentos erroneos
					$clave= array_search('3', $_SESSION['Iteracion']);
					if($clave!=""){
					
						// Bloqueo de cuenta de usuario
						if( $obj_modelo->BloquearUsuario($clave) ){
							session_unset();
							session_destroy();
							$nueva_url= "login.php?msj=404";
						}
					}
					
				}
				else{
					$_SESSION['Iteracion']= array_merge( $_SESSION['Iteracion'],array($_POST['txtuser']=>1) );
				}
			}
			else{
				$_SESSION['Iteracion']= array($_POST['txtuser']=>1);
			}
			
		}
	}
}
else{
	$nueva_url= "login.php?msj=185";
}

header('location:'.$nueva_url);
?>