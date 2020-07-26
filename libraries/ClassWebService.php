<?php
// Oculta los errores-warnings en caso de que ocurrieran, asi el usuario no los observa.
error_reporting(0);

/**
 * Clase para la manipulacion del servicio web.
 *
 */
class ClassWebService{
	
	/**
	 * Interfaz del servicio web. Ruta del servidor del servicio web.
	 *
	 * @access private
	 * @var string
	 */
	private $wsdl= "http://129.90.77.29/sigelab/ServicioWeb/servicio.php?wsdl";
	
	/**
	 * Parametros para conexion al servidor de SIGELAB. Aqui se encuentra el
	 * usuario y clave del servidor.
	 *
	 * @access private
	 * @var string
	 */
	private $options= array(
		"login"=>"deltavenservweb",
		"password"=>"123"
	);
	
	/**
	 * Objeto de conexion a servicio web.
	 *
	 * @access private
	 * @var objeto
	 */
	private $clientSigelab="";
	
	/**
	 * Interfaz del servicio web. Ruta del servidor del servicio web.
	 *
	 * @access public
	 * @return void
	 */
	public function __construct($user=false){
	
		try{
			$this->clientSigelab= new SoapClient($this->wsdl, $this->options);
			/*
			echo "<pre>";
			print_r($this->clientSigelab->__getFunctions());
			echo "</pre>";
			*/
		}
		catch(SoapFault $fault){
			//trigger_error("SOAP Fault: (faultcode: {$fault->faultcode}, faultstring: {$fault->faultstring})", E_USER_ERROR);
			if($user){
				header('location:index.php');
				exit();
			}
		}
	}
	
	/**
	 * Metodo usado para el preregistro de la solicitud.
	 *
	 * @access public
	 * @param string $codigo_solicitud
	 * @param integer $motivo_analisis
	 * @param array $muestras
	 * @return string|boolean
	 */
	public function PreRegistroSolicitud($codigo_solicitud,$motivo_analisis,$muestras){
		
		$result= $this->clientSigelab->preRegistrarSolicitud($codigo_solicitud, $motivo_analisis, $muestras);
		if(!$result->resultado){
			return $result->descripcion;
		}
		else{
			return false;
			//return $result->descripcion;
		}
	}
	
	/**
	 * Busca el listado de las solicitudes Registradas.
	 *
	 * @access public
	 * @return array|boolean
	 */
	public function ListadoSolicitudesRegistradas(){
		if( $result= $this->clientSigelab->consultarSolicitudesRegistradas() ){
			return $result->solicitud;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Busca los certificados de solicitudes terminadas de analizar.
	 *
	 * @access public
	 * @return array|boolean
	 */
	public function ConsultarCertificados(){
		if( $result= $this->clientSigelab->consultarCertificados() ){
			return $result->certificado;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Confirmacion de preregistros realizados.
	 *
	 * @access public
	 * @param array $solicitudes
	 * @return string|boolean
	 */
	public function ConfirmarPreSolicitud($solicitudes){
		$result= $this->clientSigelab->confirmarPreRegistro($solicitudes);
		if($result->resultado){
			return $result->descripcion;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Confirmacion de registros de solicitudes realizadas.
	 *
	 * @access public
	 * @param array $solicitudes
	 * @return string|boolean
	 */
	public function ConfirmarRegSolicitud($solicitudes){
		$result= $this->clientSigelab->confirmarSolicitudesRegistradas($solicitudes);
		if($result->resultado){
			return $result->descripcion;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Confirmacion de registros de solicitudes realizadas.
	 *
	 * @access public
	 * @param array $certificados
	 * @return string|boolean
	 */
	public function ConfirmarCertSolicitud($certificados){
		$result= $this->clientSigelab->confirmarCertificados($certificados);
		if($result->resultado){
			return $result->descripcion;
		}
		else{
			return false;
		}
	}
}
?>