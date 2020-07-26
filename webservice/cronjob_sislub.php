<?php

// Deben tener los mismos datos que la carpeta de configuracion del sistema
$vHost= "METLTQ86";
$vPort= "5432";
$vDataBase= "sislub";
$vUsuario= "sislub_usr";
$vClave= "pdvsa08";
$vEsquema= "public";

class Bd{
	/**
	 * Nombre de la base de datos a conectar
	 *
	 * @var string
	 */
	protected  $vBaseDato;
	
	/**
	 * Valor del servidor a conectar
	 *
	 * @var string
	 */
	protected $vServidor;
	
	/**
	 * Usuario autorizado a conestarse
	 *
	 * @var string
	 */
	protected $vUsuario;
	
	/**
	 * Clave del usuario autorizado
	 *
	 * @var string
	 */
	protected $vClave;
	
	/**
	 * Identificador de Conexion
	 *
	 * @var integer
	 */
	protected $vIdConexion = 0;
	
	/**
	 * Identificador de Consulta
	 *
	 * @var integer
	 */
	protected $vIdConsulta = 0;
	
	/**
	 * Texto Error 
	 *
	 * @var string
	 */
	public $vTextError = "";

	/**
	 * Puerto de conexi&oacute;n
	 * 
	 * @access public
	 * 
	 */
	 protected $vPort;
	 
	/**
	 * Constructor. Instancia del objeto Bd.
	 * 
	 * @access public
	 * 
	 */
	public function __construct(){ 
		$this->vBaseDato= ""; 
		$this->vServidor= ""; 
		$this->vUsuario= ""; 
		$this->vClave= "";
		$this->vIdConexion= "";
		$this->vTextError= "";
		$this->vPort= "";
	}
	
	/**
	 * Destruye la conexion.
	 * 
	 * @access public
	 *
	 */
	public function __destruct(){
		$this->CloseConexion();
	}
	
   /**
    * Conecta a la base de datos.
    *
    * @param string $server
    * @param string $port
    * @param string $db
    * @param string $user
    * @param string $pass
    * @return resource $id_conexion
    * 
    */
	public function ConnectDataBase($server, $port, $db, $user, $pass){
		
		// Variables de conexion
		$this->vServidor= $server;
		$this->vBaseDato= $db;
		$this->vUsuario= $user;
		$this->vClave= $pass;
		$this->vPort= $port;
		
		// Conecta al servidor
		if(!$this->vIdConexion= @pg_connect("host=".$this->vServidor." port=".$this->vPort." dbname=".$this->vBaseDato." user=".$this->vUsuario." password=".$this->vClave)){
			$this->vTextError= "Imposible conexi&oacute;n a la base de datos. Por favor reintente m&aacute;s tarde...";
			return false;
		}
		
		return $this->vIdConexion; 
	}
	
	/**
	 * Cierre de la conexion.
	 * 
	 * @access public
	 * 
	 */
	public function CloseConexion(){
		@pg_close($this->vIdConexion);
	}
	
	/**
	 * Ejecuta la consulta.
	 *
	 * @access public
	 * @param string $sql
	 * @return resource $id_consulta
	 * 
	 */
	public function ExecuteQuery($sql="", $params=""){  
		
		// Si el SQL esta vacio no ejecuta nada
		if($sql==""){
			$this->vTextError= "No ha especificado una consulta SQL";
			return false;
		}
		
		// Limpia los parametros
		$query= $this->CleanParameters($sql,$params);
		//echo $query."<br>";
		// Ejecuta la consulta
		if( !$this->vIdConsulta= @pg_query($this->vIdConexion, $query) ){
			$this->vTextError= "No se ha podido ejecutar una consulta SQL - ".@pg_last_error();
			return false;
		}
		
		return $this->vIdConsulta;
	}

	/**
	 * Devuelve el numero de campos de una consulta.
	 *
	 * @access public
	 * @param resource $result
	 * @return integer $total
	 * 
	 */
	public function GetNumberFields($result){
		if(is_resource($result)){
			$total= @pg_num_fields($result);
		}
		else{
			$total=0;
		}
		return $total;
	}

	/**
	 * Devuelve el numero de registros de una consulta.
	 * 
	 * @access public
	 * @param resource $result
	 * @return integer $total
	 * 
	 */
	public function GetNumberRows($result){
		if(is_resource($result)){
			$total= @pg_num_rows($result);
		}
		else{
			$total=0;
		}
		return $total;
	}
	
	/**
	 * Devuelve el nombre de un campo.
	 * 
	 * @param resource $result
	 * @param integer $num_campo
	 * @return string $name
	 * 
	 */
	public function GetFieldName($num_campo, $result=""){
		if(is_resource($result)){
			$name= @pg_field_name($num_campo, $result);
		}
		else{
			$name="";
		}
		return $name;
	} 

	/**
	 * Devuelve un array con los campos del resultado.
	 *
	 * @param resource $result
	 * @return array $array
	 * 
	 */
	public function GetArrayInfo($result){
		if(is_resource($result)){
			$array= @pg_fetch_assoc($result);
		}
		else{
			$array="";
		}
		return $array;
	}
	
	/**
	 * Devuelve el ID del ultimo elemento insertado
	 *
	 * @return integer
	 * 
	 */
	public function GetLastInsert($result){
		if(is_resource($result)){
			return @pg_last_oid($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Limpia los parametro dados y devuelve el SQL final
	 *
	 * @param string $query
	 * @param array $values
	 * @return string $sql
	 * 
	 */
	private function CleanParameters($query, $values){
		
		// Si no hay arreglo devuelve el query 
		if(!is_array($values) || !count($values)){
			return $query;
		}
		
		// Divide el query en trozos
		$trozos= explode("%?", $query);
		$sql= $trozos[0];
		
		// Completa el query con los parametros dados
		for($i=0; $i < count($values); $i++){
			
			// Limpia el parametro
			if($values[$i] || $values[$i]==0){
				
				// Retira las barras
				$arg= stripslashes($values[$i]);
				
				// Escapa caracteres especiales
				if(is_numeric($arg)){
					$parametro= $arg;
				}
				else{
					$parametro= "'".pg_escape_string($arg)."'";
				}
			}
			else{
				$parametro= 'NULL';
			}
			
			$sql.= $parametro.$trozos[$i+1];
		}
		
		return $sql;
	}

	
}

$obj_conexion= new Bd();
$obj_conexion->ConnectDataBase($vHost, $vPort, $vDataBase, $vUsuario, $vClave);

	//SQL PARA REVISAR QUIEN ESTA CONECTADO
		$sql= '
			SELECT "id_Cuenta_Acceso"
			FROM "'.$vEsquema.'"."TR001_Cuenta_Acceso"
			WHERE "Conectado"=1 
		';
		$result= $obj_conexion->ExecuteQuery($sql);
	//
	
	// While para recorrer todos los conectados y evaluar su situacion
	while($row= $obj_conexion->GetArrayInfo($result)){
	
			$id_ca= $row['id_Cuenta_Acceso'];
			
			//echo $id_ca. " Id Cuenta de Acceso <br>";
			
			//SQL PARA SABER LA HORA DE LA ULTIMA VEZ QUE SE CONECTO SEGUN ID DE ACCESO
			$sqla= '
				SELECT "Fecha", "Hora"
				FROM "'.$vEsquema.'"."TR001_Historial"
				WHERE "id_Cuenta_Acceso"= '.$id_ca.'
				ORDER BY "id_Historial" DESC
			';
			
			$resulta= $obj_conexion->ExecuteQuery($sqla);
			
			$rew= $obj_conexion->GetArrayInfo($resulta);
			
    		$fechaGuardada= $rew['Fecha']." ".$rew['Hora'];
			$ahora= date("Y-m-j H:i:s");
			
			
			//tiempo transcurrido en segundos
			$tiempo_transcurrido= (strtotime($ahora) - strtotime($fechaGuardada));
			
			//tiempo_transcurrido en dias
			//$dias_diferencia = $tiempo_transcurrido / (60 * 60 * 24); 
									
			//echo $tiempo_transcurrido. " Tiempo Transcurrido<br>";
					
			if ($tiempo_transcurrido>= 300){
				//echo " Ya pasaron 5 minutos sin actividad por lo tanto se Desconecta el usuario";
				$sqlb=' UPDATE "'.$vEsquema.'"."TR001_Cuenta_Acceso" SET "Conectado"=0 WHERE "id_Cuenta_Acceso"= '.$id_ca.' ';
				$resulto= $obj_conexion->ExecuteQuery($sqlb);
			}
			else{
					//echo " El usuario todavia esta activo no se puede Desconectar, porque tiene movimientos recientes en el sistema";
			}
		//echo "<br>///////////////////////////////////////////////////////////////////<br>";
	} 	
?>
