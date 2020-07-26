<?php
// Inicio de la sesion
session_start();

class InfoLogin{
	/**
	 * Id del Usuario logeado.
	 *
	 * @var string $vUsuario
	 */
	private $vCuenta="";
	
	/**
	 * Nombre del usuario logeado.
	 *
	 * @var string $vUsuario
	 */
	private $vUsuario="";
	
	/**
	 * Perfil del usuario logeado.
	 *
	 * @var string $vPerfilUsuario
	 */
	private $vPerfilUsuario="";
	
	/**
	 *IP donde se conecto a Lubrialertas
	 *
	 * @var string
	 */
	private  $vIP;
	
	/**
	 * Tipo de usuario
	 *
	 * @var string
	 */
	private  $vTipoUsuario;
	
	/**
	 * Variable que indica si es el primer acceso al sistema.
	 *
	 * @var string
	 */
	private  $vPrimerAcceso;
	
	/**
	 * Constructor de la clase. Instancia.
	 *
	 * @param integer $idCuenta
	 * @param string $usuario
	 * @param integer $perfil
	 * @param string $ip
	 * @param string $tipo_usuario
	 * @param integer $primer_acceso
	 */
	public function __construct($idCuenta,$usuario,$perfil, $ip, $tipo_usuario, $primer_acceso){
		$this->vCuenta= $idCuenta;
		$this->vUsuario= $usuario;
		$this->vPerfilUsuario= $perfil;
		$this->vIP= $ip;
		$this->vTipoUsuario= $tipo_usuario;
		$this->vPrimerAcceso= $primer_acceso;
	}
	
	/**
	 * Retorna el id del usuario.
	 *
	 * @return integer $vUsuario
	 */
	public function GetCuenta(){
		return $this->vCuenta;
	}
	
	/**
	 * Retorna el ip del usuario.
	 *
	 * @return string $vIP
	 */
	public function GetIP(){
		return $this->vIP;
	}
	
	/**
	 * Retorna el nombre del usuario.
	 *
	 * @return string $vUsuario
	 */
	public function GetUsuario(){
		return $this->vUsuario;
	}
	
	/**
	 * Retorna el rol del usuario.
	 *
	 * @return integer $vRolUsuario
	 */
	public function GetPerfil(){
		return $this->vPerfilUsuario;
	}
	
	/**
	 * Retorna el tipo de usuario.
	 *
	 * @return string $vTipoUsuario
	 */
	public function GetTipo(){
		return $this->vTipoUsuario;
	}
	
	/**
	 * Retorna el valor del primer acceso.
	 *
	 * @return integer $vPrimerAcceso
	 */
	public function GetPrimerAcceso(){
		return $this->vPrimerAcceso;
	}
	
	/**
	 * Cambia el valor del primer acceso.
	 *
	 * @return void
	 */
	public function SetPrimerAcceso($valor=""){
		if($valor!=""){
			$this->vPrimerAcceso= $valor;
		}
	}
}
?>