<?php

// Sesion e informacion del usuario conectado
include('./libraries/InfoLogin.php');
// Archivo de variables de configuracion
require_once('./config/config.php');
$obj_config= new  ConfigVars();

// Calculamos el tiempo transcurrido
$fechaGuardada= $_SESSION["UltimoAcceso"];
$ahora= date("Y-n-j H:i:s");
$tiempo_transcurrido= (strtotime($ahora) - strtotime($fechaGuardada));

/**
 * Se compara el tiempo transcurrido, si paso el tiempo de inactividad, o  no esta autentificado
 * cierra la sesion, de lo contrario actualiza el tiempo de la sesion y continua las operaciones.
 */
if($tiempo_transcurrido >= $obj_config->GetVar('tiempo_inactivo') || !isset($_SESSION['InfoLogin'])) {
	if(isset($_SESSION['InfoLogin'])){
		// Conexion a la bases de datos
		require($obj_config->GetVar('ruta_libreria').'Bd.php');
		$obj_conexion= new Bd();
		if( $obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db')) ){
			// Modelo asignado
			require($obj_config->GetVar('ruta_modelo').'LoginAcceso.php');
			$obj_modelo= new LoginAcceso($obj_conexion,$obj_config->GetVar('esquema'));
			
			// Coloca al usuario como desconectado
			if( $obj_modelo->ActualizaEstatusConectado($_SESSION['InfoLogin']->GetCuenta(),0) ){
				// Destruye la sesion
				unset($_SESSION['InfoLogin']);
				session_destroy();
	
				// Redireccionamiento
				header('location:login.php');
			}
		}
	}
	else{			
		// Redireccionamiento
		header('location:login.php');
	}
}

// Tiempo de la sesion actual
$_SESSION["UltimoAcceso"] = $ahora;

// Archivo de mensajes
require_once($obj_config->GetVar('ruta_config').'mensajes.php');

// Directorio de las librerias para la funcion "__autoload()"
define(DIR_LIBRERIA,$obj_config->GetVar('ruta_libreria'));

/**
 * LLamada automatica de los archivos de las clases a utilizar.
 *
 * @param string $className
 */
function __autoload($class_name) {
	require_once (DIR_LIBRERIA.$class_name.".php");
}

// Objetos de clases
$obj_xtpl = new XTemplate($obj_config->GetVar('ruta_vista')."main".$obj_config->GetVar('ext_vista'));
$obj_date= new Fecha();
$obj_historial= new Historial();
$obj_generico= new Generica();
$obj_correo= new ClassMail();

// Conexion a la bases de datos
$obj_conexion= new Bd();
if( !$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db')) ){
	$obj_xtpl->assign('mensaje_conexion',$mensajes['sin_conexion_bd']);
	$obj_xtpl->parse('main.conexion_fallida');
}

// Asignaciones
$obj_xtpl->assign('titulo_web',$obj_config->GetVar('titulo_sistema'));
$obj_xtpl->assign('fecha_hoy',$obj_date->FechaActual());
$obj_xtpl->assign('titulo_banner',$obj_config->GetVar('titulo_banner'));
$obj_xtpl->assign('pagina_principal',$obj_config->GetVar('index_page'));
$obj_xtpl->assign('nombre_usuario',$obj_generico->CleanTextDb($_SESSION['InfoLogin']->GetUsuario()));
$obj_xtpl->assign('mensaje',$_SESSION['mensaje']);
unset($_SESSION['mensaje']);

// Asignacion para mostrar el banner animado solo a clientes 
/*
if( isset($_SESSION['InfoLogin']) && ($_SESSION['InfoLogin']->GetTipo() == 'c' || $_SESSION['InfoLogin']->GetTipo() == 'd' )){
	// Parseo del banner animado
	$obj_xtpl->parse('main.banner_animado');
}*/


// Opcion del sistema
// Si es el primer acceso del usuario le aparece el formulario para el cambio de clave
if( $_SESSION['InfoLogin']->GetPrimerAcceso()==0 || $_REQUEST['op']=='close' ){
	define(OPCION,$_REQUEST['op']);
}
else{
	define(OPCION,'cuenta');
}
$obj_xtpl->assign('opcion_sistema',OPCION);

// Accion del sistema
define(ACCION,$_REQUEST['accion']);

// Header de la Pagina
include($obj_config->GetVar('ruta_controlador').'cHeader.php');

//  Menu del sistema
include($obj_config->GetVar('ruta_controlador').'cMenu.php');

// Contenido del sistema
switch(OPCION){
	case 'cliente':
		if(isset($_SESSION['cliente'])){
			include($obj_config->GetVar('ruta_controlador').'cCliente.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
	
	
	case 'close':
		include($obj_config->GetVar('ruta_controlador').'cLogoff.php');
		break;
		
		
	case 'cuenta':
		include($obj_config->GetVar('ruta_controlador').'cCuenta.php');
		break;
		
	
	case 'distribuidor':
		if(isset($_SESSION['distribuidor'])){
			include($obj_config->GetVar('ruta_controlador').'cDistribuidor.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
		
	case 'datsol':
		if(isset($_SESSION['datsol'])){
			include($obj_config->GetVar('ruta_controlador').'cReenvioSolicitud.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
	
	case 'equipo':
		if(isset($_SESSION['equipo'])){
			include($obj_config->GetVar('ruta_controlador').'cEquipo.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
	case 'perfil':
		if(isset($_SESSION['perfil'])){
			include($obj_config->GetVar('ruta_controlador').'cPerfil.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
		
	case 'personal':
		if(isset($_SESSION['personal'])){
			include($obj_config->GetVar('ruta_controlador').'cPersonal.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
		
	case 'producto':
		if(isset($_SESSION['producto'])){
			include($obj_config->GetVar('ruta_controlador').'cProducto.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
	
	case 'resultado':
		if(isset($_SESSION['resultado'])){
			include($obj_config->GetVar('ruta_controlador').'cBuscaCertificados.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
	
	case 'reporte':
		if(isset($_SESSION['reporte'])){
			include($obj_config->GetVar('ruta_controlador').'cReporte.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
	
	
	case 'solicitud':
		if(isset($_SESSION['solicitud'])){
			include($obj_config->GetVar('ruta_controlador').'cSolicitud.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
	case 'resultsol':
		if(isset($_SESSION['resultsol'])){
			include($obj_config->GetVar('ruta_controlador').'cResultSolicitud.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;		
	
	case 'transporte':
		if(isset($_SESSION['transporte'])){
			include($obj_config->GetVar('ruta_controlador').'cTransporte.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
	case 'listsol':
		if(isset($_SESSION['listsol'])){
			include($obj_config->GetVar('ruta_controlador').'cListaSolicitud.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;		
		
		
	case 'agrecoment':
		if(isset($_SESSION['agrecoment'])){
			include($obj_config->GetVar('ruta_controlador').'cRecomendacion.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
		
	case 'auditoria':
		if(isset($_SESSION['auditoria'])){	
			include($obj_config->GetVar('ruta_controlador').'cAuditoria.php');
		}
		else{
			header('location:'.$obj_config->GetVar('index_page'));
		}
		break;
		
		
	default:
		include($obj_config->GetVar('ruta_controlador').'cHome.php');
		break;
}

// Pie de Pagina
$obj_xtpl->assign_file('BOTTOM', $obj_config->GetVar('ruta_vista').'bottom'.$obj_config->GetVar('ext_vista'));

// Parseo  final del  documento
$obj_xtpl->parse('main');
$obj_xtpl->out('main');
?>
