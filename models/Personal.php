<?php

class Personal{

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
	 * Busqueda de todos los usuarios de personal.
	 *
	 * @param integer  $cantidad
	 * @param  integer $pagina
	 * @param  string $nombre
	 * @param  string $indicador
	 * @param  integer $cedula
	 * @return resource
	 */
	public function GetListado($cantidad,$pagina,$nombre=false,$indicador=false,$cedula=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT P."id_Personal", P."Nombres_Apellidos", P."Cedula_Identidad", P."Email", C."Conectado", C."Bloqueado" 
			FROM "'.$this->vEsquema.'"."TR001_Personal" P
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (P."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE C."Cuenta_Eliminada"=0 
		';
		$parametros= array();
		
		// Para la busqueda
		if($nombre){
			$sql.= ' AND P."Nombres_Apellidos" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		if($cedula){
			$sql.= ' AND P."Cedula_Identidad" LIKE %? ';
			$parametros= array_merge($parametros, array($cedula) );
		}
		
		if($indicador){
			$sql.= ' AND C."Indicador_PDVSA" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$indicador.'%') );
		}
		
		// SQL final
		$sql.= ' ORDER BY P."Nombres_Apellidos"';
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
		$sql= 'SELECT "id_Personal" FROM "'.$this->vEsquema.'"."TR001_Personal" WHERE "Email"=%?';
		$parametros= array($email);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Personal"<>%?';
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
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'],$nombre,$clave,$indicador,$perfil,"p")) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de informacion del personal.
	 *
	 * @param string $nombre
	 * @param integer $cedula
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $direccion
	 * @param string $zona
	 * @param string $cargo
	 * @param string $supervisor
	 * @param string $email
	 * @param integer $id_cuenta
	 * @return boolean
	 */
	public function GuardarDatosPersonal($nombre, $cedula, $telf_ofc, $telf_cel, $direccion, $cargo, $supervisor, $email, $id_cuenta, $zona ){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Personal" 
			("Nombres_Apellidos", "Cedula_Identidad", "Telefono_Oficina", "Telefono_Celular", "Direccion", "Cargo", "Supervisor", "Email", "id_Cuenta_Acceso", "Zona") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre, $cedula, $telf_ofc, $telf_cel, $direccion, $cargo, $supervisor, $email, $id_cuenta, $zona) );
	}
	
	/**
	 * Busqueda del ID de la cuenta de acceso.
	 *
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetCuentaAcceso($id_referencia){
		$sql= 'SELECT "id_Cuenta_Acceso" FROM "'.$this->vEsquema.'"."TR001_Personal" WHERE "id_Personal"=%?';
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
	 * Busca los datos del personal.
	 *
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosPersonal($id_referencia){
		$sql= '
			SELECT P.*, C."Indicador_PDVSA", C."Perfil" 
			FROM "'.$this->vEsquema.'"."TR001_Personal" P
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (P."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE P."id_Personal"=%?
		';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
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
	public function ActualizaDatosAcceso($nombre,$indicador,$perfil=false,$cuenta){
		
		$parametros= array($nombre,$indicador,$cuenta);
		$valor="";
		
		if($perfil){
			$valor= ', "Perfil"=%?';
			$parametros= array($nombre,$indicador,$perfil,$cuenta);
		}
		
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			SET "Nombre"=%?,"Indicador_PDVSA"=%? '.$valor.' 
			WHERE "id_Cuenta_Acceso"=%?
		';
		
		return $this->vConexion->ExecuteQuery($sql, $parametros);
	}
	
	/**
	 * Actualiza los datos de informacion del personal.
	 *
	 * @param string $nombre
	 * @param integer $cedula
	 * @param string $telf_ofc
	 * @param string $telf_cel
	 * @param string $direccion
	 * @param string $zona
	 * @param string $cargo
	 * @param string $supervisor
	 * @param string $email
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaDatosPersonal($nombre, $cedula, $telf_ofc, $telf_cel, $direccion, $zona, $cargo, $supervisor, $email, $id_referencia){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Personal" 
			SET "Nombres_Apellidos"=%?, "Cedula_Identidad"=%?, "Telefono_Oficina"=%?, "Telefono_Celular"=%?, "Direccion"=%?, "Cargo"=%?, "Supervisor"=%?, "Email"=%?, "Zona"=%? 
			WHERE "id_Personal"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre, $cedula, $telf_ofc, $telf_cel, $direccion, $cargo, $supervisor, $email, $zona, $id_referencia));
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
	 * Busqueda de todos los cargos.
	 *
	 * @return boolean
	 */
	public function GetCargos(){
		$sql= 'SELECT "id_cargo", "nombre_cargo" FROM "'.$this->vEsquema.'"."TR001_Cargos" ORDER BY "nombre_cargo"';
		return $this->vConexion->ExecuteQuery($sql);
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
}
?>