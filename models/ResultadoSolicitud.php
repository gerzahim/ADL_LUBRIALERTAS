<?php
class ResultadoSolicitud{

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
		$this->IdMuestra_Al=1039;
	}
	
	
	
	/**
	 * Listado.
	 *
	 * @access public
	 * @param integer $cantidad
	 * @param integer $pagina
	 * @param string $tipo_usuario
	 * @param integer $id
	 * @return array
	 */
	public function GetSolicitudes($cantidad, $pagina, $tipo_usuario="", $id=""){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		$parametro= array();		
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"<>0 AND "Status_Solicitud">5';
		
		if($tipo_usuario=='c'){
			$sql.='AND "id_Cliente"=%?';
			$parametro= array_merge($parametro, array($id));
		}
		
		if($tipo_usuario=='d'){
			$sql= '
				SELECT S.* 
				FROM "'.$this->vEsquema.'"."TR001_Solicitud" S
				INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (C."id_Cliente"=S."id_Cliente") 
				WHERE S."Status_Solicitud">5 AND C."Distribuidor"=%? 
			';
			
			$parametro= array_merge($parametro, array($id));
		}
		
		//para que lo ordene de forma descendente
		$sql.= 'ORDER BY "Fecha" DESC ';
		
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
	
	/**
	 * Devuelve el nombre del cliente segun el id.
	 *
	 * @access public
	 * @param integer $id_Cliente
	 * @return string
	 */
	public function GetNombreCliente($id_Cliente){
		$sql= '
			SELECT "Nombre_Cliente"
			FROM "'.$this->vEsquema.'"."TR001_Cliente"
			WHERE "id_Cliente"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Cliente));
	  	$row= $this->vConexion->GetArrayInfo($result);
		return $row['Nombre_Cliente'];
	}
	
	/**
	 * Metodo para Obtener el numero asociado al statu de la Solicitud
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return array
	 */
	public function GetStatuSolicitud($id_Solicitud){
		$sql= '
			SELECT "Status_Solicitud", "Cod_Solicitud", "Fecha", "fecha_transporte", "fecha_registro", "fecha_final", "fecha_certificado" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" 
			WHERE "id_Solicitud"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row; //Aqui se esta enviando el array
	}
	
	/**
	 * Para obtener todos los valores de los posibles status en la tabla TR001_Status
	 *
	 * @access public
	 * @return resource
	 */
	public function GetAllStatus(){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Status" ORDER BY "id_Status"';
		return $this->vConexion->ExecuteQuery($sql);
	}
	
	/**
	 * Actualiza el status de la solicitud de 1 a 2 es decir actualiza la solicitud a "entregada a transportista"
	 * y guarda la fecha en que lo realizo.
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @param date $fecha
	 * @return resource
	 */
	public function ActualizaEntregaTransporte($id_Solicitud,$fecha){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" 
			SET "Status_Solicitud"=2, "fecha_transporte"=%? 
			WHERE "id_Solicitud"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($fecha,$id_Solicitud));
	}
	
	/**
	 * Obtiene el id del cliente
	 *
	 * @access public
	 * @param integer $id_cuenta_acceso
	 * @return integer
	 */
	public function GetIdCliente($id_cuenta_acceso){
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cuenta_Acceso"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_cuenta_acceso));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cliente'];
	}
	
	/**
	 * Obtiene el id del distribuidor
	 *
	 * @access public
	 * @param integer $id_cuenta_acceso
	 * @return integer
	 */
	public function GetIdDistribuidor($id_cuenta_acceso){
		$sql= 'SELECT "id_Distribuidor" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "id_Cuenta_Acceso"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_cuenta_acceso));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Distribuidor'];
	}

	/**
	 * Metodo para Obtener la muestras segun la Solicitud
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return resource
	 */
	public function GetMuestras($id_Solicitud){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Solicitud"=%? ';
		$sql.= 'ORDER BY "id_Muestra" ASC ';
		return $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
	}
	
	/**
	 * Metodo para obtener los datos del equipo atraves del id
	 *
	 * @access public
	 * @param integer $id_Equipo
	 * @return array
	 */
	public function GetNombreEquipo($id_Equipo){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "id_Equipo"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Equipo));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row;
	}
	
	/**
	 * Funcion para traerme el Codigo de la Solicitud segun el Id
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return string
	 */
	public function GetCodSolicitud($id_Solicitud){
		$sql= ' SELECT "Cod_Solicitud" FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Cod_Solicitud'];
	}
	
	/**
	 * Metodo para Obtener la muestras segun el id de la muestra
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource
	 */
	public function GetMuestrasaRecomendar($id_Muestra){
		$sql= ' SELECT * FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Muestra"=%?';
		return $result= $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
	}
	
	/**
	 * Metodo para Obtener el nombre del equipo a traves del numero asociado tabla de Equipos
	 *
	 * @access public
	 * @param integer $id_Equipo
	 * @return array
	 */
	public function GetNombreEquipoRecomendacion($id_Equipo){
		$sql= ' SELECT * FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "id_Equipo"=%?  ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Equipo));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row;
	}

	/**
	 * Metodo para Obtener la muestras que ya cargaron los parametros pero no han sido recomendadas
	 *
	 * @access public
	 * @param integer $cantidad
	 * @param integer $pagina
	 * @return array
	 */
	public function GetMuestrasRecomendadas($cantidad, $pagina){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "Carga_Parametros"=1 AND "Status_Muestra"=0 ';
		$result= $this->vConexion->ExecuteQuery($sql);
		
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
	
	/**
	 * Metodo para Obtener valores de la tabla Parametros
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource
	 */
	public function ObtenerParametros($id_Muestra){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Parametros" WHERE "id_Muestra"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
	}
	
	
	/**
	 * Verifica si el equipo ya ha tenido muestras anteriormente
	 *
	 * @access public
	 * @param integer $equipo
	 * @return boolean
	 */
	public function VerificaComportamiento($equipo){
		$sql= '
			SELECT P."id_Parametros" 
			FROM "'.$this->vEsquema.'"."TR001_Parametros" P 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (P."id_Muestra"=M."id_Muestra") 
			WHERE M."id_Equipo"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($equipo));
		if($this->vConexion->GetNumberRows($result) > 1){
			return true;
		}
		else{
			return false;
		}
	}
	
	
	/**
	 * Metodo para modificar la recomendacion dada por el Analista
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @param string $txtrecomendacion
	 * @return resource
	 */
	public function ModificarRecomendacion($id_Muestra,$txtrecomendacion){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Muestra" SET "Recomendacion"=%? WHERE "id_Muestra"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($txtrecomendacion,$id_Muestra));
	}
	
	/**
	 * Funcion para traerme el Codigo de la Muestra segun el id de la muestra
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return string
	 */
	public function GetCodMuestra($id_Muestra){
		$sql= ' SELECT "Cod_Muestra" FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Muestra"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Cod_Muestra'];
	}
	
	/**
	 * Funcion para obtener el numero de certificado segun el codigo de la muestra
	 *
	 * @access public
	 * @param integer $codigom	/**
	 * Devuelve el nombre del cliente segun el id.
	 * @return string
	 */
	
	public function ObtenerCertificado($codigom){
		$sql= ' SELECT "id_certificado" FROM "'.$this->vEsquema.'"."TR001_Certificado" WHERE "cod_muestra_lubrialerta"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($codigom));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['id_certificado'];
	}
	
	/**
	 * Metodo para Obtener valores de la tabla Resultados
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource
	 */
	public function ObtenerMetodo_Certificado($idcertificado){
		$sql= 'SELECT "id_metodo" FROM "'.$this->vEsquema.'"."TR001_Metodo" WHERE "id_certificado"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($idcertificado));
	} 
	
	/**
	 * Metodo para Obtener valores de la tabla Resultados
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource 
	 */
	
	public function ObtenerResultados($metodo){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Resultado" WHERE "id_metodo"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($metodo));
	}
	
	/**
	 * Devuelve el nombre y el id del cliente
	 *
	 * @access public
	 * @param integer $id_Cliente
	 * @return string  
	 */
	 
	public function ObtenerClientes(){
		$sql= '
			SELECT "Nombre_Cliente", "id_Cliente"
			FROM "'.$this->vEsquema.'"."TR001_Cliente"
		';
		
		$result= $this->vConexion->ExecuteQuery($sql);
	  	return $result;  
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
	
	/**
	 * Funcion para traerme el Id del cliente de la tabla Solicitud segun el Id
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return string
	 */
	public function GetIdClienteFromTablaSolicitud($id_Solicitud){
		$sql= ' SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['id_Cliente'];
	}
	/**
	 * Devuelve datos del cliente segun el id.
	 *
	 * @access public
	 * @param integer $id_Cliente
	 * @return string
	 */
	public function GetDatosCliente($id_Cliente){
		$sql= '
			SELECT "Nombre_Cliente", "Direccion_Cliente", "Email"
			FROM "'.$this->vEsquema.'"."TR001_Cliente"
			WHERE "id_Cliente"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Cliente));
	  	$row= $this->vConexion->GetArrayInfo($result);
		return $row;
	}
	/**
	 * Funcion para traerme el numero de certificado del cliente de la tabla Solicitud segun el Id
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return string
	 */
	public function GetCodigoSigelabFromTablaSolicitud($id_Solicitud){
		$sql= ' SELECT "codigo_sigelab" FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['codigo_sigelab'];
	}
	/**
	 * Metodo para Obtener el nombre de la persona que recomienda segun su id de cuenta de acceso asociado tabla de Equipos
	 *
	 * @access public
	 * @param integer $id_Equipo
	 * @return array
	 */
	public function GetNombreCuentaAcceso($id_CuentaAcceso){
		$sql= ' SELECT "Nombre" FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" WHERE "id_Cuenta_Acceso"=%?  ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_CuentaAcceso));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Nombre'];
	}
	/**
	 * Funcion para traerme el Codigo de la Muestra segun el id de la muestra
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return string
	 */
	public function GetIdCuentaAccesoFromMuestra($id_Muestra){
		$sql= ' SELECT "id_Cuenta_Acceso" FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Muestra"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['id_Cuenta_Acceso'];
	}		
  	/**
	 * Funcion para traerme el numero de informe del certificado de la tabla Certificado segun el Id del certificado
	 *
	 * @access public
	 * @param integer $id_certificado
	 * @return string
	 */
	 	public function ObtenerNumeroInforme($id_certificado){
		$sql= ' SELECT "numero_informe" FROM "'.$this->vEsquema.'"."TR001_Certificado" WHERE "id_certificado"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_certificado));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['numero_informe'];
	}
			
}
?>