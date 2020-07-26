<?php

// Archivo de variables de configuracion
require_once('../config/config.php');
$obj_config= new  ConfigVars();

// Clase Fecha
require('.'.$obj_config->GetVar('ruta_libreria').'Fecha.php');
$obj_date= new Fecha();

// Clase Generica
require('.'.$obj_config->GetVar('ruta_libreria').'Generica.php');
$obj_generico= new Generica();

// Conexion a la bases de datos
require('.'.$obj_config->GetVar('ruta_libreria').'Bd.php');
$obj_conexion= new Bd();
$obj_conexion->ConnectDataBase($obj_config->GetVar('host'), $obj_config->GetVar('port'),$obj_config->GetVar('data_base'), $obj_config->GetVar('usuario_db'), $obj_config->GetVar('clave_db'));

// Modelo asignado
require('.'.$obj_config->GetVar('ruta_modelo').'Auditoria.php');
$obj_modelo= new Auditoria($obj_conexion,$obj_config->GetVar('esquema'));


$cargo = $_GET['cargo'];
$id_nombre = $_GET['id_nombre'];	
$fechainicial = $_GET['date1'];
$fechafinal = $_GET['date2'];

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
$auditoria = $obj_modelo->GetAuditoriaExportar($id_cuenta_acceso, $fechainicial, $fechafinal);

// Busca e imprime los valores de la Tabla TR001_Historial
$i=1;

$filecontent=str_pad("Id_Evento", 10)."\t\t";
$filecontent.=str_pad("IP", 15)."\t\t";
$filecontent.=str_pad("Persona", 60)."\t\t";
$filecontent.=str_pad("Fecha", 10)."\t\t";
$filecontent.=str_pad("Hora", 8)."\t\t";
$filecontent.="Evento \t\t";
$filecontent.="Detalle \n";

$filecontent.= str_pad("=", 100,"=")."\n";
while($row= $obj_conexion->GetArrayInfo($auditoria)){
	$filecontent.=str_pad($row['id_Historial'], 10)."\t\t";
	$filecontent.=str_pad($row['IP'], 15)."\t\t";
	$filecontent.=str_pad($obj_generico->CleanTextDb($obj_modelo->GetActor($row['id_Cuenta_Acceso'])), 60)."\t\t";
	$filecontent.=$row['Fecha']."\t\t";
	$filecontent.=$row['Hora']."\t\t";	
	$filecontent.=$obj_modelo->GetAccion($row['id_Accion'])."\t";
	$filecontent.=$row['detalle_accion']."\t\t";	
	$filecontent.="\n";		
	$i++;
}

header ("Content-Disposition: attachment; filename=\"reporte_auditoria.txt\"" ); 
header("Content-Type: application/force-download");
header("Content-Transfer-Encoding: binary");
header("Content-Length: ".strlen($filecontent));
header("Pragma: no-cache");
header("Expires: 0");
echo $filecontent;


?>