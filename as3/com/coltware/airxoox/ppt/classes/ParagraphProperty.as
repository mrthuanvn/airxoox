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
	
	/**
	*  5.1.5.2.7 pPr (Text Paragraph Properties)
	*
	*/
	public class ParagraphProperty {
		
		private var _xml:XML;
		private var _nsA:Namespace;
		
		private var _pct:int = -1;
		
		private static const PCT_BASE:int = 100000;
		
		public function ParagraphProperty(x:XML) {
			_xml = x;
			_nsA = x.namespace("a");
			init();
		}
		
		private function init():void{
			var list:XMLList = _xml.children();
			for each(var node:XML in list){
				var name:String = node.localName();
				if(name == "lnSpc"){
					init_lnSpc(node);
				}
			}
		}
		
		public function get pct():int{
			if(_pct > 0 ){
				return _pct/PCT_BASE;
			}
			return _pct;
		}
		
		/**
		* 5.1.5.2.5 lnSpc (Line Spacing)
		* 
		* This element specifies the vertical line spacing that is to be used within a paragraph.
		* This may be specified in two different ways, percentage spacing and font point spacing.
		* If this element is omitted then the spacing between two lines of text should be determined 
		* by the point size of the largest piece of text within a line.
		*/
		private function init_lnSpc(x:XML):void{
			var pct:Number = _get_spcPct(x);
			if(pct > 0 ){
				_pct = pct;
			}
		}
		
		private function _get_spcPct(p:XML):Number{
			var node:XML = p._nsA::spcPct[0];
			if(node){
				var val:Number = Number(node.@val);
				return val;
			}
			else{
				return -1;
			}
		}
	}

}