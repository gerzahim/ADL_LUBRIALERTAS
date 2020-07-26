<?php

class Transporte{

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
	 * Busqueda de todos los tranportes.
	 *
	 * @access public
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param string $nombre
	 * @param string $indicador
	 * @param string $rif
	 * @return array
	 */
	public function GetListado($cantidad,$pagina,$nombre=false,$rif=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT "id_Empresa_Transporte","Nombre_Empresa","Rif","Telefono_Oficina" 
			FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte" 
			WHERE "Eliminado"=0 ';
		$parametros= array();
		
		// Para la busqueda
		if($nombre){
			$sql.= ' AND "Nombre_Empresa" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		if($rif){
			$sql.= ' AND "Rif" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$rif.'%') );
		}
		
		// SQL final
		$sql.= ' ORDER BY "Nombre_Empresa"';
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
	 * Verifica si el email esta repetido.
	 *
	 * @access public
	 * @param string $email
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaEmailRepetido($email, $id_referencia=""){
		$sql= '
			SELECT "id_Empresa_Transporte" 
			FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte" 
			WHERE "Email"=%? AND "Email" NOT NULL
		';
		$parametros= array($email);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Empresa_Transporte"<>%?';
			$parametros= array($email, $id_referencia);
		}
		
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza el equipo como eliminado.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($id_referencia){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Empresa_Transporte" SET "Eliminado"=1 WHERE "id_Empresa_Transporte"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_referencia));
	}
	
	
	/**
	 * Guarda los datos de informacion del transportista.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $email
	 * @param string $fax
	 * @param string $contacto
	 * @return boolean
	 */
	public function GuardarDatosTransporte($nombre,$rif,$telf_ofc,$telf_cel,$email,$fax,$contacto){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Empresa_Transporte" 
			("Nombre_Empresa", "Rif", "Persona_Contacto", "Telefono_Celular", "Telefono_Oficina", "Fax", "Email", "Eliminado") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$rif,$contacto,$telf_cel,$telf_ofc,$fax,$email,'0') );
	}
	
	/**
	 * Busca los datos del transportista.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosTransporte($id_referencia){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte" WHERE "id_Empresa_Transporte"=%?';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	/**
	 * Busca el nombre del transportista A Eliminar.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetNombreTransporteEliminar($id_referencia){
		$sql= 'SELECT "Nombre_Empresa" FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte" WHERE "id_Empresa_Transporte"=%?';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['Nombre_Empresa'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza la informacion del transportista.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $email
	 * @param string $fax
	 * @param string $contacto
	 * @param integer $id
	 * @return boolean
	 */
	public function ActualizarDatosTransporte($nombre,$rif,$telf_ofc,$telf_cel,$email,$fax,$contacto,$id){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Empresa_Transporte" 
			SET "Nombre_Empresa"=%?, "Rif"=%?, "Persona_Contacto"=%?, "Telefono_Celular"=%?, "Telefono_Oficina"=%?, "Fax"=%?, "Email"=%? 
			WHERE "id_Empresa_Transporte"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$rif,$contacto,$telf_cel,$telf_ofc,$fax,$email,$id));
	}
}
?>