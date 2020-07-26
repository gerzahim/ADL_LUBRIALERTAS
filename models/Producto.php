<?php

class Producto{

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
	 * Busqueda de todos los productos.
	 *
	 * @param integer  $cantidad
	 * @param  integer $pagina
	 * @param  string $nombre
	 * @param  string $codigo
	 * @return array
	 */
	public function GetListado($cantidad,$pagina,$nombre=false,$codigo=false){
		// Datos para la paginacion
		$inicial= ($pagina-1) * $cantidad;
		
		$sql= '
			SELECT * 
			FROM "'.$this->vEsquema.'"."TR001_Productos_Deltaven" 
			WHERE "Eliminado"=0 ';
		$parametros= array();
		
		// Para la busqueda
		if($nombre){
			$sql.= ' AND "Nombre_Producto" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$nombre.'%') );
		}
		
		if($codigo){
			$sql.= ' AND "Codigo_Producto" LIKE %? ';
			$parametros= array_merge($parametros, array('%'.$codigo.'%') );
		}
		
		// SQL final
		$sql.= ' ORDER BY "Codigo_Producto"';
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		
		// Datos para la paginacion
		$total_registros= $this->vConexion->GetNumberRows($result);
		if($cantidad!=0){
			$total_paginas= ceil($total_registros / $cantidad);
		}
		else{
			$total_paginas= 0;
		}
		
		// Nuevo SQL
		$sql.=" LIMIT ".$cantidad." OFFSET ".$inicial."";
		$result=  $this->vConexion->ExecuteQuery($sql, $parametros);
		
		return array('pagina'=>$pagina,'total_paginas'=>$total_paginas,'total_registros'=>$total_registros,'result'=>$result);
	}
	
	/**
	 * Actualiza el producto como eliminado.
	 *
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function ActualizaEstatusEliminado($id_referencia){
		$sql='UPDATE "'.$this->vEsquema.'"."TR001_Productos_Deltaven" SET "Eliminado"=1 WHERE "id_Producto"=%?';
		return $this->vConexion->ExecuteQuery($sql, array($id_referencia));
	}
	
	/**
	 * Verifica si el codigo esta repetido.
	 *
	 * @param string $codigo
	 * @param integer $id_referencia
	 * @return boolean
	 */
	public function VerificaCodigoRepetido($codigo, $id_referencia=""){
		$sql= 'SELECT "id_Producto" FROM "'.$this->vEsquema.'"."TR001_Productos_Deltaven" WHERE "Codigo_Producto" LIKE %?';
		$parametros= array($codigo);
		
		if(!empty($id_referencia)){
			$sql.= ' AND "id_Producto"<>%?';
			$parametros= array($codigo, $id_referencia);
		}
		
		$result= $this->vConexion->ExecuteQuery($sql, $parametros);
		if($this->vConexion->GetNumberRows($result)>0){
			return true;
		}
		else{
			return false;
		}
	}
	
	/**
	 * Guarda los datos de informacion del producto.
	 *
	 * @param string $nombre
	 * @param string $codigo
	 * @param string $descripcion
	 * @return boolean
	 */
	public function GuardarDatosProducto($nombre,$codigo,$descripcion){
		$sql= '
			INSERT INTO "'.$this->vEsquema.'"."TR001_Productos_Deltaven" 
			("Nombre_Producto", "Descripcion_Producto", "Codigo_Producto", "Eliminado") 
			VALUES(%?,%?,%?,%?)
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$descripcion,$codigo,'0') );
	}
	
	/**
	 * Busca los datos del producto.
	 *
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetDatosProducto($id_referencia){
		$sql= 'SELECT * FROM "'.$this->vEsquema.'"."TR001_Productos_Deltaven" WHERE "id_Producto"=%?';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			return $this->vConexion->GetArrayInfo($result);
		}
		else{
			return false;
		}
	}
	
	/**
	 * Actualiza la informacion del producto.
	 *
	 * @param string $nombre
	 * @param string $codigo
	 * @param string $descripcion
	 * @param integer $id
	 * @return boolean
	 */
	public function ActualizarDatosProducto($nombre,$codigo,$descripcion,$id){
		$sql='
			UPDATE "'.$this->vEsquema.'"."TR001_Productos_Deltaven" 
			SET "Nombre_Producto"=%?, "Descripcion_Producto"=%?, "Codigo_Producto"=%? 
			WHERE "id_Producto"=%?
		';
		return $this->vConexion->ExecuteQuery($sql, array($nombre,$descripcion,$codigo,$id));
	}
	/**
	 * Busca los datos del producto.
	 *
	 * @param integer $id_referencia
	 * @return boolean or array
	 */
	public function GetCodProducto($id_referencia){
		$sql= 'SELECT "Codigo_Producto" FROM "'.$this->vEsquema.'"."TR001_Productos_Deltaven" WHERE "id_Producto"=%?';
		
		if( $result= $this->vConexion->ExecuteQuery($sql, array($id_referencia)) ){
			$row= $this->vConexion->GetArrayInfo($result);
		   return $row['Codigo_Producto'];
		}
		else{
			return false;
		}
	}	
}
?>