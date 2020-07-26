<?php
// Vista asignada
$obj_xtpl->assign_file('CONTENIDO', $obj_config->GetVar('ruta_vista').'solicitud'.$obj_config->GetVar('ext_vista'));

// Modelo asignado
require($obj_config->GetVar('ruta_modelo').'Solicitud.php');
$obj_modelo= new Solicitud($obj_conexion,$obj_config->GetVar('esquema'));
$fecha= date("Y-m-d");
$hora=date("H:i:s");

// Acciones del modulo
switch (ACCION){

	// Muetra del formulario
	case 'crear_solicitud':	
		// Ruta formulario
		$_SESSION['Ruta_Form']= $obj_generico->RutaRegreso();
			
		$cantidad_muestra=$_GET['cantidad'];
		$obj_xtpl->assign("cantidad",$cantidad_muestra);
		$obj_xtpl->assign('ruta_regreso', $_SESSION['Ruta_Lista']);
		
		// Campos requeridos y formato del campo para el javascript
		$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
		$obj_xtpl->assign('numerico_requerido', 'class="{required:true,digits:true}"');
		$obj_xtpl->assign('email_requerido', 'class="{required:true,email:true}"');

		
		// Listado para parsear formulario de muestras tantas veces se haya especificado 
		$i=1;
		while($i<=$cantidad_muestra){
		
			// Listado de Equipos
			$id_cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
			
			$result= $obj_modelo->GetEquipos($id_cliente);
			while($row= $obj_conexion->GetArrayInfo($result)){
				//asigna los valores de la Bd a las etiquetas
				$obj_xtpl->assign($row);
				$obj_xtpl->parse('main.contenido.crear_solicitud.form_muestra.lista_equipos');
			}
				
			$resulta= $obj_modelo->GetProductos();
			while($row= $obj_conexion->GetArrayInfo($resulta)){
				//asigna los valores de la Bd a las etiquetas
				$obj_xtpl->assign("Codigo_Producto",$row['Codigo_Producto']);
				$obj_xtpl->assign("Nombre_Producto",$obj_generico->CleanTextDb($row['Nombre_Producto']));
				$obj_xtpl->parse('main.contenido.crear_solicitud.form_muestra.lista_productos');
			}
			
			$obj_xtpl->assign("numero",$i);
			$obj_xtpl->parse('main.contenido.crear_solicitud.form_muestra');	
			$i++;
		}
		$obj_xtpl->parse('main.contenido.crear_solicitud');
		break;
	
	
	
	//Guardar Solicitud
	case 'guardar_solicitud':
		$motivo=$_POST['motivoana'];	
		
		//Parametros recibidos por POST
		if(!$obj_generico->isEmpty($motivo)){
			//Funcion para obtener Id Cliente
			$id_cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());	
				
			//Verifica que existe la variable $id_cliente
			if($id_cliente){
				$Cod_Solicitud=$obj_modelo->GenerarCodigoSolicitud();
			
				$cantidad_muestra=$_POST['cantidad'];
				
				$id_solicitud=$obj_modelo->GuardarDatosSolicitud($fecha,$hora,$id_cliente,$Cod_Solicitud,$motivo,$cantidad_muestra);
				
				//Ahora una vez guarda el registro de la solicitud se procede a guardar las muestras
				for($i=1;$i<=$cantidad_muestra;$i++){
					$op_equipo=$_POST['op_equipo_'.$i];
					$productog=$_POST['producto_'.$i];
					$horakm=$_POST['horakm_'.$i];
					if($horakm==1){
						$horas_muestra=$_POST['txthorakm_'.$i];
						$km="---";
					}
					else{
						$horas_muestra="---";
						$km=$_POST['txthorakm_'.$i];
					}
					$Cod_Muestra= $obj_modelo->GeneraCodigoMuestra();
					$obj_modelo->GuardarDatosMuestra($id_solicitud,$op_equipo,$productog,$horas_muestra,$km,$Cod_Muestra);
					$muestras_solicitud[]= array("codigo_muestra"=>$Cod_Muestra, "tipo_muestra"=>$productog);
				}
				
				// Verifica que existan las muestras
				if( count($muestras_solicitud)>0 ){
					
					// Conexion a sigelab
					$obj_sigelab= new ClassWebService('usuario_portal');
					
					// Modelo para datos SIGELAB
					require($obj_config->GetVar('ruta_modelo').'ServicioWeb.php');
					$obj_modelo_sigelab= new ServicioWeb($obj_conexion,$obj_config->GetVar('esquema'));
				
					// Si devuelve el codigo de sigelab se almacenaria en la BD
					if($codigo_sigelab= $obj_sigelab->PreRegistroSolicitud($Cod_Solicitud,$motivo,$muestras_solicitud)){
						// Guarda en un arreglo las solicitudes almacenadas en la BD para su confirmacion
						if($obj_modelo_sigelab->ActualizaInfoSolicitud($codigo_sigelab,$id_solicitud)){
							$solicitudesPre[]= array("codigo_sigelab"=>$codigo_sigelab, "fecha"=>date("d/m/Y"));
							$solicitudesPre= array("solicitud"=>$solicitudesPre);
							
							// Aqui viene la Funcion para enviar el email de notificacion al transportista
							$transporte= $obj_generico->CleanTextDb( $obj_modelo->GetTransportista() );
							$cliente= $obj_generico->CleanTextDb( $obj_modelo->GetCliente($id_cliente) );
							
							$obj_correo->sendMailSolicitudHecha($cliente['Nombre_Cliente'], $cliente['Email'], $cliente['Direccion_Cliente'], $cliente['Telefono_Oficina_Cliente'], $transporte['Nombre_Empresa'], $transporte['Persona_Contacto'], $transporte['Email'],$cantidad_muestra,$Cod_Solicitud);
							
							// Aqui viene la Funcion para enviar el email de notificacion al Asesor Comercial							
							
							$asesor=$obj_modelo->GetEmailAsesor($cliente['Asesor_Comercial']);
							sleep(1); 
							$asd =@$obj_correo->sendMailSolicitudesRealizadasClientes($cantidad_muestra, $cliente['Nombre_Cliente'], $asesor['Email'], $asesor['Nombres_Apellidos']);
							
							// Confirma el pre-registro de la solicitud
							if(!$arreglo_codigos= $obj_sigelab->ConfirmarPreSolicitud($solicitudesPre)){
								// Preregistros confirmados
								$x='pc';
							}
							else{
								// Preregistros no confirmados
								$x='pnc';
							}
						}
					}
				}
				
				//para obtener las muestras_mensuales y muestras_realizadas 
				$cantidad= $obj_modelo->GetCantidadMuestras($id_cliente);
				
				//Asigna los valores
				$cant_realizadas=$cantidad['Muestras_Realizadas'];
				
				//Suma la cantidad de muestras realizadas
				$cantidad_muestra= $cantidad_muestra+$cant_realizadas;
				
				//Actualiza la Cantidad de Muestras realizadas
				$obj_modelo->ActualizaMuestrasRealizadas($cantidad_muestra, $id_cliente);
				
				// Para el historial
				/*
				$obj_historial->RegistrarEvento($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 16, $obj_conexion, $obj_config->GetVar('esquema'));
				*/
				
				$detalle=$Cod_Solicitud;
				// Para el historial
				$obj_historial->RegistrarEventoDetalle($_SESSION['InfoLogin']->GetCuenta(), $_SESSION['InfoLogin']->GetIP(), 16, $obj_conexion, $obj_config->GetVar('esquema'), $detalle);

				header('location:'. $_SESSION['Ruta_Lista'].'&accion=listo&solicitud='.$id_solicitud.'&x='.$x);
			}
			else{
				header('location:'. $_SESSION['Ruta_Lista']);
			}
		}
		else{
			$_SESSION['mensaje']= $mensajes['info_requerida'];
			header('location:'. $_SESSION['Ruta_Form']);
		}
		break;
	
	// Mensaje de confirmacion
	case 'listo':
		if($obj_generico->IsNumerico($_GET['solicitud'])){
			$obj_xtpl->assign('id_solicitud', $_GET['solicitud']);
			$obj_xtpl->parse('main.contenido.confirmacion');
		}
		else{
			header('Location:index.php');
		}
		break;
	
	
	//Redireccionar a la version a imprimir
	case 'version_imprimir':
		$id_solicitud=$_POST['id_solicitud'];
		
		//Redireccion
		header('location:index.php?op=listsol&accion=print&id='.$id_solicitud);
		break;


	default:
			// Ruta actual
			$_SESSION['Ruta_Lista']= $obj_generico->RutaRegreso();
			
			// Campos requeridos y formato del campo para el javascript
			$obj_xtpl->assign('campo_requerido', 'class="{required:true}"');
			
			//Para obtener el id del cliente		
			$id_cliente= $obj_modelo->GetIdCliente($_SESSION['InfoLogin']->GetCuenta());
			
			$solicitudes= $obj_modelo->GetSolicitudes($id_cliente);
			$row= $obj_conexion->GetArrayInfo($solicitudes);

			//Asignacion de la fecha de la ultima solicitud
			$fecha_ultima_sol= $row['Fecha'];
			
			//Asignacion de la fecha de hoy
			$fechahoy=$fecha;

			// Llamada de Metodo para comparar las fechas
			$comparacion= $obj_date->CompareDateLastSolicitudes($fecha_ultima_sol,$fechahoy);

			if($comparacion==0){
				//Actualiza la Cantidad de Muestras realizadas
				$obj_modelo->ActualizaMuestrasRealizadas(0, $id_cliente);
			}

			//para obtener las muestras_mensuales y muestras_realizadas 
			$cantidad= $obj_modelo->GetCantidadMuestras($id_cliente);
			
			//Asigna los valores
			$cant_mensuales=$cantidad['Muestras_Mensuales'];
			$cant_realizadas=$cantidad['Muestras_Realizadas'];

			//Calcula la diferencia y resuelve el numero de Muestras Disponibles
			$cant_muestras_disponibles= $cant_mensuales-$cant_realizadas;
			
			// Mes actual
			$obj_xtpl->assign('MES_ACTUAL', $obj_date->GetMes(date('n')) );
				
			// Si es un cliente y la cantidad de muestras disponibles es mayor a 0
			if($id_cliente && $cant_muestras_disponibles>0){
				//For para parsear el select donde pondra el numero de muestras
				for($i=1; $i<=$cant_muestras_disponibles; $i++){
					$obj_xtpl->assign('numero', $i);
					$obj_xtpl->parse('main.contenido.cantidad_muestra.cantidad_muestras');
				}
			
				$obj_xtpl->assign('MES_ACTUAL', $obj_date->GetMes(date('n')) );
				$obj_xtpl->assign('LIMITE_MUESTRAS', $cant_muestras_disponibles);
				$obj_xtpl->parse('main.contenido.cantidad_muestra.leyenda_cantidad_muestra');
				
				// Parseo del bloque
				$obj_xtpl->parse('main.contenido.cantidad_muestra');
			}
			elseif($id_cliente && $cant_muestras_disponibles==0){ // si llego al limite de muestras
				// Parseo del bloque
				$obj_xtpl->parse('main.contenido.no_disponible');
			}
			
			break;
}

// Parseo final del contenido
$obj_xtpl->parse('main.contenido');
?>