<?php

$code= $_GET['code'];
$style= 164;
$width= 260;
$height= 70;
$xres= 1;
$font= 3;

define (__TRACE_ENABLED__, false);
define (__DEBUG_ENABLED__, false);

require("../libraries/code_barras/barcode.php");
require("../libraries/code_barras/c128bobject.php");

$obj = new C128BObject($width, $height, $style, $code);

if($obj){
	$obj->SetFont($font);
	$obj->DrawObject($xres);
	$obj->FlushObject();
	$obj->DestroyObject();
	unset($obj);  /* clean */
}
?>
