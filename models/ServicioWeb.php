<?php

/**
 * ServicioWeb - Clase para el modelo de los servicios web. Modifica la
 * informacion de las solicitudes segun los datos obtenidos de Sigelab.
 *
 */
class ServicioWeb{

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
	 * Actualiza el status de la solicitud. (Esto se realiza cuando se registra la 
	 * solicitud en el laboratorio de Sigelab, y esta en proceso de analisis).
	 *
	 * @access public
	 * @param integer $codigo_sigelab
	 * @param date $fecha_registro
	 * @return resource|boolean
	 */
	public function ActualizaEstatus($codigo_sigelab,$fecha_registro){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" 
			SET "Status_Solicitud"=4, "fecha_registro"=%? 
			WHERE "codigo_sigelab"=%? AND "pre_registro"=1
		';
		
		if( $result= $this->vConexion->ExecuteQuery($sql,array($fecha_registro,$codigo_sigelab)) ){
			return @pg_affected_rows($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busca las solicitudes que no han sido preRegistradas al momento
	 *
	 * @access public
	 * @return resource|boolean
	 */
	public function SolicitudSinPreRegistro(){
		$sql='
			SELECT "id_Solicitud", "id_Cliente", "Cod_Solicitud", "Motivo_Analisis", "Cantidad_Muestras" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud" 
			WHERE "pre_registro"=0
		';
		
		$result= $this->vConexion->ExecuteQuery($sql);
		if($this->vConexion->GetNumberRows($result)>0){
			return $result;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busca las muestras de la solicitud.
	 *
	 * @access public
	 * @param integer $solicitud
	 * @return resource|boolean
	 */
	public function BuscarMuestras($solicitud){
		$sql='SELECT "Cod_Muestra", "Producto_Grado" FROM "'.$this->vEsquema.'"."TR001_Muestra" WHERE "id_Solicitud"=%?';
		$result= $this->vConexion->ExecuteQuery($sql,array($solicitud));
		if($this->vConexion->GetNumberRows($result)>0){
			return $result;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza la informacion de la solicitud. Asigna el codigo sigelab a la solicitud.
	 *
	 * @access public
	 * @param integer $codigo_sigelab
	 * @param integer $solicitud
	 * @return resource|boolean
	 */
	public function ActualizaInfoSolicitud($codigo_sigelab,$solicitud){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" SET "pre_registro"=1, "codigo_sigelab"=%? WHERE "id_Solicitud"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql,array($codigo_sigelab,$solicitud)) ){
			return @pg_affected_rows($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda la informacion principal del certificado.
	 *
	 * @access public
	 * @param string $laboratorio
	 * @param string $cliente
	 * @param string $representante
	 * @param string $contacto
	 * @param string $direccion
	 * @param date $fecha_recepcion
	 * @param string $numero_informe
	 * @param date $fecha_emision
	 * @param string $numero_solicitud
	 * @param string $codigo_muestra
	 * @param string $muestra
	 * @param date $fecha_actual
	 * @param string $codigo_muestra_lubrialertas
	 * @return integer|boolean
	 */
	public function GuardaCertificado($laboratorio, $cliente, $representante, $contacto, $direccion, $fecha_recepcion, $numero_informe, $fecha_emision, $numero_solicitud, $codigo_muestra, $muestra, $fecha_actual, $codigo_muestra_lubrialertas){
		$result= $this->vConexion->ExecuteQuery('SELECT * FROM nextval(\'"'.$this->vEsquema.'"."TR001_Certificado_id_certificado_seq"\'::regclass)');
		$row= $this->vConexion->GetArrayInfo($result);
		
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Certificado" 
			("id_certificado", "laboratorio", "cliente", "representante", "contacto", "direccion", "fecha_recepcion", "numero_informe", "fecha_emision", "numero_solicitud", "codigo_muestra", "muestra", "fecha_ingreso_bd", "cod_muestra_lubrialerta") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?,%?)
		';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'],$laboratorio, $cliente, $representante, $contacto, $direccion, $fecha_recepcion, $numero_informe, $fecha_emision, $numero_solicitud, $codigo_muestra, $muestra, $fecha_actual, $codigo_muestra_lubrialertas)) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda la informacion del metodo de un certificado.
	 *
	 * @access public
	 * @param integer $id_certificado
	 * @param string $codigo_metodo
	 * @param string $nombre
	 * @param string $aprobado
	 * @return integer|boolean
	 */
	public function GuardaMetodoCertificado($id_certificado,$codigo_metodo,$nombre,$aprobado){
		$result= $this->vConexion->ExecuteQuery('SELECT * FROM nextval(\'"'.$this->vEsquema.'"."TR001_Metodo_id_metodo_seq"\'::regclass)');
		$row= $this->vConexion->GetArrayInfo($result);
		
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Metodo" 
			("id_metodo", "id_certificado", "codigo_metodo", "nombre", "aprobado") 
			VALUES(%?,%?,%?,%?,%?)
		';
		if( $result= $this->vConexion->ExecuteQuery($sql,array($row['nextval'],$id_certificado,$codigo_metodo,$nombre,$aprobado)) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda la informacion del resultado de cada metodo de un certificado.
	 *
	 * @access public
	 * @param integer $id_metodo
	 * @param string $codigo_metodo
	 * @param string $prueba
	 * @param string $resultado
	 * @param string $incertidumbre
	 * @param date $fecha_reporte
	 * @param string $observacion
	 * @return boolean
	 */
	public function GuardaResultadoMetodo($id_metodo, $codigo_metodo, $prueba, $resultado, $incertidumbre, $fecha_reporte, $observacion, $idprueba){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Resultado" 
			("id_metodo", "codigo_metodo", "prueba", "resultado", "incertidumbre", "fecha_reporte", "observacion","idprueba") 
			VALUES(%?,%?,%?,%?,%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql,array($id_metodo, $codigo_metodo, $prueba, $resultado, $incertidumbre, $fecha_reporte, $observacion, $idprueba));
	}
	
	/**
	 * Actualiza el estatus de la solicitud y de la muestra una vez obtenido los certificados.
	 *
	 * @access public
	 * @param integer $solicitud
	 * @param integer $muestra
	 * @param date $fecha
	 * @return void
	 */
	public function ActualizaEstatusResultados($solicitud,$muestra,$fecha){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Solicitud" SET "Status_Solicitud"=5, "fecha_certificado"=%? WHERE "codigo_sigelab"=%?';
		$result01= $this->vConexion->ExecuteQuery($sql,array($fecha,$solicitud));
		
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Muestra" SET "Carga_Parametros"=1 WHERE "Cod_Muestra"=%?';
		$result02= $this->vConexion->ExecuteQuery($sql,array($muestra));
	}
	
	/**
	 * Regresa los datos principales del ultimo transportista ingresado
	 *
	 * @access public
	 * @return array
	 */
	public function GetTransportista(){
		$sql= '
			SELECT "Nombre_Empresa","Persona_Contacto","Email" 
			FROM "'.$this->vEsquema.'"."TR001_Empresa_Transporte" 
			WHERE "Eliminado"=0 
			ORDER BY "id_Empresa_Transporte" DESC
		';
		
		$result= $this->vConexion->ExecuteQuery($sql);
		return $this->vConexion->GetArrayInfo($result);
	}
	
	/**
	 * Regresa los datos principales del cliente
	 *
	 * @access public
	 * @param string $id_cliente
	 * @return array
	 */
	public function GetCliente($cliente){
		$sql= '
			SELECT "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Email" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" 
			WHERE "id_Cliente"=%? 
		';
		
		$result= $this->vConexion->ExecuteQuery($sql,array($cliente));
		return $this->vConexion->GetArrayInfo($result);
	}
	/**
	 * Regresa los datos principales del asesor técnico
	 *
	 * @access public
	 * @param string $id_cliente
	 * @return array
	 */
	public function GetPersonal(){
		$sql= '
			SELECT "Email", "Nombres_Apellidos" 
			FROM "'.$this->vEsquema.'"."TR001_Personal" 
			WHERE "Cargo"=2  
		';
		$result= $this->vConexion->ExecuteQuery($sql);
				
		if($this->vConexion->GetNumberRows($result)>0){
			return $result;
		}
		else{
			return false;
		}
	
		
	}
	/**
	 * Regresa email del asesor
	 *
	 * @access public
	 * @param string $id_cliente
	 * @return array
	 */
	public function GetEmailAsesor($id_asesor){
		$sql= '
			SELECT "Email", "Nombres_Apellidos" 
			FROM "'.$this->vEsquema.'"."TR001_Personal" 
			WHERE "id_Personal"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql,array($id_asesor));
		return $this->vConexion->GetArrayInfo($result);
	}
		
			/**
	 * Regresa los datos principales del ultimo transportista ingresado
	 *
	 * @access public
	 * @return array
	 */
	public function VerificarMetodo($id_metodo,$codigo_metodo){
		$sql= '
			SELECT "id_certificado", "codigo_metodo"
			FROM "'.$this->vEsquema.'"."TR001_Metodo" 
			WHERE "id_certificado"=%? AND "codigo_metodo"=%?
			';
		$result= $this->vConexion->ExecuteQuery($sql,array($id_metodo,$codigo_metodo));
		return $this->vConexion->GetArrayInfo($result);
		
	}
	/**
	*/
	public function GetIdSolicitud($codigo_muestra){
		$sql= '
			SELECT "id_Solicitud"
			FROM "'.$this->vEsquema.'"."TR001_Muestra" 
			WHERE "Cod_Muestra"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql,array($codigo_muestra));
		return $this->vConexion->GetArrayInfo($result);
	}
		/**
	 * Retorna codigo generado al azar
	 *
	 * @access public
	 * @param integer $longitud
	 * @return string
	 */
	public function GetIdCliente($id_solicitud){
		
		$sql= '
			SELECT "id_Cliente" 
			FROM "'.$this->vEsquema.'"."TR001_Solicitud"
			WHERE "id_Solicitud"=%? 
		';
		$result= $this->vConexion->ExecuteQuery($sql,array($id_solicitud));
		return $this->vConexion->GetArrayInfo($result);
	}	
	
		
}

?>