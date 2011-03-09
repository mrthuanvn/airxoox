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
 	* 5.1.5.3.8 r (Text Run)
 	*
 	* <complexType name="CT_RegularTextRun">
 	* <sequence>
 	* <element name="rPr" type="CT_TextCharacterProperties" minOccurs="0" maxOccurs="1"/>
	* <element name="t" type="xsd:string" minOccurs="1" maxOccurs="1"/>
 	* </sequence>
 	* </complexType>
 	*/
	public class RunText extends PNode{
		
		public function RunText(xml:XML){
			super(xml);
		}
		
		/**
		*  RunTextの中には必ず1つのt要素がある。
		*/
		override public function get text():String{
			var tnode:XML = xml.nsA::t[0];
			return tnode.toString(); 
		}
		
		
		
		override public function createTLFSpan():SpanElement{
			var span:SpanElement = new SpanElement();
			span.text = text;
			_set_tlf_property(span);
			return span;
		}
		/**
		*  5.1.5.3.9 rPr (Text Run Properties)
		*
		*/
		private function _set_tlf_property(span:SpanElement):void{
			var node:XML = xml.nsA::rPr[0];
			if(node){
				var szStr:String = node.@sz;
				if(szStr){
					var sz:int = int(szStr)/100;
					span.fontSize = sz;
				}
				
				var children:XMLList = node.children();
				for each(var child:XML in children){
					var name:String = child.localName();
					if(name == "solidFill"){
						for each(var child2:XML in child.children()){
							var name2:String = child2.localName();
							if(name2 == "srgbClr"){
								var clrStr:String = child2.@val;
								if(clrStr){
									span.color = "#" + clrStr;
								}
							}
						}
					} //  END: solidFilld
					else if(name == "ea"){
						// 5.1.5.3.3 ea (East Asian Font) p.3422
						var typeface:String = child.@typeface;
						if(typeface){
							span.fontFamily = typeface;
						}
					}
				}
				
			}
		}
		
	}

}