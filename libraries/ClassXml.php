<?php
/**
 * ClassXml - Generates a text XML encoded in UTF-8.(Genera un texto XML 
 * codificado en UTF-8).
 *
 * Copyright (C) 2008  José Luis Carpio E.
 * This program is free software: you can redistribute it and/or modify 
 * it under the terms of the GNU General Public License as published by 
 * the Free Software Foundation, either version 3 of the License, or 
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/***
 * Header of the page. Indicate a page of content XML. (Cabecera de la
 * pagina. Indica una pagina de contenido XML).
 * 
 */
header('Content-type: text/xml');


/**
 * ClassXml - Generates a text XML encoded in UTF-8.(Genera un texto XML 
 * codificado en UTF-8)
 *
 * @package ClassXml
 * @author José Luis Carpio E.
 * @copyright 2008 José Luis Carpio E.
 * @created May 2008
 * @contact jlcarpioe@gmail.com
 * @since PHP 5
 * @version 1.0
 * @see license.txt GNU General Public License 
 * Please give credit on sites that use this program and submit changes of 
 * the script so other people can use them as well. This script is free 
 * to use, don't abuse.
 */
class ClassXml{
	
	/**
	 * Content the text XML. (Contenido del texto XML).
	 * 
	 * @access private
	 * @var string $xml
	 * 
	 */
	private $xml; 
	
	
	/**
	 * Indicate a new line. (Indica una nueva linea).
	 * 
	 * @access private
	 * @var string $newLine
	 * 
	 */
	private $newLine= "\n";
	
	
	/**
	 * Constructor. Instance of the object. Here begin the header of the XML.
	 * (Constructor. Instancia del objeto. Aqui empieza el encabezado del XML)
	 * 
	 * @access public
	 *
	 */
	public function __construct(){
		$this->xml= '<?xml version="1.0" encoding="utf-8"?>';
		$this->xml.= $this->newLine;
	}
	
	
	/** 
	 * Create only the opening tag of an element. (Crea solo la etiqueta
	 * de apertura de un elemento).
	 * 
	 * @example <element>
	 * 
	 * @access public
	 * @param string $element
	 * 
	 */
	public function setOpenTag($element){
		$this->xml.= '<'.$element.'>';
		$this->xml.= $this->newLine;
	}
	
	
	/**
	 * Create only the closing tags of an element. (Crea solo la etiqueta
	 * de cierre de un elemento).
	 *
	 * @example </element>
	 * 
	 * @access public
	 * @param string $element
	 * 
	 */
	public function setCloseTag($element){
		$this->xml.= '</'.$element.'>';
		$this->xml.= $this->newLine;
	}
	
	
	/**
	 * Create a complete element through the name and content. Here is 
	 * the opening tag, content and the closing tag of the element.
	 * (Crea un elemento completo a traves del nombre y contenido. Aqui
	 * esta la etiqueta de apertura, contenido y etiqueta de cierre de
	 * un elemento). 
	 *
	 * @example <element>content</element>
	 * 
	 * @access public 
	 * @param string $element
	 * @param string $content
	 * 
	 */
	public function setElement($element,$content){
		$this->xml.= '<'.$element.'>';
		$this->xml.= utf8_encode(html_entity_decode($content));
		$this->xml.= '</'.$element.'>';
		$this->xml.= $this->newLine;
	}
	
	
	/**
	 * Return the variable with the final text XML. (Retorna lla variable 
	 * con el texto final del XML).
	 *
	 * @access public
	 * @return string $this->xml The body of the XML. (Cuerpo del XML).
	 * 
	 */
	public function getXml(){
		return $this->xml;
	}
}
?>