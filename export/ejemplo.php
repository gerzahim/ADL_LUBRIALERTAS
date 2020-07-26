<?
  // primero hay que incluir la clase phpmailer para poder instanciar
  //un objeto de la misma
  require "includes/class.phpmailer.php";

  //instanciamos un objeto de la clase phpmailer al que llamamos 
  //por ejemplo mail
  $mail = new phpmailer();
	$nombre="Gerzahim";
	$clave="12345";
	$login="gsalas";
  //Definimos las propiedades y llamamos a los m�todos 
  //correspondientes del objeto mail

  //Con PluginDir le indicamos a la clase phpmailer donde se 
  //encuentra la clase smtp que como he comentado al principio de 
  //este ejemplo va a estar en el subdirectorio includes
  $mail->PluginDir = "includes/";

  //Con la propiedad Mailer le indicamos que vamos a usar un 
  //servidor smtp
  $mail->Mailer = "smtp";

  //Asignamos a Host el nombre de nuestro servidor smtp
  $mail->Host = "smtp.mail.yahoo.ca";

  //Le indicamos que el servidor smtp requiere autenticaci�n
  $mail->SMTPAuth = true;
  $mail->CharSet = "UTF-8";

  //Le decimos cual es nuestro nombre de usuario y password
  $mail->Username = "rasce.salas@yahoo.ca"; 
  $mail->Password = "hermoine7";

  //Indicamos cual es nuestra direcci�n de correo y el nombre que 
  //queremos que vea el usuario que lee nuestro correo
  $mail->From = "rasce.salas@yahoo.es";
  $mail->FromName = "-Lubrialertas-";

  //el valor por defecto 10 de Timeout es un poco escaso dado que voy a usar 
  //una cuenta gratuita, por tanto lo pongo a 30  
  $mail->Timeout=30;

  //Indicamos cual es la direcci�n de destino del correo
  //$mail->AddAddress("rasce.salas@yahoo.es");
  $mail->AddAddress("rasce88@gmail.com");

  //Asignamos asunto y cuerpo del mensaje
  //El cuerpo del mensaje lo ponemos en formato html, haciendo 
  //que se vea en negrita
  $mail->Subject = "Notificacion de Solicitud Lubrialertas";
  $text = $clave;
  $mail->Body.= '
		Estimad@ '.$nombre.'
		Los datos de su cuenta de acceso al sistema LUBRIALERTAS son los siguientes:
	
		Usuario: '.$login.'
		Contraseña: Corresponde a la imagen
				Recuerde cambiar la contraseña al ingresar al sistema, y le recomendamos que la cambie periódicamente.
	
	';
	require 'generar_image.php'; 
  //Definimos AltBody por si el destinatario del correo no admite email con formato html 
  //$mail->AltBody = "Mensaje de prueba mandado con phpmailer en formato solo texto";

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
    echo "Problemas enviando correo electr�nico a ".$valor;
    echo "<br>".$mail->ErrorInfo;    
   }
   else
   {
    echo "Mensaje enviado correctamente";
   } 
?> 
