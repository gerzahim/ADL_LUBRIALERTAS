<?php
class Menu{

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
	 * Busqueda de los modulos asignados segun el perfil
	 *
	 * @param integer $perfil
	 * @return resource
	 */
	public function GetMenu($perfil){
		$sql= '
			SELECT M.*, R."Acceso_Agregar", R."Acceso_Modificar", R."Acceso_Eliminar" 
			FROM "'.$this->vEsquema.'"."TH001_Roles" R 
			INNER JOIN "'.$this->vEsquema.'"."TR001_Modulos" M ON(R."id_Modulos"=M."id_Modulos") 
			WHERE R."id_Perfiles"=%?
			ORDER BY M."id_Modulos"
		';
		return $this->vConexion->ExecuteQuery($sql, array($perfil));
	}
}
?>