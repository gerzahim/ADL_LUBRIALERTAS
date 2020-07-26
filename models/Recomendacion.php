<?php
class Recomendacion{

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
	 * Metodo para Obtener la muestras que ya cargaron los parametros pero no han sido recomendadas
	 *
	 * @access public
	 * @param integer $cantidad
	 * @param integer $pagina
	 * @return array
	 */
	public function GetMuestrasporRecomendar($cantidad, $pagina){

		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT * 
			FROM "'.$this->vEsquema.'"."TR001_Muestra" 
			WHERE "Carga_Parametros"=1 AND "Status_Muestra"=0 
			ORDER BY "id_Muestra"
		';
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
		$sql.=" LIMIT ".$cantidad." OFFSET ".$inicial;
		$result=  $this->vConexion->ExecuteQuery($sql,$parametro);
		
		return array('pagina'=>$pagina,'total_paginas'=>$total_paginas,'total_registros'=>$total_registros,'result'=>$result);
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
	 * Metodo para Obtener la muestras segun el id de la muestra
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource
	 */
	public function GetMuestrasaRecomendar($id_Muestra){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Muestra"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
	}

	/**
	 * Metodo para registrar la recomendacion dada por el Analista
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @param string $txtrecomendacion
	 * @return resource
	 */
	public function RegistrarRecomendacion($id_Muestra,$txtrecomendacion,$id_cuenta_acceso){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Muestra" SET "Recomendacion"=%?, "id_Cuenta_Acceso"=%?, "Status_Muestra"=1 WHERE "id_Muestra"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($txtrecomendacion,$id_cuenta_acceso,$id_Muestra));
	}	
	
	/**
	 * Metodo para buscar las cantidades de las muestras
	 *
	 * @access public
	 * @param integer $id_Solicitud
	 * @return array
	 */
	public function TraerValoresMuestras($id_Solicitud){
		$sql= '
			SELECT "Cantidad_Muestras", "Muestras_Listas"
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Solicitud));
		return $this->vConexion->GetArrayInfo($result);
	}
	
	/**
	 * Metodo para actualizar la cantidad de muestras listas de una solicitud
	 *
	 * @access public
	 * @param integer $aumenta
	 * @param integer $id_Solicitud
	 * @return resource
	 */
	public function ActualizaMuestrasListas($aumenta,$id_Solicitud){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" SET "Muestras_Listas"=%? WHERE "id_Solicitud"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($aumenta,$id_Solicitud));
	}
	
	/**
	 * Metodo para Obtener valores de la tabla Parametros
	 *
	 * @access public
	 * @param integer $id_Muestra
	 * @return resource
	 */
	public function ObtenerParametros($id_Muestra){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Parametros" WHERE "id_Muestra"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_Muestra));
	}
		
		
	
	/**
	 * Busca la informacion del cliente y solicitud para el envio de correo
	 *
	 * @access public
	 * @param integer $id_muestra
	 * @return array
	 */
	public function GetDatosClienteSolicitud($id_muestra){
		$sql= '
			SELECT C."Nombre_Cliente", C."Email", C."Asesor_Comercial", S."Cod_Solicitud" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" C 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Solicitud" S ON(C."id_Cliente"=S."id_Cliente") 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON(S."id_Solicitud"=M."id_Solicitud") 
			WHERE M."id_Muestra"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_muestra));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row;
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
			SELECT P."id_certificado" 
			FROM "'.$this->vEsquema.'"."TR001_Certificado" P 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (P."cod_muestra_lubrialerta"=M."Cod_Muestra") 
			WHERE M."id_Equipo"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($equipo));
		if($this->vConexion->GetNumberRows($result) > 0){
			return true;
		}
		else{
			return false;
		}
	}
	
	
	/**
	 * Actualiza el status de la solicitud cuando todas las muestras estan listas.
	 *
	 * @access public
	 * @param integer $solicitud
	 * @param date $fecha
	 * @return resource|boolean
	 */
	public function ActualizaEstatusFinal($solicitud,$fecha){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" SET "Status_Solicitud"=6, "fecha_final"=%? WHERE "id_Solicitud"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql,array($fecha,$solicitud)) ){
			return @pg_affected_rows($result);
		}
		else{
			return false;
		}
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
	 * @param integer $codigom
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
	 * Metodo para obtener los datos del equipo atraves del id
	 *
	 * @access public
	 * @param integer $id_Equipo
	 * @return array
	 */
	public function GetAsesor($id_Personal){
		$sql= 'SELECT "Nombres_Apellidos", "Email" FROM "'.$this->vEsquema.'"."TR001_Personal" WHERE "id_Personal"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_Personal));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row;
	}		
}

?>