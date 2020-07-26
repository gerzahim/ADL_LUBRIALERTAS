<?php



	/**
	 * Objeto de la conexion.
	 *
	 * @access private
	 * @var object $vConexion
	 */
	private $vConexion="";
	
	/**
	 * Objeto de la conexion.
	 *
	 * @access private
	 * @var string $vEsquema
	 */
	private $vEsquema="";
	
	/**
	 * Constructor de la clase. Instancia.
	 *
	 * @access public
	 * @param object $conexion
	 * @param string $esquema
	 * @return void
	 */
	public function __construct($conexion="", $esquema='public') {
		$this->vConexion= $conexion;
		$this->vEsquema= $esquema;
	}
	
	/**
	 * Busqueda de todos los equipos.
	 *
	 * @access public
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param string $codigo
	 * @param string $tipo
	 * @param string $marca
	 * @param string $modelo
	 * @param integer $numero
	 * @param integer $cliente
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @param integer $search_cliente
	 * @param string $nombre
	 * @param boolean $exportar
	 * @return resource
	 */
	public function GetListado($cantidad, $pagina, $codigo=false, $tipo=false, $marca=false, $modelo=false, $numero=false, $cliente=false, $distribuidor=false, $asesor=false, $search_cliente=false, $nombre=false, $exportar=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		//$sql= ' SELECT E.* FROM "'.$this->vEsquema.'"."TR001_Equipo" E WHERE E."Eliminado"=0 ';
		$sql= ' 
			SELECT E.*, C."Nombre_Cliente" 
			FROM "'.$this->vEsquema.'"."TR001_Equipo" E 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (E."id_Cliente"=C."id_Cliente") 
			WHERE E."Eliminado"=0 
		';
		$parametros= array();
		
		// Deacuerdo a tipo de usuario
		if($cliente){
			$sql.= ' AND E."id_Cliente"=%? ';
			$parametros= array_merge($parametros, array($cliente) );
			$ordenamiento=true;
		}
		
		if($distribuidor){
			$sql.= ' AND C."Distribuidor"=%? ';
			$parametros= array($distribuidor);
		}
		
		if($asesor){
			$sql.= ' AND C."Asesor_Comercial"=%? ';
			$parametros= array($asesor);
		}
		
		// Para la busqueda
		if($codigo){
			$sql.= ' AND E."Codigo_Equipo" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$codigo.'%') );
		}
		
		if($tipo){
			$sql.= ' AND E."Tipo" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$tipo.'%') );
		}
		
		if($marca){
			$sql.= ' AND E."Marca" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$marca.'%') );
		}
		
		if($modelo){
			$sql.= ' AND E."Modelo" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$modelo.'%') );
		}
		
		if($numero){
			$sql.= ' AND E."Numero_Planta" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$numero.'%') );
		}
		
		if($search_cliente){
			$sql.= ' AND C."id_Cliente"=%? ';
			$parametros= array_merge($parametros, array($search_cliente) );
		}
		
		if($nombre){
			$sql.= ' AND E."Nombre_Equipo" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		// SQL final
		if($ordenamiento){
			$sql.= ' ORDER BY E."Codigo_Equipo"';
		}
		else{
			$sql.= ' ORDER BY C."Nombre_Cliente"';
		}
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
		if($exportar){
			return $result;
		}
		else{
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
			$result=  $this->vConexion->ExecuteQuery($sql, $parametros);
			
			return array('pagina'=>$pagina,'total_paginas'=>$total_paginas,'total_registros'=>$total_registros,'result'=>$result);
		}
	}
	
	/***
	 * Verifica si el numero de planta esta repetido.
	 * NO ESTA EN USO
	 *
	 * @access public
	 * @param string $email
	 * @param integer $id_referencia
	 * @return boolean
	 * /
	public function VerificaNumeroRepetido($numero, $id_referencia=""){
		$sql= 'SELECT "id_Equipo" FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "Numero_Planta" LIKE %?';
		$parametros= array($numero);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Equipo"<>%?';
			$parametros= array($numero, $id_referencia);
		}
		
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	*/
	
	/**
	 * Actualiza el equipo como eliminado.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($id_referencia){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Equipo" SET "Eliminado"=1 WHERE "id_Equipo"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_referencia));
	}
	
	/**
	 * Busca los datos del equipo.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosEquipo($id_referencia){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "id_Equipo"=%?';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de informacion del equipo.
	 *
	 * @access public
	 * @param string $codigo
	 * @param string $tipo
	 * @param string $marca
	 * @param integer $numero
	 * @param string $capacidad
	 * @param integer $cliente
	 * @param string $descripcion
	 * @param string $nombre
	 * @return boolean
	 */
	public function GuardarDatosEquipo($codigo,$tipo,$marca,$modelo,$numero,$capacidad,$cliente,$descripcion,$nombre){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Equipo" 
			("Tipo", "Marca", "Numero_Planta", "Eliminado","id_Cliente","Descripcion","Codigo_Equipo","Modelo", "Capacidad_Sistema", "Nombre_Equipo") 
			VALUES(%?,%?,%?,0,%?,%?,%?,%?,%?,%?)
		';
		
		return $this->vConexion->ExecuteQuery($sql, array($tipo,$marca,$numero,$cliente,$descripcion,$codigo,$modelo,$capacidad,$nombre) );
	}
	
	/**
	 * Actualiza la informacion del equipo.
	 *
	 * @access public
	 * @param integer $codigo
	 * @param string $tipo
	 * @param string $marca
	 * @param integer $numero
	 * @param string $capacidad
	 * @param string $descripcion
	 * @param integer $id
	 * @return boolean
	 */
	public function ActualizaDatosEquipo($codigo,$tipo,$marca,$modelo,$numero,$capacidad,$descripcion,$nombre,$id){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Equipo" 
			SET "Tipo"=%?, "Marca"=%?, "Numero_Planta"=%?, "Descripcion"=%?, "Codigo_Equipo"=%?, "Modelo"=%?, "Capacidad_Sistema"=%?, "Nombre_Equipo"=%? 
			WHERE "id_Equipo"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($tipo,$marca,$numero,$descripcion,$codigo,$modelo,$capacidad,$nombre,$id));
	}
	
	/**
	 * Busqueda del ID del cliente.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetIdCliente($id_referencia){
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cuenta_Acceso"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Cliente'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busqueda de todos los clientes no eliminados.
	 *
	 * @access public
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @return boolean or resource
	 */
	public function GetClientes($distribuidor=false,$asesor=false){
		$condicion= "";
		
		if($distribuidor){
			$condicion= ' AND C."Distribuidor"=%? ';
			$parametros= array($distribuidor);
		}
		
		if($asesor){
			$condicion= ' AND C."Asesor_Comercial"=%? ';
			$parametros= array($asesor);
		}
		
		$sql= '
			SELECT C."id_Cliente", C."Nombre_Cliente" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" C 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" CA ON (C."id_Cuenta_Acceso"=CA."id_Cuenta_Acceso") 
			WHERE CA."Cuenta_Eliminada"=0 '.$condicion.' 
			ORDER BY C."Nombre_Cliente"
		';
		return $this->vConexion->ExecuteQuery($sql,$parametros);
	}
	
	/**
	 * Busqueda del ID del distribuidor.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetIdDistribuidor($id_referencia){
		$sql= 'SELECT "id_Distribuidor" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "id_Cuenta_Acceso"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Distribuidor'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Obtiene el ID del Asesor.
	 *
	 * @access public
	 * @param integer $cuenta
	 * @return boolean|string
	 */
	public function GetIdAsesor($cuenta){
		$sql= 'SELECT "id_Personal" FROM "'.$this->vEsquema.'"."TR001_Personal" WHERE "id_Cuenta_Acceso"=%? AND "Cargo"=1';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($cuenta)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Personal'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Verifica si el codigo de equipo esta repetido.
	 *
	 * @access public
	 * @param string $codigo
	 * @param integer $cliente
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaCodigoRepetido($codigo, $cliente, $id_referencia=""){
		$sql= 'SELECT "id_Equipo" FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "Codigo_Equipo" LIKE %? AND "id_Cliente"=%?';
		$parametros= array($codigo,$cliente);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Equipo"<>%?';
			$parametros= array($codigo, $cliente, $id_referencia);
		}
		
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}

?>