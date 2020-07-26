<?php
$options= array("login"=>"suarezjcg","password"=>"suarezjcg");
$clientSigelab= new SoapClient("http://sislub-app-test.met.pdvsa.com/sinnu/server.php?wsdl",$options);
print_r( $clientSigelab->prueba('HOla') );
?>
