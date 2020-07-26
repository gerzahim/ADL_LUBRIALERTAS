<?php
					
// Modelo para datos SIGELAB
require('ClassMail_phpMailer.php');
$cliente = array();	
$transporte = array();

$cliente['Nombre_Cliente'] = "Rasce Salas";
$cliente['Email'] = "johannasuarez@gmail.com"; 
$cliente['Direccion_Cliente'] ="Av. Francisco de Miranda, Urb. Los dos Caminos, Edif. Provincial Piso 5, ofic 5-A"; 
$cliente['Telefono_Oficina_Cliente'] ="0212-238-01-30"; 
$transporte['Nombre_Empresa'] ="Cooperativa Guatire-Gas"; 
$transporte['Persona_Contacto'] ="Diego Montiel"; 
$transporte['Email'] ="suarezjcg@pdvsa.com";
$cantidad_muestra =5;							


 						
sendMailSolicitudHecha($cliente['Nombre_Cliente'], $cliente['Email'], $cliente['Direccion_Cliente'], $cliente['Telefono_Oficina_Cliente'], $transporte['Nombre_Empresa'], $transporte['Persona_Contacto'], $transporte['Email'],$cantidad_muestra);
							
?>