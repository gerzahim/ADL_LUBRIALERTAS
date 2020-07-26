<?php

class Distribuidor{

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
	 * Busqueda de todos los distribuidores.
	 *
	 * @param integer  $cantidad
	 * @param  integer $pagina
	 * @param  string $nombre
	 * @param  string $indicador
	 * @param  string $rif
	 * @return resource
	 */
	public function GetListado($cantidad,$pagina,$nombre=false,$indicador=false,$rif=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT D."id_Distribuidor", D."Nombres_Apellidos", D."Rif", D."Email", C."Conectado", C."Bloqueado" 
			FROM "'.$this->vEsquema.'"."TR001_Distribuidores" D
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (D."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE C."Cuenta_Eliminada"=0 
		';
		$parametros= array();
		
		// Para la busqueda
		if($nombre){
			$sql.= ' AND D."Nombres_Apellidos" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		if($rif){
			$sql.= ' AND D."Rif" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$rif.'%') );
		}
		
		if($indicador){
			$sql.= ' AND C."Indicador_PDVSA" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$indicador.'%') );
		}
		
		// SQL final
		$sql.= ' ORDER BY D."Nombres_Apellidos"';
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
	 * Busqueda de todos los perfiles no eliminados.
	 *
	 * @return boolean
	 */
	public function GetPerfiles(){
		$sql= 'SELECT "id_Perfil", "Nombre_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "Perfil_Eliminado"=0 ORDER BY "Nombre_Perfil"';
		return $this->vConexion->ExecuteQuery($sql);
	}
	
	/**
	 * Verifica si el email esta repetido.
	 *
	 * @param string $email
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaEmailRepetido($email, $id_referencia=""){
		$sql= 'SELECT "id_Distribuidor" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "Email"=%?';
		$parametros= array($email);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Distribuidor"<>%?';
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
	 * Verifica si el indicador esta repetido.
	 *
	 * @param string $indicador
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaIndicadorRepetido($indicador, $id_referencia=""){
		
		$sql= 'SELECT "id_Cuenta_Acceso" FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" WHERE "Indicador_PDVSA"=%?';
		$parametros= array($indicador);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Cuenta_Acceso"<>%?';
			$parametros= array($indicador, $id_referencia);
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
	 * Busqueda del ID de la cuenta de acceso.
	 *
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetCuentaAcceso($id_referencia){
		$sql= 'SELECT "id_Cuenta_Acceso" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "id_Distribuidor"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Cuenta_Acceso'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza el estatus de la cuenta de acceso como eliminado.
	 *
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($cuenta){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Cuenta_Eliminada"=1 WHERE "id_Cuenta_Acceso"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($cuenta));
	}
	
	/**
	 * Actualiza el estatus de la cuenta de acceso como desconectado.
	 *
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function CambioEstatus($cuenta){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Conectado"=0 WHERE "id_Cuenta_Acceso"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($cuenta));
	}
	
	/**
	 * Actualiza la clave de acceso.
	 *
	 * @param integer $cuenta
	 * @param integer $clave
	 * @return boolean
	 */
	public function ActualizarClave($cuenta,$clave){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			SET "Password"=%?,"Primer_Acceso"=1, "Bloqueado"=0 
			WHERE "id_Cuenta_Acceso"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($clave,$cuenta));
	}
	
	/**
	 * Verifica si el distribuidor tiene relacion con algun cliente
	 *
	 * @param integer $distribuidor
	 * @return boolean
	 */
	public function VerificaRelacionCliente($distribuidor){
		$sql= '
			SELECT C."id_Cliente" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" C 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" Cta
			ON (C."id_Cuenta_Acceso"=Cta."id_Cuenta_Acceso") 
			WHERE Cta."Cuenta_Eliminada"=0 AND C."Distribuidor"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($distribuidor));
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busca los datos del distribuidor.
	 *
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosDistribuidor($id_referencia){
		$sql= '
			SELECT D.*, C."Indicador_PDVSA", C."Perfil" 
			FROM "'.$this->vEsquema.'"."TR001_Distribuidores" D
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (D."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE D."id_Distribuidor"=%?
		';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de acceso al sistema
	 *
	 * @param string $nombre
	 * @param string $clave
	 * @param string $indicador
	 * @param integer $perfil
	 * @return boolean
	 */
	public function GuardarDatosAcceso($nombre,$clave,$indicador,$perfil){
		$result= $this->vConexion->ExecuteQuery('SELECT * FROM nextval(\'"'.$this->vEsquema.'"."TR001_Cuenta_Acceso_id_Cuenta_Acceso_seq"\'::regclass)');
		$row= $this->vConexion->GetArrayInfo($result);
		
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			("id_Cuenta_Acceso","Nombre","Password","Indicador_PDVSA","Perfil","Conectado","Tipo_Usuario","Cuenta_Eliminada","Primer_Acceso") 
			VALUES(%?,%?,%?,%?,%?,0,%?,0,1)
		';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'],$nombre,$clave,$indicador,$perfil,"d")) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de informacion del distribuidor.
	 *
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $email
	 * @param string $direccion
	 * @param string $zona
	 * @param string $contacto
	 * @param string $fax
	 * @param integer $id_cuenta
	 * @return boolean
	 */
	public function GuardarDatosDistribuidor($nombre,$rif,$telf_ofc,$telf_cel,$email,$direccion,$zona,$contacto,$fax,$id_cuenta){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Distribuidores" 
			("Nombres_Apellidos", "Rif", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Persona_Contacto", "id_Cuenta_Acceso", "Email", "Zona", "Fax") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre, $rif, $telf_ofc, $telf_cel, $direccion, $contacto, $id_cuenta, $email, $zona, $fax) );
	}
	
	/**
	 * Actualiza los datos de acceso al sistema
	 *
	 * @param string $nombre
	 * @param string $indicador
	 * @param integer $perfil
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function ActualizaDatosAcceso($nombre,$indicador,$perfil,$cuenta){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			SET "Nombre"=%?,"Indicador_PDVSA"=%?,"Perfil"=%? 
			WHERE "id_Cuenta_Acceso"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$indicador,$perfil,$cuenta));
	}
	
	/**
	 * Actualiza los datos de informacion del distribuidor.
	 *
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $email
	 * @param string $direccion
	 * @param string $zona
	 * @param string $contacto
	 * @param string $fax
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaDatosDistribuidor($nombre, $rif, $telf_ofc, $telf_cel, $email, $direccion, $zona, $contacto, $fax, $id_referencia){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Distribuidores" 
			SET "Nombres_Apellidos"=%?, "Rif"=%?, "Telefono_Oficina"=%?, "Telefono_Celular"=%?, "Direccion"=%?, "Persona_Contacto"=%?, "Email"=%?, "Zona"=%?, "Fax"=%? 
			WHERE "id_Distribuidor"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre, $rif, $telf_ofc, $telf_cel, $direccion, $contacto, $email, $zona, $fax, $id_referencia));
	}
	
	/**
	 * Busqueda de todos las zonas.
	 *
	 * @access public
	 * @return boolean|resource
	 */
	public function GetZonas(){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Zona" ORDER BY "nombre_zona"';
		return $this->vConexion->ExecuteQuery($sql);
	}
	/**
	 * Busqueda de los password antiguos
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetPassados($id_referencia){
		$sql= 'SELECT "Password","PasswordA", "PasswordB"  FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" WHERE "id_Cuenta_Acceso"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_referencia));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row;
	}	
	
	/**
	 * Guardar el valor del password en el Campo Password A del tabla de cuenta de acceso
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GuardarPassTOPassA($passw="",$cuenta){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			SET "PasswordA"=%?
			WHERE "id_Cuenta_Acceso"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($passw,$cuenta));
	}
	/**
	 * Guardar el valor del passwordA en el Campo PasswordB del tabla de cuenta de acceso
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */	
	public function GuardarPassATOPassB($passA="",$cuenta){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			SET "PasswordB"=%?
			WHERE "id_Cuenta_Acceso"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($passA,$cuentaa));
	}
			
	 /**
	 * Busqueda del Nombre del Distribuidor a Eliminar.
	 *
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetNombreDistribuidorEliminar($id_referencia){
		$sql= 'SELECT "Nombres_Apellidos" FROM "'.$this->vEsquema.'"."TR001_Distribuidores" WHERE "id_Distribuidor"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_referencia));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Nombres_Apellidos'];
	}
}
?>