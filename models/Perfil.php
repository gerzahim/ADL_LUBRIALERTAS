<?php
class Perfil{

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
	 * @param string $esquema
	 */
	public function __construct($conexion="", $esquema='public') {
		$this->vConexion= $conexion;
		$this->vEsquema= $esquema;
	}
	
	/**
	 * Busqueda de todos los perfiles.
	 *
	 * @param integer  $cantidad
	 * @param  integer $pagina
	 * @return resource
	 */
	public function GetPerfiles($cantidad,$pagina){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "Perfil_Eliminado"=0 AND "id_Perfil"<>1 ORDER BY "Nombre_Perfil"';
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
		$result=  $this->vConexion->ExecuteQuery($sql);
		
		return array('pagina'=>$pagina,'total_paginas'=>$total_paginas,'total_registros'=>$total_registros,'result'=>$result);
	
	}
	
	/**
	 * Busqueda de los modulos de un perfil.
	 *
	 * @param integer $perfil
	 * @return resource
	 */
	public function GetModulosPorPerfil($perfil){
		$sql= '
			SELECT M."id_Modulos", M."Nombre_Modulos"
			FROM "'.$this->vEsquema.'"."TR001_Modulos" M 
			INNER JOIN "'.$this->vEsquema.'"."TH001_Roles" R ON (M."id_Modulos"=R."id_Modulos") 
			WHERE R."id_Perfiles"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
	
	/**
	 * Busqueda todos los modulos.
	 *
	 * @param integer $padre
	 * @return resource
	 */
	public function GetModulos($padre='0'){
		$sql= '
			SELECT "id_Modulos","Nombre_Modulos", "Referencia_Modulos" 
			FROM "'.$this->vEsquema.'"."TR001_Modulos" 
			WHERE "Modulo_Padre"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($padre));
	}
	
	/**
	 * Verifica si el nombre del perfil esta repetido.
	 *
	 * @param string $nombre
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaNombreRepetido($nombre, $id_referencia=""){
		$sql= 'SELECT "id_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "Nombre_Perfil"=%?';
		$parametros= array($nombre);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Perfil"<>%?';
			$parametros= array($nombre, $id_referencia);
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
	 * Guarda el nombre del Perfil
	 *
	 * @param string $nombre
	 * @return integer or boolean
	 */
	public function GuardaNombrePerfil($nombre){
		$result= $this->vConexion->ExecuteQuery('SELECT * FROM nextval(\'"'.$this->vEsquema.'"."TR001_Perfiles_id_Perfil_seq"\'::regclass)');
		$row= $this->vConexion->GetArrayInfo($result);
		
		$sql= 'INSERT INTO "'.$this->vEsquema.'"."TR001_Perfiles" ( "id_Perfil","Nombre_Perfil","Perfil_Eliminado") VALUES(%?,%?,0)';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'],$nombre)) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
		
	}
	
	/**
	 * Guarda la relacion del perfil con los modulos
	 *
	 * @param integer $perfil
	 * @param integer $modulo
	 * @param integer $add_acceso
	 * @param integer $upd_acceso
	 * @param integer $del_acceso
	 * @return boolean
	 */
	public function GuardaPerfilModulo($perfil,$modulo,$add_acceso=0,$upd_acceso=0,$del_acceso=0){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TH001_Roles" ( "id_Perfiles","id_Modulos","Acceso_Agregar","Acceso_Modificar","Acceso_Eliminar") 
			VALUES(%?,%?, %?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($perfil,$modulo,$add_acceso,$upd_acceso,$del_acceso));
	}
	
	/**
	 * Verifica si el perfil tiene relacion con algun usuario
	 *
	 * @param integer $perfil
	 * @return boolean
	 */
	public function VerificaRelacionUsuario($perfil){
		$sql= 'SELECT "Perfil" FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" WHERE "Perfil"=%? AND "Cuenta_Eliminada"=0';
		$result= $this->vConexion->ExecuteQuery($sql, array($perfil));
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza el estatus del perfil como eliminado.
	 *
	 * @param integer $perfil
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($perfil){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Perfiles" SET "Perfil_Eliminado"=1 WHERE "id_Perfil"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
	
	/**
	 * Busca el nombre del perfil.
	 *
	 * @param integer $perfil
	 * @return boolean or string
	 */
	 public function GetNombrePerfil($perfil){
	 	$sql= 'SELECT "Nombre_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "Perfil_Eliminado"=0 AND "id_Perfil"=%?';
		if(!$result= $this->vConexion->ExecuteQuery($sql, array($perfil)) ){
			return false;
		}
		else{
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['Nombre_Perfil'];
		}
	 }
	 
	/**
	 * Busqueda de los modulos y permisos de un perfil.
	 *
	 * @param integer $perfil
	 * @return resource
	 */
	public function GetModulosAsignados($perfil){
		$sql= '
			SELECT R."id_Modulos", R."Acceso_Agregar", R."Acceso_Modificar", R."Acceso_Eliminar"
			FROM "'.$this->vEsquema.'"."TR001_Modulos" M 
			INNER JOIN "'.$this->vEsquema.'"."TH001_Roles" R ON (M."id_Modulos"=R."id_Modulos") 
			WHERE R."id_Perfiles"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
	
	/**
	 * Actualiza los datos del perfil.
	 *
	 * @param string $nombre
	 * @param integer $perfil
	 * @return boolean
	 */
	public function ActualizaNombrePerfil($nombre,$perfil){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Perfiles" SET "Nombre_Perfil"=%? WHERE "id_Perfil"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$perfil));
	}
	
	/**
	 * Elimina la relacion anterios y crea una nueva relacion del perfil con los moduilos
	 *
	 * @param integer $perfil
	 * @param integer $modulo
	 * @param integer $add_acceso
	 * @param integer $upd_acceso
	 * @param integer $del_acceso
	 * @return boolean
	 */
	public function EliminaPerfilModulo($perfil){
		$sql='DELETE FROM "'.$this->vEsquema.'"."TH001_Roles"  WHERE "id_Perfiles"=%? ';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
	
		/**
	 * Busca el nombre del perfil a Eliminar.
	 *
	 * @param integer $perfil
	 * @return boolean or string
	 */
	 public function GetNombrePerfilEliminar($perfil){
	 	$sql= 'SELECT "Nombre_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "id_Perfil"=%?';
		$result= $this->vConexion->ExecuteQuery($sql, array($perfil));
		$row= $this->vConexion->GetArrayInfo($result);
		return $row['Nombre_Perfil'];
	 }
	
}
?>