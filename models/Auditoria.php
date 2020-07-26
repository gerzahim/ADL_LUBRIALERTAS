<?php
class Auditoria{

	/**
	 * Objeto de la conexion.
	 *
	 * @var object $vConexion
	 */
	private $vConexion="";
	
	/**
	 * Objeto de la conexion.
	 *
	 * @var string $vEsquema
	 */
	private $vEsquema="";
	
	/**
	 * Constructor de la clase. Instancia.
	 *
	 * @param object $conexion
	 */
	public function __construct($conexion="", $esquema='public') {
		$this->vConexion= $conexion;
		$this->vEsquema= $esquema;
	}

	public function GetAuditoria($cantidad, $pagina, $id_cuenta_acceso="", $fechainicial="", $fechafinal=""){

		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Historial" WHERE "id_Historial"<>0
		';
		
		$parametro= array();
		
		if(!empty($fechainicial)){
			$sql.=' AND "Fecha">=%?';
			$parametro= array_merge($parametro, array($fechainicial) );
		}
		
		if(!empty($fechafinal)){
			$sql.=' AND "Fecha"<=%?';
			$parametro= array_merge($parametro, array($fechafinal) );
		}
		
		if(!empty($id_cuenta_acceso)){
			$sql.=' AND "id_Cuenta_Acceso"=%?';
			$parametro= array_merge($parametro, array($id_cuenta_acceso) );
		}
		
		$result= $this->vConexion->ExecuteQuery($sql,$parametro);
		
		// Datos para la paginacion
		$total_registros= $this->vConexion->GetNumberRows($result);
		if($cantidad!=0){
			$total_paginas= ceil($total_registros / $cantidad);
		}
		else{
			$total_paginas= 0;
		}
		
		// Nuevo SQL
		$sql.=" LIMIT ".$cantidad." OFFSET ".$inicial."";
		$result=  $this->vConexion->ExecuteQuery($sql,$parametro);
		
		return array('pagina'=>$pagina,'total_paginas'=>$total_paginas,'total_registros'=>$total_registros,'result'=>$result);
	}

	public function GetAccion($id_accion){
		$sql= '
			SELECT "Tipo_Accion"
			FROM "'.$this->vEsquema.'"."TR001_Accion"
			WHERE "id_Accion"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_accion));
	  	$row= $this->vConexion->GetArrayInfo($result);
		return $row['Tipo_Accion'];
	}
	
	public function GetActor($id_Cuenta_Acceso){
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso"
			WHERE "id_Cuenta_Acceso"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Cuenta_Acceso));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['Nombre'];
	}
	
	public function GetPersonal(){
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Personal"
		';
		return $this->vConexion->ExecuteQuery($sql);
	}

	public function GetDistribuidor(){
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Distribuidores"
		';
		return $this->vConexion->ExecuteQuery($sql);
	}
	
	public function GetTransportista(){
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte"
		';
		return $this->vConexion->ExecuteQuery($sql);
	}

	public function GetCliente(){
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Cliente"
		';
		return $this->vConexion->ExecuteQuery($sql);
	}		

	public function GetPersonalAvanzado($id_nombre){
		$sql= '
			SELECT "id_Cuenta_Acceso"
			FROM "'.$this->vEsquema.'"."TR001_Personal"
			WHERE "id_Personal"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_nombre));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cuenta_Acceso'];
	}		

	public function GetClienteAvanzado($id_nombre){
		$sql= '
			SELECT "id_Cuenta_Acceso"
			FROM "'.$this->vEsquema.'"."TR001_Cliente"
			WHERE "id_Cliente"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_nombre));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cuenta_Acceso'];
	}
	
	public function GetTransportistaAvanzado($id_nombre){
		$sql= '
			SELECT "id_Cuenta_Acceso"
			FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte"
			WHERE "id_Empresa_Transporte"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_nombre));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cuenta_Acceso'];
	}

	public function GetDistribuidorAvanzado($id_nombre){
		$sql= '
			SELECT "id_Cuenta_Acceso"
			FROM "'.$this->vEsquema.'"."TR001_Distribuidores"
			WHERE "id_Distribuidores"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_nombre));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cuenta_Acceso'];
	}
	
	public function GetAuditoriaExportar($id_cuenta_acceso="", $fechainicial="", $fechafinal=""){
	
		$sql= '
			SELECT *
			FROM "'.$this->vEsquema.'"."TR001_Historial" WHERE "id_Historial"<>0
		';
		
		$parametro= array();
		
		if(!empty($fechainicial)){
			$sql.=' AND "Fecha">=%?';
			$parametro= array_merge($parametro, array($fechainicial) );
		}
		
		if(!empty($fechafinal)){
			$sql.=' AND "Fecha"<=%?';
			$parametro= array_merge($parametro, array($fechafinal) );
		}
		
		if(!empty($id_cuenta_acceso)){
			$sql.=' AND "id_Cuenta_Acceso"=%?';
			$parametro= array_merge($parametro, array($id_cuenta_acceso) );
		}
		
		return $this->vConexion->ExecuteQuery($sql,$parametro);
		
	}
	
}
?>