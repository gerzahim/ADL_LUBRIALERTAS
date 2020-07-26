<?php

class Reporte{

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
	
	/**
	 * Busqueda la cantidad de muestras por equipo.
	 *
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @param integer $cliente
	 * @param boolean $exportar
	 * @return array or boolean or resource
	 */
	public function GetCantidadMuestraPorEquipo($cantidad, $pagina, $distribuidor=false, $asesor=false, $cliente=false, $exportar=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		if($distribuidor){
			$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (C."id_Cliente"=E."id_Cliente") ';
			$where= ' WHERE C."Distribuidor"='.$distribuidor;
		}
		
		if($asesor){
			$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (C."id_Cliente"=E."id_Cliente") ';
			$where= ' WHERE C."Asesor_Comercial"='.$asesor;
		}
		
		if($cliente){
			$where= ' WHERE E."id_Cliente"='.$cliente;
		}
		
		$sql= '
			SELECT COUNT(M."id_Muestra") AS cantidad, E."Codigo_Equipo", E."Tipo", E."Marca", E."id_Cliente", E."id_Equipo", E."Nombre_Equipo" 
			FROM "'.$this->vEsquema.'"."TR001_Equipo" E 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (M."id_Equipo"=E."id_Equipo") 
			'.$inner.' 
			'.$where.' 
			GROUP BY E."id_Equipo", E."Codigo_Equipo", E."Tipo", E."Marca", E."id_Cliente", E."Nombre_Equipo" 
		';
		$parametros= array();
		
		// SQL final
		$sql.= ' ORDER BY E."Tipo"';
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
		if(!$exportar){
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
		else{
			return $result;
		}
	}
	
	/**
	 * Devuelve el nombre del cliente
	 *
	 * @access public
	 * @param integer $id_cliente
	 * @return boolean or string
	 */
	public function GetNombreCliente($id_cliente){
		$sql=' SELECT "Nombre_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cliente"=%? ';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_cliente)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busqueda la cantidad de muestras por cliente.
	 *
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @param boolean $exportar
	 * @return array or boolean or resource
	 */
	public function GetCantidadMuestraPorCliente($cantidad,$pagina,$distribuidor,$asesor,$exportar=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT SUM(S."Cantidad_Muestras") AS cantidad, C."Nombre_Cliente", C."Rif", C."Email" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" C 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Solicitud" S ON (C."id_Cliente"=S."id_Cliente") 
		';
		
		$parametros= array();
		
		if($distribuidor){
			$sql.= ' WHERE C."Distribuidor"=%?';
			$parametros= array($distribuidor);
		}
		
		if($asesor){
			$sql.= ' WHERE C."Asesor_Comercial"=%?';
			$parametros= array($asesor);
		}
		
		// SQL final
		$sql.= '
			GROUP BY C."id_Cliente", C."Nombre_Cliente", C."Rif", C."Email" 
			ORDER BY C."Nombre_Cliente"
		';
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
		if(!$exportar){
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
		else{
			return $result;
		}
	}
	
	/**
	 * Devuelve las fechas de las muestras
	 *
	 * @access public
	 * @param integer $id_equipo
	 * @return boolean or resource
	 */
	public function GetFechasMuestra($id_equipo){
		$sql='
			SELECT S."Fecha" 
			FROM "public"."TR001_Muestra" M 
			INNER JOIN "public"."TR001_Solicitud" S ON (M."id_Solicitud"=S."id_Solicitud") 
			WHERE M."id_Equipo"=%? 
			GROUP BY S."Fecha" 
			ORDER BY S."Fecha" DESC 
		';
		return $this->vConexion->ExecuteQuery($sql,array($id_equipo));
	}
	
	/**
	 * Busqueda de todos los clientes.
	 *
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @return boolean
	 */
	public function GetClientes($distribuidor=false,$asesor=false){
		$sql= 'SELECT "id_Cliente", "Nombre_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente"';
		$parametros= array();
		
		if($distribuidor){
			$sql.= ' WHERE "Distribuidor"=%?';
			$parametros= array($distribuidor);
		}
		
		if($asesor){
			$sql.= ' WHERE "Asesor_Comercial"=%?';
			$parametros= array($asesor);
		}
		
		$sql.=' ORDER BY "Nombre_Cliente"';
		return $this->vConexion->ExecuteQuery($sql,$parametros);
	}
	
	/**
	 * Busqueda la cantidad de solicitudes por cliente.
	 *
	 * @param integer $cantidad
	 * @param integer $pagina
	 * @param integer $cliente
	 * @param boolean $exportar
	 * @return array or boolean or resource
	 */
	public function GetSolicitudesCliente($cantidad,$pagina,$cliente,$exportar=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT "Cod_Solicitud", "Fecha", "Motivo_Analisis", "Cantidad_Muestras" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" 
			WHERE "id_Cliente"=%?
		';
		
		$parametros= array($cliente);
		
		// SQL final
		$sql.= ' ORDER BY "id_Solicitud" DESC';
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
		if(!$exportar){
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
		else{
			return $result;
		}
	}
	
	/**
	 * Devuelve el nombre y marca del equipo
	 *
	 * @access public
	 * @param integer $id_equipo
	 * @return boolean or string
	 */
	public function GetDatosEquipo($id_equipo){
		$sql=' SELECT "Marca","Tipo" FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "id_Equipo"=%? ';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_equipo)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busca los parametros y las fechas de las muestras del Equipo
	 *
	 * @access public
	 * @param integer $id_equipo
	 * @return boolean or resource
	 */
	/*public function GetParametrosEquipo($id_equipo){
		$sql= '
			SELECT S."Fecha", P."FE", P."SN", P."PB", P."CU", P."NA", P."SI", P."AL", P."CR", P."B", P."MG", P."VISC100" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" S 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (S."id_Solicitud"=M."id_Solicitud") 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Parametros" P ON (P."id_Muestra"=M."id_Muestra") 
			WHERE M."id_Equipo"=%? 
			ORDER BY S."Fecha" ASC
		';
		return $this->vConexion->ExecuteQuery($sql, array($id_equipo));
	}*/

	/**
	 * Busca los parametros y las fechas de las muestras del Equipo
	 *
	 * @access public
	 * @param integer $id_equipo
	 * @return boolean or resource
	 */
	public function GetCertificadosEquipo($id_equipo){
		$sql= '
			SELECT S."Fecha", P."id_certificado" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" S 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (S."id_Solicitud"=M."id_Solicitud") 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Certificado" P ON (P."cod_muestra_lubrialerta"=M."Cod_Muestra") 
			WHERE M."id_Equipo"=%? 
			ORDER BY S."Fecha" ASC
		';
		return $this->vConexion->ExecuteQuery($sql, array($id_equipo));
	}	
	
	/**
	 * Busca los resultados de las muestras del Equipo
	 *
	 * @access public
	 * @param integer $id_certificado
	 * @return boolean or resource
	 */
	public function GetResultadosEquipo($id_certificado){
		$sql= '
			SELECT R."prueba",R."resultado",R."idprueba",R."incertidumbre"
			FROM "'.$this->vEsquema.'"."TR001_Metodo" M 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Resultado" R ON (M."id_metodo"=R."id_metodo") 
			WHERE M."id_certificado"=%? 
		';
		return $this->vConexion->ExecuteQuery($sql, array($id_certificado));
	}	
	/**
	 * Busqueda la cantidad de muestras por equipo.
	 *
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param integer $cliente
	 * @param integer $distribuidor
	 * @param integer $asesor
	 * @return array or boolean or resource
	 */
	public function GetEquipoConParametros($cantidad,$pagina,$cliente,$distribuidor=false,$asesor=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$parametros= array();
		
		if( $cliente && is_numeric($cliente) ){
			$where= 'WHERE E."id_Cliente"=%?';
			$parametros= array($cliente);
		}
		
		if($distribuidor){
			$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (C."id_Cliente"=E."id_Cliente") ';
			$where.= ' AND C."Distribuidor"='.$distribuidor;
		}
		
		if($asesor){
			$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" C ON (C."id_Cliente"=E."id_Cliente") ';
			$where.= ' AND C."Asesor_Comercial"='.$asesor;
		}
			
		
		$sql= '
			SELECT COUNT(M."id_Muestra") AS cantidad, E."Codigo_Equipo", E."Tipo", E."Marca", E."id_Cliente", E."id_Equipo" 
			FROM "'.$this->vEsquema.'"."TR001_Equipo" E 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Muestra" M ON (M."id_Equipo"=E."id_Equipo") 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Certificado" P ON (P."cod_muestra_lubrialerta"=M."Cod_Muestra")
			'.$inner.' 
			'.$where.' 
			GROUP BY E."id_Equipo", E."Codigo_Equipo", E."Tipo", E."Marca", E."id_Cliente"
		';
		
		// SQL final
		$sql.= ' ORDER BY E."Tipo"';
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
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
	
	
	/**
	 * Obtiene el ID del distribuidor.
	 *
	 * @access public
	 * @param integer $cuenta
	 * @return boolean|string
	 */
	public function GetIdDistribuidor($cuenta){
		$sql= 'SELECT "id_Distribuidor" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "id_Cuenta_Acceso"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($cuenta)) ){
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
	 * Obtiene el ID del cliente.
	 *
	 * @access public
	 * @param integer $cuenta
	 * @return boolean|string
	 */
	public function GetIdCliente($cuenta){
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cuenta_Acceso"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($cuenta)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Cliente'];
		}
		else{
			return false;
		}
	}
}
?>