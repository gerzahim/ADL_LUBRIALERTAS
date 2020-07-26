<?php

include_once('libraries/nusoap.php');
$client = new soap_cliente("http://sislub-app-test.met.pdvsa.com/connup/server.php");

function pruebax($nombre){
	global $client;
	if( $data= $client->call("prueba",array($nombre),"http://sislub-app-test.met.pdvsa.com") ){
		return $data;
	}
	else{
		return "Sin Informacion";
	}
}

if(!$client->fault){
	if ( !$err= $client->getError() ){
		echo '<h2>Result</h2><pre>'; print_r(pruebax("Pedro Perez")); echo '</pre>';
	}
	else{
		echo '<h2>Error</h2><pre>'.$err.'</pre>';
	}
}
else {
}

echo '<h2>Request</h2><pre>' . htmlspecialchars($client->request, ENT_QUOTES) . '</pre>';
echo '<h2>Response</h2><pre>' . htmlspecialchars($client->response, ENT_QUOTES) . '</pre>';
echo '<h2>Debug</h2><pre>' . htmlspecialchars($client->debug_str, ENT_QUOTES) . '</pre>';

unset($client);

?>
