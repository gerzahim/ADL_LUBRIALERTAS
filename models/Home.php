<?php

class Home{

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
	 * Busca el nombre del perfil.
	 *
	 * @param integer $perfil
	 * @return boolean or string
	 */
	 public function GetNombrePerfil($perfil){
	 	$sql= 'SELECT "Nombre_Perfil" FROM "'.$this->vEsquema.'"."TR001_Perfiles" WHERE "id_Perfil"=%?';
		if(!$result= $this->vConexion->ExecuteQuery($sql, array($perfil)) ){
			return false;
		}
		else{
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['Nombre_Perfil'];
		}
	 }
	
	/**
	 * Busqueda de los modulos asignados segun el perfil
	 *
	 * @param integer $perfil
	 * @return resource
	 */
	public function GetModulos($perfil){
		$sql= '
			SELECT M."Nombre_Modulos",  M."Referencia_Modulos" 
			FROM "'.$this->vEsquema.'"."TH001_Roles" R 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Modulos" M ON(R."id_Modulos"=M."id_Modulos") 
			WHERE R."id_Perfiles"=%? AND M."Referencia_Modulos" IS NOT NULL 
			ORDER BY M."Nombre_Modulos"
		';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
}
?>