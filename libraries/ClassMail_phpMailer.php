<?php
/**
 * ClassMail - Manejo de informacion para el envio de correos.
 *
 * Copyright (C) 2008  José Luis Carpio E.
 * This program is free software: you can redistribute it and/or modify 
 * it under the terms of the GNU General Public License as published by 
 * the Free Software Foundation, either version 3 of the License, or 
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 
 /**
 * ClassMail - Manejo de informacion para el envio de correos.
 *
 * @package ClassMail
 * @author José Luis Carpio E.
 * @copyright 2008 José Luis Carpio E.
 * @created May 2008
 * @contact jlcarpioe@gmail.com
 * @since PHP 5
 * @version 1.0
 * @see license.txt GNU General Public License
 * Please give credit on sites that use this program and submit changes of 
 * the script so other people can use them as well. This script is free 
 * to use, don't abuse.
 */
 

///////////////////////////////////
// Recuerda Agregar la clase Class mail
////////////////////////////////////




// Modelo para datos SIGELAB
	
  require "includes/class.phpmailer.php";
 
  //instanciamos un objeto de la clase phpmailer al que llamamos 

  
	/**
	 * Envio de correo al transportista informando que se ha realizado una solicitud.
	 *
	 * @access public
	 * @param string $cliente
	 * @param string $email_cliente
	 * @param string $direccion
	 * @param string $direccion
	 * @param string $telefono
	 * @param string $transporte
	 * @param string $contacto
	 * @param string $email_transporte
	 * @param integer $cantidad_muestras
	 * @return void
	 */
	 
	 
  function sendMailSolicitudHecha($cliente, $email_cliente, $direccion, $telefono, $transporte, $contacto, $email_transporte, $cantidad_muestras){
		
		
		  
  	$mail = new phpmailer();
  	
  	
	
 	$mail->PluginDir = "includes/";
  
  
  	//Con la propiedad Mailer le indicamos que vamos a usar un 
  	//servidor smtp
  	$mail->Mailer = "smtp";

  	//Asignamos a Host el nombre de nuestro servidor smtp
  	$mail->Host = "ccschucor01.pdvsa.com";
  
  	//Le indicamos que el servidor smtp requiere autenticación
  	$mail->SMTPAuth = true;

  	//Le decimos cual es nuestro nombre de usuario y password
  	$mail->Username = "lubrialertaspool@pdvsa.com"; 
  	$mail->Password = "LUBRIALERTASPOOL";
  
  	//Indicamos cual es nuestra dirección de correo y el nombre que 
  	//queremos que vea el usuario que lee nuestro correo
  
  	$mail->From = "lubrialertaspool@pdvsa.com";
  
  	////////////////////////////////////////////////////
  	$mail->FromName = "Lubrialertas";  
  
  	$mail->Timeout=30;
  

  	$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';


  	//Definimos AltBody por si el destinatario del correo no admite email con formato html 
  	//$mail->AltBody = "Mensaje de prueba mandado con phpmailer en formato solo texto";
		
		
	$mail->Body.= '
			Estimad@ '.$contacto.' de '.$transporte.'
			
			El cliente de DELTAVEN "'.$cliente.'" tiene una cantidad de '.$cantidad_muestras.' muestras, para ser enviadas al laboratorio de INTEVEP.
			
			El cliente se encuentra ubicado en la siguiente dirección:
			
			'.$direccion.'
			
			Para cualquier otra información que necesite puede contactar a '.$cliente.' por medio de:
			'.$telefono.'
			Email:'.$email_cliente.'
			
		';
		
	//Indicamos cual es la dirección de destino del correo
	$mail->AddAddress($email_transporte);
		
	//Asignamos asunto y cuerpo del mensaje
	$mail->Subject = "Muestras Deltaven Para Envio de ".$cliente;
		
		
	//se envia el mensaje, si no ha habido problemas 
  	//la variable $exito tendra el valor true
  	$exito = $mail->Send();

  	//Si el mensaje no ha podido ser enviado se realizaran 4 intentos mas como mucho 
  	//para intentar enviar el mensaje, cada intento se hara 5 segundos despues 
	//del anterior, para ello se usa la funcion sleep    
 
  	$intentos=1; 
  	while ((!$exito) && ($intentos < 5)) {
   sleep(5);
         //echo $mail->ErrorInfo;
         $exito = $mail->Send();
         $intentos=$intentos+1;    
    
   }
 
        
   if(!$exito)
   {
    //echo "Problemas enviando correo electrónico a ".$valor;
    //echo "<br>".$mail->ErrorInfo;    
   }
   else
   {
    //echo "Mensaje enviado correctamente";
   }
	
}
	
	

?>