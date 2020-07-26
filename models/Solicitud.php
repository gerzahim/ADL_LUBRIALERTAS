<?php
class Solicitud{

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
	 * @param string $esquema
	 * @return void
	 */
	public function __construct($conexion="", $esquema='public') {
		$this->vConexion= $conexion;
		$this->vEsquema= $esquema;
	}

	/**
	 * Busqueda del ID del Cliente a traves del id cuenta session.
	 *
	 * @access public
	 * @param integer $id_referencia
	 * @return boolean o integer
	 */
	public function GetIdCliente($id_referencia){
		$sql= 'SELECT "id_Cliente" FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cuenta_Acceso"=%?';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
			return $row['id_Cliente'];
		}
		else{
			return false;
		}
	}

	/**
	 * Retorna codigo generado al azar
	 *
	 * @access public
	 * @param integer $longitud
	 * @return string
	 */
	public function GenerarCodigoSolicitud($longitud=0){
		
		$sql= 'SELECT "Cod_Solicitud" FROM "'.$this->vEsquema.'"."TR001_Solicitud"	ORDER BY "id_Solicitud" DESC';
		$result= $this->vConexion->ExecuteQuery($sql);
	  	$row= $this->vConexion->GetArrayInfo($result);
		$codigo_old =$row['Cod_Solicitud'];
		
		if($codigo_old){
			unset($codigo);
			$codigo= substr($codigo_old,2,5);
			$codigo=$codigo+1;
			$codigo= str_pad($codigo, 5, "0", STR_PAD_LEFT);
			$codigo="SL".$codigo;
		}
		else{
			$codigo="SL00001";
		}
		return $codigo;
	}
	
	/**
	 * Guarda los datos de solicitud al sistema
	 *
	 * @access public
	 * @param date $fecha
	 * @param date $hora
	 * @param integer $id_cliente
	 * @param integer $Cod_Solicitud
	 * @param integer $motivo
	 * @param integer $cantidad_muestra
	 * @return boolean o integer
	 */
	public function GuardarDatosSolicitud($fecha,$hora,$id_cliente,$Cod_Solicitud,$motivo,$cantidad_muestra){
		$result= $this->vConexion->ExecuteQuery('SELECT * FROM nextval(\'"'.$this->vEsquema.'"."TR001_Solicitud_id_Solicitud_seq"\'::regclass)');
		$row= $this->vConexion->GetArrayInfo($result);
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Solicitud" 
			("id_Solicitud", "id_Cliente", "Fecha", "Hora", "Status_Solicitud", "Cod_Solicitud", "Cantidad_Muestras", "Muestras_Listas", "Motivo_Analisis") 
			VALUES(%?,%?,%?,%?,1,%?,%?,0,%?)
		';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($row['nextval'], $id_cliente, $fecha, $hora, $Cod_Solicitud, $cantidad_muestra, $motivo)) ){
			return $row['nextval'];
		}
		else{
			return false;
		}
	}
	
	/**
	 * Genera el codigo de la Muestra
	 *
	 * @access public
	 * @return string
	 */
	public function GeneraCodigoMuestra(){
		$sql= 'SELECT "Cod_Muestra" FROM "'.$this->vEsquema.'"."TR001_Muestra"	ORDER BY "id_Muestra" DESC';
		$result= $this->vConexion->ExecuteQuery($sql);
	  	$row= $this->vConexion->GetArrayInfo($result);
		$codigo_old =$row['Cod_Muestra'];
		
		if($codigo_old){
			unset($codigo);
			$codigo= substr($codigo_old,5,5);
			$codigo=$codigo+1;
			$codigo= str_pad($codigo, 5, "0", STR_PAD_LEFT);
			$codigo= date("Y")."-".$codigo."L";
		}
		else{
			$codigo= date("Y")."-00001L";
		}
		
		return $codigo;
	}

	/**
	 * Guarda los datos de las muestras al sistema
	 *
	 * @access public
	 * @param integer $id_solicitud
	 * @param integer $op_equipo
	 * @param integer $productog
	 * @param integer $horas_muestra
	 * @param integer $km
	 * @param string $Cod_Muestra
	 * @return resource or boolean
	 */
	public function GuardarDatosMuestra($id_solicitud,$op_equipo,$productog,$horas_muestra,$km,$Cod_Muestra){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Muestra" 
			("Producto_Grado","Horas","km","id_Equipo","id_Solicitud","Status_Muestra","Cod_Muestra","Carga_Parametros") 
			VALUES(%?,%?,%?,%?,%?,0,%?,0)
		';
		if( $result= $this->vConexion->ExecuteQuery($sql, array($productog,$horas_muestra,$km,$op_equipo,$id_solicitud,$Cod_Muestra)) ){
			return $result;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Regresa los valores de los campos de la tabla TR001_Equipo
	 *
	 * @access public
	 * @param integer $cliente
	 * @return resource
	 */
	public function GetEquipos($cliente){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Equipo" WHERE "Eliminado"=0';
		$parametros= array();
		
		if($cliente){
			$sql.= ' AND "id_Cliente"=%? ';
			$parametros= array_merge($parametros, array($cliente) );
		}
		
		return $this->vConexion->ExecuteQuery($sql, $parametros);
	}
	
	/**
	 * Regresa los valores de las muestras mensuales y muestras realizadas
	 *
	 * @access public
	 * @param integer $id_cliente
	 * @return array
	 */
	public function GetCantidadMuestras($id_cliente){
		$sql= '
			SELECT "Muestras_Realizadas", "Muestras_Mensuales"
			FROM "'.$this->vEsquema.'"."TR001_Cliente" WHERE "id_Cliente"=%?
		';
		$result= $this->vConexion->ExecuteQuery($sql, array($id_cliente));
		return $this->vConexion->GetArrayInfo($result); //Aqui se esta enviando el array
	}
	
	/**
	 * Actualiza la cantidad de muestras realizadas
	 *
	 * @access public
	 * @param integer $cantidad_muestra
	 * @param integer $id_cliente
	 * @return resource
	 */
	public function ActualizaMuestrasRealizadas($cantidad_muestra,$id_cliente){
		$sql='	UPDATE "'.$this->vEsquema.'"."TR001_Cliente" SET "Muestras_Realizadas"=%? WHERE "id_Cliente"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($cantidad_muestra,$id_cliente));
	}
	
	/**
	 * Actualiza la cantidad de muestras realizadas
	 *
	 * @access public
	 * @param integer $id
	 * @return resource
	 */
	public function GetSolicitudes($id=""){
	
		$parametro= array();
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Solicitud" WHERE "id_Solicitud"<>0';
		
		$sql.='AND "id_Cliente"=%?';
		$parametro= array_merge($parametro, array($id));

		//para que lo ordene de forma descendente
		$sql.= 'ORDER BY "id_Solicitud" DESC ';
		return $this->vConexion->ExecuteQuery($sql,$parametro);
	}
	
	

	/**
	 * Regresa los valores de los productos
	 *
	 * @access public
	 * @return resource
	 */
	public function GetProductos(){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Productos_Deltaven" WHERE "Eliminado"=0 ORDER BY "Nombre_Producto" ASC';
		return $this->vConexion->ExecuteQuery($sql);
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
			SELECT "Nombre_Cliente", "Direccion_Cliente", "Telefono_Oficina_Cliente", "Email", "Asesor_Comercial" 
			FROM "'.$this->vEsquema.'"."TR001_Cliente" 
			WHERE "id_Cliente"=%? 
		';
		
		$result= $this->vConexion->ExecuteQuery($sql,array($cliente));
		return $this->vConexion->GetArrayInfo($result);
	}
	/**
	 * Regresa los datos principales del cliente
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
		return $this->vConexion->GetArrayInfo($result);
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
	
	
}
?>