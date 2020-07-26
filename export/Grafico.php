<?php

// Verifica q los datos enviados sean arreglos
/*
if( is_array($_GET['fe']) || is_array($_GET['sn']) || is_array($_GET['pb']) || is_array($_GET['cu']) || is_array($_GET['cu']) || is_array($_GET['na']) || is_array($_GET['si']) || is_array($_GET['f']) || is_array($_GET['al']) || is_array($_GET['cr']) ){
	*/
	include("../libraries/pChart/pData.class");
	include("../libraries/pChart/pChart.class");
	
	// Dataset definition 
	$DataSet = new pData;
	/*
	$DataSet->AddPoint(array(0,1,4,3,20,3,3),"Serie1");
	$DataSet->AddPoint(array(0,8,6,4,12,2,4),"Serie2");
	$DataSet->AddPoint(array(0,5,6,4,0,5,4),"Serie3");
	$DataSet->AddPoint(array(0,'01-10-2008','05-10-2008','10-10-2008','15-10-2008','20-10-2008','25-10-2008'),"SerieFecha");
	*/
	
	/*
	if($_GET['code']==1){
		$DataSet->AddPoint($_GET[$_GET['param']],ucfirst($_GET['param']));
	}
	else{
		$DataSet->AddPoint($_GET['al'],"Al");
		$DataSet->AddPoint($_GET['cr'],"Cr");
		$DataSet->AddPoint($_GET['cu'],"Cu");
		$DataSet->AddPoint($_GET['fe'],"Fe");
		$DataSet->AddPoint($_GET['pb'],"Pb");
		$DataSet->AddPoint($_GET['sn'],"Sn");
		$DataSet->AddPoint($_GET['si'],"Si");
		$DataSet->AddPoint($_GET['na'],"Na");
	}
	*/
	if(count($_GET['param'])>1){
		$DataSet->AddPoint($_GET[$_GET['param']],ucfirst($_GET['param']));
		$DataSet->AddPoint($_GET['f'],"SerieFecha");
	}
	else{
		$DataSet->AddPoint(0,ucfirst($_GET['param']));
		$DataSet->AddPoint($_GET[$_GET['param']],ucfirst($_GET['param']));
		$DataSet->AddPoint(0,"SerieFecha");
		$DataSet->AddPoint($_GET['f'],"SerieFecha");
	}
	
	$DataSet->AddAllSeries();
	$DataSet->RemoveSerie("SerieFecha");
	$DataSet->SetAbsciseLabelSerie("SerieFecha");
	$DataSet->SetXAxisName("Fechas");
	$DataSet->SetYAxisName("Valores");
	$DataSet->SetYAxisUnit($Unit="  ppm");
	/*
	http://localhost/adl/trunk/application/export/Grafico.php?code=1&param=visc40&f[]=18/12/2008&visc40[]=50%20&f[]=03/04/2009&visc40[]=46.53&f[]=06/04/2009&visc40[]=46.53
	
	$DataSet->SetSerieName("Fe","Serie1");
	$DataSet->SetSerieName("Sn","Serie2");
	$DataSet->SetSerieName("Pb","Serie3");
	$DataSet->SetSerieName("Cu","Serie4");
	$DataSet->SetSerieName("Na","Serie5");
	$DataSet->SetSerieName("Si","Serie6");
	*/
	/*
	// Initialise the graph
	$Test = new pChart(620,250);
	$Test->setFontProperties("../fonts/tahoma.ttf",7);
	$Test->setGraphArea(40,25,560,225);
	$Test->drawGraphArea(252,252,252,TRUE);
	$Test->drawScale($DataSet->GetData(),$DataSet->GetDataDescription(),SCALE_NORMAL,150,150,150,TRUE,0,2);
	$Test->drawGrid(4,TRUE,230,230,230,70);
	*/
	
	// Initialise the graph
	$Test = new pChart(620,250);
	$Test->drawGraphAreaGradient(142,163,182,40,TARGET_BACKGROUND);
	$Test->setFontProperties("../fonts/tahoma.ttf",7);
	//$Test->setGraphArea(50,30,560,225);
	$Test->setGraphArea(80,35,540,200);
	$Test->drawGraphArea(213,217,221,FALSE);
	$Test->drawScale($DataSet->GetData(),$DataSet->GetDataDescription(),SCALE_NORMAL,213,217,221,TRUE,0,2);
	$Test->drawGraphAreaGradient(162,183,202,50);
	$Test->drawGrid(4,TRUE,230,230,230,10);
	
	// Draw the line graph
	$Test->drawLineGraph($DataSet->GetData(),$DataSet->GetDataDescription());
	$Test->drawPlotGraph($DataSet->GetData(),$DataSet->GetDataDescription(),3,1,255,255,255);
	
	// Draw the legend
	$Test->setFontProperties("../fonts/tahoma.ttf",9);
	$Test->drawLegend(548,50,$DataSet->GetDataDescription(),236,238,240,52,58,82);
	
	// Finish the graph
	$Test->setFontProperties("../fonts/tahoma.ttf",10);
	//$Test->drawTitle(400,15,"Comportamiento del Equipo",0,0,0);
	$Test->drawTextBox(0,0,620,20,"Comportamiento del Equipo",0,255,255,255,ALIGN_RIGHT,TRUE,0,0,0,30);
	$Test->Stroke();
	//$Test->Render('../imagenes/example.png');
	/*
}
else{
	print("SIN GRAFICO");
}
*/
?>