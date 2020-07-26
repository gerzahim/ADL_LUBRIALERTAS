<?php

class Cliente{

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
	 */
	public function __construct($conexion="", $esquema='public') {
		$this->vConexion= $conexion;
		$this->vEsquema= $esquema;
	}
	
	/**
	 * Busqueda de todos los clientes.
	 *
	 * @access public
	 * @param integer  $cantidad
	 * @param integer $pagina
	 * @param integer $distribuidor
	 * @param string $nombre
	 * @param string $indicador
	 * @param string $rif
	 * @param boolean $exportar
	 * @return resource
	 */
	public function GetListado($cantidad, $pagina, $distribuidor=false, $asesor=false, $nombre=false, $indicador=false, $rif=false, $exportar=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT P."id_Cliente", P."Nombre_Cliente", P."Rif", P."Email", C."Conectado", C."Bloqueado" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" P
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (P."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE C."Cuenta_Eliminada"=0 
		';
		$parametros= array();
		
		// Para la busqueda
		if($distribuidor){
			$sql.= ' AND P."Distribuidor"=%? ';
			$parametros= array_merge($parametros, array($distribuidor) );
		}
		
		if($asesor){
			$sql.= ' AND P."Asesor_Comercial"=%? ';
			$parametros= array_merge($parametros, array($asesor) );
		}
		
		if($nombre){
			$sql.= ' AND P."Nombre_Cliente" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		if($rif){
			$sql.= ' AND P."Rif" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$rif.'%') );
		}
		
		if($indicador){
			$sql.= ' AND C."Indicador_PDVSA" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$indicador.'%') );
		}
		
		// SQL final
		$sql.= ' ORDER BY P."Nombre_Cliente"';
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
	
	/**
	 * Busqueda de todos los perfiles no eliminados.
	 *
	 * @access public
	 * @return boolean
	 */
	public function GetPerfiles(){
		$sql= 'SELECT "id_Perfil", "Nombre_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "Perfil_Eliminado"=0 ORDER BY "Nombre_Perfil"';
		return $this->vConexion->ExecuteQuery($sql);
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
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "Email"=%?';
		$parametros= array($email);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Cliente"<>%?';
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
	 * @access public
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
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetCuentaAcceso($id_referencia){
		$sql= 'SELECT "id_Cuenta_Acceso" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cliente"=%?';
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
	 * @access public
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($cuenta){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Cuenta_Eliminada"=1 WHERE "id_Cuenta_Acceso"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($cuenta));
	}
	
	/**
	 * Busqueda de todos los distribuidores no eliminados.
	 *
	 * @access public
	 * @return boolean
	 */
	public function GetDistribuidores(){
		$sql= '
			SELECT D."id_Distribuidor", D."Nombres_Apellidos" 
			FROM "'.$this->vEsquema.'"."TR001_Distribuidores" D
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (D."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE C."Cuenta_Eliminada"=0 
			ORDER BY D."Nombres_Apellidos"
		';
		return $this->vConexion->ExecuteQuery($sql);
	}
	
	/**
	 * Guarda los datos de acceso al sistema
	 *
	 * @access public
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
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'],$nombre,$clave,$indicador,$perfil,"c")) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de informacion del cliente.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $fax
	 * @param string $email
	 * @param string $direccion
	 * @param string $zona
	 * @param integer $distribuidor
	 * @param string $asesor
	 * @param integer $volumen
	 * @param integer $muestras
	 * @param string $contacto1
	 * @param string $telf_contacto1
	 * @param string $contacto2
	 * @param string $telf_contacto2
	 * @param string $codigo_empresa
	 * @param string $actividad_empresa
	 * @param integer $id_cuenta
	 * @return boolean
	 */
	public function GuardarDatosCliente($nombre,$rif,$telf_ofc,$fax,$email,$direccion,$zona,$distribuidor,$asesor,$volumen,$muestras,$contacto1,$telf_contacto1,$contacto2,$telf_contacto2,$codigo_empresa,$actividad_empresa,$id_cuenta){
		$sql='
			INSERT INTO "'.$this->vEsquema.'"."TR001_Cliente" 
			("Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Persona_Contacto1", "Telefono_Celular_Contacto1", "Persona_Contacto2", "Telefono_Celular_Contacto2", "Fax", "Email", "Rif", "Volumen_Vendido", "id_Cuenta_Acceso", "Distribuidor", "Asesor_Comercial", "Muestras_Mensuales", "Zona","Codigo_Empresa","Actividad_Empresa") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre, $direccion, $telf_ofc, $contacto1, $telf_contacto1, $contacto2, $telf_contacto2, $fax, $email, $rif, $volumen, $id_cuenta, $distribuidor, $asesor, $muestras, $zona, $codigo_empresa, $actividad_empresa) );
	}
	
	/**
	 * Busca los datos del cliente.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosCliente($id_referencia){
		$sql= '
			SELECT P.*, C."Indicador_PDVSA", C."Perfil" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" P
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (P."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE P."id_Cliente"=%?
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
	 * @access public
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
	 * Actualiza los datos de informacion del cliente.
	 *
	 * @access public
	 * @param string $nombre
	 * @param string $rif
	 * @param string $telf_ofc
	 * @param string $fax
	 * @param string $email
	 * @param string $direccion
	 * @param string $zona
	 * @param integer $distribuidor
	 * @param string $asesor
	 * @param integer $volumen
	 * @param integer $muestras
	 * @param string $contacto1
	 * @param string $telf_contacto1
	 * @param string $contacto2
	 * @param string $telf_contacto2
	 * @param string $codigo_empresa
	 * @param string $actividad_empresa
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaDatosCliente($nombre,$rif,$telf_ofc,$fax,$email,$direccion,$zona,$distribuidor,$asesor,$volumen,$muestras,$contacto1,$telf_contacto1,$contacto2,$telf_contacto2,$codigo_empresa,$actividad_empresa,$id_referencia){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Cliente" 
			SET "Nombre_Cliente"=%?, "Direccion_Cliente"=%?, "Telefono_Oficina_Cliente"=%?, "Persona_Contacto1"=%?, "Telefono_Celular_Contacto1"=%?, "Persona_Contacto2"=%?, "Telefono_Celular_Contacto2"=%?, "Fax"=%?, "Email"=%?, "Rif"=%?, "Volumen_Vendido"=%?, "Distribuidor"=%?, "Asesor_Comercial"=%?, "Muestras_Mensuales"=%?, "Zona"=%?, "Codigo_Empresa"=%?,"Actividad_Empresa"=%? 
			WHERE "id_Cliente"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$direccion,$telf_ofc,$contacto1,$telf_contacto1,$contacto2,$telf_contacto2,$fax,$email,$rif,$volumen,$distribuidor,$asesor,$muestras,$zona,$codigo_empresa,$actividad_empresa,$id_referencia));
	}
	
	/**
	 * Actualiza el estatus de la cuenta de acceso como desconectado.
	 *
	 * @access public
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function CambioEstatus($cuenta){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Conectado"=0 WHERE "id_Cuenta_Acceso"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($cuenta));
	}
	/**
	 * Actualiza el estatus de un Equipo a Eliminado
	 *
	 * @access public
	 * @param integer $cuenta
	 * @return boolean
	 */
	public function ActualizaEquipoEliminado($id_Cliente){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Equipo" SET "Eliminado"=1 WHERE "id_Cliente"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_Cliente));
	}	
	
	/**
	 * Actualiza la clave de acceso.
	 *
	 * @access public
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
	 * Busqueda de todos los asesores no eliminados.
	 *
	 * @access public
	 * @return boolean
	 */
	public function GetAsesores(){
		$sql= '
			SELECT P."id_Personal", P."Nombres_Apellidos" 
			FROM "'.$this->vEsquema.'"."TR001_Personal" P
			INNER JOIN "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C ON (P."id_Cuenta_Acceso"=C."id_Cuenta_Acceso") 
			WHERE C."Cuenta_Eliminada"=0 AND P."Cargo"=1
			ORDER BY P."Nombres_Apellidos"
		';
		return $this->vConexion->ExecuteQuery($sql);
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
	public function GetNombreClienteEliminar($id_referencia){
		$sql= 'SELECT "Nombre_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cliente"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_referencia));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Nombre_Cliente'];
	}		
}
?>