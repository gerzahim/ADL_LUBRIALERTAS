<?php

class Cuenta{

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
	 * Busca la clave actual del usuario.
	 *
	 * @param integer $cuenta
	 * @param string $pass
	 * @return boolean
	 */
	public function VerificaClaveActual($cuenta,$pass){
		$sql= '
			SELECT "id_Cuenta_Acceso" 
			FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" 
			WHERE "id_Cuenta_Acceso"=%? AND "Password"=%? 
		';
		
		$result= $this->vConexion->ExecuteQuery($sql, array($cuenta,$pass));
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza La clave del usuario.
	 *
	 * @param integer $cuenta
	 * @param string $pass
	 * @return boolean
	 */
	public function ActualizarClaveUsuario($cuenta,$pass){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" SET "Password"=%?,"Primer_Acceso"=0 WHERE "id_Cuenta_Acceso"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($pass,$cuenta));
	}
	
	/**
	 * Busca los datos del usuario.
	 *
	 * @param integer $cuenta
	 * @param string $tipo
	 * @return boolean
	 */
	public function GetDatosUsuario($cuenta,$tipo){
		switch($tipo){
		
			case 'c':
				$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Cliente" X ON (C."id_Cuenta_Acceso"=X."id_Cuenta_Acceso") ';
				break;
				
			case 'd':
				$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Distribuidores" X ON (C."id_Cuenta_Acceso"=X."id_Cuenta_Acceso") ';
				break;
				
			case 'p':
				$inner= ' INNER JOIN "'.$this->vEsquema.'"."TR001_Personal" X ON (C."id_Cuenta_Acceso"=X."id_Cuenta_Acceso") ';
				break;
				
			default:
				$inner="";
				break;
		}
		
		$sql= '
			SELECT C."Indicador_PDVSA", X."Email"
			FROM "'.$this->vEsquema.'"."TR001_Cuenta_Acceso" C 
			'.$inner.'
			WHERE C."id_Cuenta_Acceso"=%?
		';
		
		if($result= $this->vConexion->ExecuteQuery($sql, array($cuenta))){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}

	/**
	 * Obtiene el id del cliente
	 *
	 * @access public
	 * @param integer $id_cuenta_acceso
	 * @return integer
	 */
	public function GetIdCliente($id_cuenta_acceso){
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cuenta_Acceso"=%? ';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_cuenta_acceso));
	  	$row= $this->vConexion->GetArrayInfo($result);	
		return $row['id_Cliente'];
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
		return $this->vConexion->ExecuteQuery($sql, array($passA,$cuenta));
	}					
}
?>