<?php

// Vista asignada
$obj_xtpl->assign_file('MENU', $obj_config->GetVar('ruta_vista').'menu'.$obj_config->GetVar('ext_vista'));


// Si es el primer acceso al sistema no muestra el menu.
if( $_SESSION['InfoLogin']->GetPrimerAcceso()==1 ){	
	// Parseo de notificacion de primer acceso
	$obj_xtpl->parse('main.primer_acceso');
}
else{
	
	// Modelo asignado
	require($obj_config->GetVar('ruta_modelo').'Menu.php');
	$obj_modelo= new Menu($obj_conexion,$obj_config->GetVar('esquema'));
	
	// Busca los modulos para el menu segun el perfil
	if ($result= $obj_modelo->GetMenu($_SESSION['InfoLogin']->GetPerfil())){
		
		// Crea los permisos y separa los padres de los hijos
		while($row= $obj_conexion->GetArrayInfo($result)){
			if(!$row['Modulo_Padre']){
				$menu_padres[]=$row;
			}
			else{
				$menu_hijos[]=$row;
			}
			
			// Permisologia
			$_SESSION[$row['Referencia_Modulos']]= 1;
			$_SESSION[$row['Referencia_Modulos'].'_ADD']= $row['Acceso_Agregar'];
			$_SESSION[$row['Referencia_Modulos'].'_MOD']= $row['Acceso_Modificar'];
			$_SESSION[$row['Referencia_Modulos'].'_DEL']= $row['Acceso_Eliminar'];
		}
		
		// Imprime los modulos
		foreach($menu_padres as $key_padre){
			
			// Modulos Padres
			if($key_padre['Referencia_Modulos']!=''){
				$obj_xtpl->assign('referencia_padre', 'href="'.$obj_config->GetVar('index_page').'?op='.$key_padre['Referencia_Modulos'].'"');
				
				//  Parseo del bloque del menu padre
				$obj_xtpl->assign('modulo_padre',$obj_generico->CleanTextDb($key_padre['Nombre_Modulos']));
				$obj_xtpl->parse('main.menu.menu_padre');
			}
			else{
				$obj_xtpl->assign('referencia_padre',"");
				
				foreach($menu_hijos as $key_hijos){
				
					if($key_hijos['Modulo_Padre']==$key_padre['id_Modulos']){
						if($key_hijos['Referencia_Modulos']!=''){
							$obj_xtpl->assign('referencia_hijo', 'href="'.$obj_config->GetVar('index_page').'?op='.$key_hijos['Referencia_Modulos'].'"');
							
							// Parseo del bloque hijo
							$obj_xtpl->assign('modulo_hijo',$obj_generico->CleanTextDb($key_hijos['Nombre_Modulos']));
							$obj_xtpl->parse('main.menu.menu_padre.menu_hijo');
						}
						else{
							$obj_xtpl->assign('referencia_hijo','');
							
							foreach($menu_hijos as $key_sub_hijos){
								// Si es sub_hijo parseo del bloque sub_hijo
								if($key_sub_hijos['Modulo_Padre']==$key_hijos['id_Modulos']){
									$obj_xtpl->assign('referencia_sub_hijo', $obj_config->GetVar('index_page').'?op='.$key_sub_hijos['Referencia_Modulos']);
									$obj_xtpl->assign('modulo_sub_hijo',$obj_generico->CleanTextDb($key_sub_hijos['Nombre_Modulos']));
									$obj_xtpl->parse('main.menu.menu_padre.menu_hijo.menu_sub_hijo');
								}
							}
								
							// Parseo del bloque hijo
							$obj_xtpl->assign('modulo_hijo',$obj_generico->CleanTextDb($key_hijos['Nombre_Modulos']));
							$obj_xtpl->parse('main.menu.menu_padre.menu_hijo');
						}
					}
				}
				
				//  Parseo del bloque del menu padre
				$obj_xtpl->assign('modulo_padre',$obj_generico->CleanTextDb($key_padre['Nombre_Modulos']));
				$obj_xtpl->parse('main.menu.menu_padre');
			}
			
		}
		
		// Destruye los arreglos
		unset($menu_padres);
		unset($menu_hijos);
	}
	
	// Parseo final del menu
	$obj_xtpl->parse('main.menu');
}

?>