/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.word {
	
	import com.coltware.airxoox.element.*;
	
	public class WMLCommentRange {
		
		private var _start_node:XML;
		private var _end_node:XML;
		private var _doc:XML;
		private var _id:String;
		
		public function WMLCommentRange(id:String,doc:XML) {
			_id = id;
			_doc = doc;
		}
		
		public function getId():String{
			return _id;
		}
		
		public function set startNode(xml:XML):void{
			_start_node = xml;
		}
		public function set endNode(xml:XML):void{
			_end_node = xml;
		}
		
		public function sameParent():Boolean{
			var p1:XML = _start_node.parent();
			var p2:XML = _end_node.parent();
			return (p1 == p2);
		}
		
		public function getParagraph():WMLParagraph{
			if(sameParent()){
				var nsW:Namespace = _doc.namespace("w");
				var ref:XML = _doc..nsW::commentReference.(@nsW::id == _id)[0];
				ref = ref.parent();
				var pref:XML = ref.parent();
				var pend:XML = _end_node.parent();
				
				if(pref == pend){
					var pos:int = ref.childIndex() + 1;
					var _children:XMLList = pref.children();
					
					if(_children.length() == pos){
						var p:WMLParagraph = new WMLParagraph(_doc,pref);
						return p;
					}
				}
				else{
					trace("no match !!");
				}
			}
			return null;
		}
		
	}

}