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
 

 
class ClassMail{

	//instanciamos un objeto de la clase phpmailer al que llamamos
	//include('/includes/class.phpmailer.php');
	
	
	/**
	 * Envio de datos de acceso a un usuario.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $email
	 * @param string $login
	 * @param string $clave
	 * @return void
	 */
	 
	public function sendMailUsuario($nombre,$email,$login,$clave){
		
		include('includes/class.phpmailer.php');
		
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
				Estimad@ '.$nombre.'
				Los datos de su cuenta de acceso al sistema LUBRIALERTAS son los siguientes:
			
				Usuario: '.$login.'
				Contraseña: '.$clave.'
		
				Recuerde cambiar la contraseña al ingresar al sistema, y le recomendamos que la cambie periodicamente.
			
			';
		
		//Indicamos cual es la dirección de destino del correo
		$mail->AddAddress($email);
		
		//Asignamos asunto y cuerpo del mensaje
		$mail->Subject = "Informacion Acceso";
		
		
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	    	//echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
			
	}
	
	/**
	 * Envio de datos de acceso indicando que se ha generado una nueva clave.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $email
	 * @param string $login
	 * @param string $clave
	 * @return void
	 */
	public function sendMailNuevaClave($nombre,$email,$login,$clave){
		
		include('includes/class.phpmailer.php');
		
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
			Estimad@ <b>'.$nombre.'
			
				Se ha generado una nueva contraseña de forma automatica para acceder al sistema!!<br/>
				Los datos de su cuenta de acceso al sistema LUBRIALERTAS son los siguientes:

				Usuario: '.$login.'<br/>
				Contraseña: '.$clave.'

			Recuerde cambiar la contraseña al ingresar al sistema, y le recomendamos que la cambie periodicamente.
			<br/>
		';
		
		//Indicamos cual es la dirección de destino del correo
		$mail->AddAddress($email);
		
		//Asignamos asunto y cuerpo del mensaje
		$mail->Subject = "Informacion Acceso - Nueva Clave";
		
		
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
	
	}

	/**
	 * Envio de datos de acceso indicando que ha cambiado de clave.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $email
	 * @param string $login
	 * @param string $clave
	 * @return void
	 */
	public function sendMailCambioClave($nombre,$email,$login,$clave){
				
		include('includes/class.phpmailer.php');
		
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
			Estimad@ '.$nombre.'
			
				Usted ha cambiado la contraseña de acceso al sistema !
				Los nuevos datos de su cuenta de acceso al sistema LUBRIALERTAS son los siguientes:
				Usuario: '.$login.'
				Contraseña: '.$clave.'
			   Recuerde cambiar la contraseña de acceso periodicamente.
		';
		
		//Indicamos cual es la dirección de destino del correo
		$mail->AddAddress($email);
		
		//Asignamos asunto y cuerpo del mensaje
		$mail->Subject = "Informacion Acceso - Cambio de Clave";
		
		
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}	
	}

	/**
	 * Envio de alerta indicando que ha sido recomendadas todas las muestras de una solicitud.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $email
	 * @param string $login
	 * @param string $clave
	 * @return void
	 */
	public function sendMailMuestrasListas($nombre,$email,$solicitud){
				
		include('includes/class.phpmailer.php');
			  	
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
			Estimad@ '.$nombre.'
			
				&nbsp;&nbsp;El sistema ha detectado que todas las muestras de la solicitud '.$solicitud.' han sido
				recomendadas, puede ingresar al sistema lubrialertas para verificar la informacion
				de las muestra(s) que pertenezcan a la solicitud.
			
		';
		
		//Indicamos cual es la dirección de destino del correo
		$mail->AddAddress($email);
		
		//Asignamos asunto y cuerpo del mensaje
		$mail->Subject = "Informacion Solicitudes - Solicitud Recomendada";
		
		
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
	}
	
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
	public function sendMailSolicitudHecha($cliente, $email_cliente, $direccion, $telefono, $transporte, $contacto, $email_transporte, $cantidad_muestras, $cod_sol){
				
		include('includes/class.phpmailer.php');
		
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
			Estimad@ '.$contacto.' de '.$transporte.'
				El cliente de DELTAVEN "'.$cliente.'" tiene una solicitud bajo el codigo "'.$cod_sol.'" cantidad de '.$cantidad_muestras.' muestras, para ser enviadas al laboratorio de INTEVEP.
				El cliente se encuentra ubicado en la siguiente dirección:
				'.$direccion.'
				Para cualquier otra información que necesite puede contactar a '.$cliente.' por medio de:
				Teléfono: '.$telefono.'
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
	
	}
	
	
	
	/**
	 * Envio de correo al asesor tecnico informando que de nuevas solicitudes por recomendar
	 *
	 * @access public
	 * @return void
	 */
	public function sendMailSolicitudesporRecomendar($email,$contacto){
					
		include('includes/class.phpmailer.php');
		
	  	$mail = new phpmailer();
  	
	
 		$mail->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$mail->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$mail->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$mail->SMTPAuth = true;
  		$mail->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$mail->Username = "lubrialertaspool@pdvsa.com"; 
  		$mail->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$mail->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$mail->FromName = "Lubrialertas";  
  
  		$mail->Timeout=30;
  

  		$mail->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$mail->Body.= '
			Estimad@ '.$contacto.' 
				El sistema Lubrialertas ha detectado que existen nuevos certificados emitidos por PDVLIMS/SIGELAB
				para los resultados pendientes por recomendacion.

			Muchas gracias por utilizar Lubrialertas
		';
		
		//Indicamos cual es la dirección de destino del correo
		$mail->AddAddress($email);
		
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
 
        
   	if(!$exito){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$mail->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
	}
	public function sendMailSolicitudesRealizadasClientes($cantidad_muestra, $cliente, $email, $contacto){
				
		  //include('includes/class.phpmailere.php');
		
	  	$correo = new phpmailer();
  	
 		  $correo->PluginDir = "";
  
  
	  	//Con la propiedad Mailer le indicamos que vamos a usar un 
	  	//servidor smtp
  		$correo->Mailer = "smtp";

  		//Asignamos a Host el nombre de nuestro servidor smtp
  		$correo->Host = "ccschucor01.pdvsa.com";
  
  		//Le indicamos que el servidor smtp requiere autenticación
  		$correo->SMTPAuth = true;
  		$correo->CharSet = "UTF-8";

  		//Le decimos cual es nuestro nombre de usuario y password
  		$correo->Username = "lubrialertaspool@pdvsa.com"; 
  		$correo->Password = "LUBRIALERTASPOOL";
  
  		//Indicamos cual es nuestra dirección de correo y el nombre que 
  		//queremos que vea el usuario que lee nuestro correo
  
  		$correo->From = "lubrialertaspool@pdvsa.com";
  
  	
  		$correo->FromName = "Lubrialertas";  
  
  		$correo->Timeout=30;
  

  		$correo->Body = '
			PDVSA - Lubrialertas
			Analisis de Lubricantes PDVSA
		';

	
		$correo->Body.= '
			Estimad@ '.$contacto.' 
				El cliente de DELTAVEN "'.$cliente.'" tiene una cantidad de '.$cantidad_muestras.' muestras, para ser enviadas al laboratorio de INTEVEP.
				
		';
		
		//Indicamos cual es la dirección de destino del correo
		$correo->AddAddress($email);
		
		//Asignamos asunto y cuerpo del mensaje
		$correo->Subject = "Solicitud de Analisis de Muestras del Cliente ".$cliente;
		
		
		//se envia el mensaje, si no ha habido problemas 
	  	//la variable $exito tendra el valor true
	  	
  	$exita = $correo->Send();

  		//Si el mensaje no ha podido ser enviado se realizaran 4 intentos mas como mucho 
  		//para intentar enviar el mensaje, cada intento se hara 5 segundos despues 
		//del anterior, para ello se usa la funcion sleep    
 
  		$intents=1; 
  		while ((!$exita) && ($intents < 5)) {
   	sleep(5);
         //echo $mail->ErrorInfo;
         $exita = $correo->Send();
         $intents=$intents+1;    
    
   	}    
 
        
   	if(!$exita){
    		//echo "Problemas enviando correo electrónico a ".$valor;
	   	echo "<br>".$correo->ErrorInfo;    
	   }
   	else{
   	 //echo "Mensaje enviado correctamente";
			}
		     	
	}
}
?>