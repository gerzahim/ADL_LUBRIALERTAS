<?php
class LoginAcceso{

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
	 * Verifica si los datos estan en la BD.  Si lo encuentra devuelve un arreglo con los datos principales.
	 *
	 * @param string $usuario
	 * @param string $clave
	 * @return boolean, array
	 */
	public function VerificarUsuario($usuario,$clave){
		$sql='
			SELECT * 
			FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			WHERE "Indicador_PDVSA" LIKE %? AND "Password" LIKE %? AND "Cuenta_Eliminada"=0 
		';
		if( !$result= $this->vConexion->ExecuteQuery($sql, array($usuario,$clave) ) ){
			return false;	
		}
		else{
			if( $this->vConexion->GetNumberRows($result) > 0 ){
				return $this->vConexion->GetArrayInfo($result);
			}
			else{
				return false;
			}
		}
	}
	
	/**
	 * Actualiza el estatus del usuario para saber si esta conectado o no.
	 * Omite la actualizacion del estatus del administrador principal.
	 *
	 * @param integer $registro
	 * @param integer $status
	 * @return boolean
	 */
	public function ActualizaEstatusConectado($registro,$status){
		//if($registro!='1'){
			$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Conectado"=%? WHERE "id_Cuenta_Acceso"=%? ';
			return $this->vConexion->ExecuteQuery($sql, array($status,$registro));/*
		}
		else{
			return true;
		}*/
	}
	
	/**
	 * Actualiza la cuenta del usuario como bloqueada.
	 *
	 * @param string $usuario
	 * @return boolean
	 */
	public function BloquearUsuario($usuario){
		$sql=' UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Bloqueado"=1,"Conectado"=0 WHERE "Indicador_PDVSA" LIKE %? ';
		return $this->vConexion->ExecuteQuery($sql, array($usuario));
	}
	
	/**
	 * Realiza una lectura en la cuenta de acceso para saber si el tipo de usuario que es
	 *
	 * @param string $usuario
	 * @return boolean
	 */
	public function VerificarPerfil($status){
		$sql='
			SELECT "Perfil" 
			FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			WHERE "id_Cuenta_Acceso"=%? '
			;
		$result= $this->vConexion->ExecuteQuery($sql, array($status));
		$row=  $this->vConexion->GetArrayInfo($result);
		return $row['Perfil'];
	}
}		
?>