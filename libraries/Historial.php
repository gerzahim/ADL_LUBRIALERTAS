<?php
//Clase para registrar todas las actividades realizadas por los usuarios
class Historial{

	/**
	 * Constructor. Instancia del objeto Bd.
	 * 
	 * @access public
	 * 
	 */
	public function __construct(){ 
		$this->vFecha= "";
		$this->vHora= "";
	}
	
	/**
	 * Detecta la Hora
	 * 
	 * @access public
	 *
	 */
	public function DetectaHora(){
		return date("H:i:s");
	}
	
	/**
	 * Detecta la Fecha
	 * 
	 * @access public
	 *
	 */
	public function DetectaFecha(){
		return date("Y-m-d");
	}

   /**
    * Registrar el Evento
    * @param string $user
    * @param string $ip
    * @param string $id_evento
    * @param string $id_conexion
    * @param string $esquema
    * 
    */
	public function RegistrarEvento($user, $ip, $id_evento, $id_conexion, $esquema){
		$sql='
			INSERT INTO "'.$esquema.'"."TR001_Historial" ("IP","Fecha","Hora","id_Accion","id_Cuenta_Acceso") 
			VALUES (%? , %?, %?, %?, %?)
		';
		
		$parametro = array($ip, $this->DetectaFecha(), $this->DetectaHora(), $id_evento, $user);
 		$id_conexion->ExecuteQuery($sql, $parametro);
 		return true;
	}

   /**
    * Registrar el Evento
    * @param string $user
    * @param string $ip
    * @param string $id_evento
    * @param string $id_conexion
    * @param string $esquema
    * 
    */
	public function RegistrarEventoDetalle($user, $ip, $id_evento, $id_conexion, $esquema, $detalle){
		$sql='
			INSERT INTO "'.$esquema.'"."TR001_Historial" ("IP","Fecha","Hora","id_Accion","id_Cuenta_Acceso","detalle_accion") 
			VALUES (%? , %?, %?, %?, %?, %?)
		';
		
		$parametro = array($ip, $this->DetectaFecha(), $this->DetectaHora(), $id_evento, $user, $detalle);
 		$id_conexion->ExecuteQuery($sql, $parametro);
 		return true;
	}	

}
?>
