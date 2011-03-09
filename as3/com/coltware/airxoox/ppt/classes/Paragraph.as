/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt.classes {
	
	import flashx.textLayout.elements.*;
	
	/*
	* 5.1.5.2.6 p (Text Paragraphs)
	*
	* This element specifies the presence of a paragraph of text within the containing text body. 
	* The paragraph is the highest level text separation mechanism within a text body. 
	* A paragraph may contain text paragraph properties associated with the paragraph.
	* If no properties are listed then properties specified in the defPPr element are used.
	*
	* <complexType name="CT_TextParagraph">
	*  <sequence>
    *  <element name="pPr" type="CT_TextParagraphProperties" minOccurs="0" maxOccurs="1"/>
    *  <group ref="EG_TextRun" minOccurs="0" maxOccurs="unbounded"/>
    *  <element name="endParaRPr" type="CT_TextCharacterProperties" minOccurs="0" maxOccurs="1"/>
    *  </sequence>
    * </complexType>
	*/
	public class Paragraph {
		
		private var _xml:XML; 
		private var _nsA:Namespace;
		private var _props:ParagraphProperty = null;
		
		
		public function Paragraph(xml:XML) {
			_xml = xml;
			_nsA = xml.namespace("a");
		}
		
		public function get property():ParagraphProperty{
			if(_props){
				return _props;
			}
			
			var node:XML = _xml._nsA::pPr[0];
			if(node){
				_props = new ParagraphProperty(node);
				return _props;
			}
			return null;
		}
		
		public function createTLFParagraph():ParagraphElement{
			var p:ParagraphElement  = new ParagraphElement();
			if(property){
				if(property.pct > 0){
					var pct:int = property.pct;
					if(pct != 1){
						trace("createTLFParagraph():line-height: " + pct);
					}
				}
			}
			return p; 
		}
		
		public function getChildren():Array{
			var ret:Array = new Array();
			var list:XMLList = _xml.children();
			for each(var node:XML in list){
				var name:String = node.localName();
				switch(name){
					case "r":
						var r:RunText = new RunText(node);
						ret.push(r);
					break;
					case "br":
						var br:PBr = new PBr(node);
						ret.push(br);
					break;
				}
			}
			return ret;
		}
		
	}

}