/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.classes {
	public class XMLNodeWalk {
		
		private var _xml:XML;
		private var _start:XML;
		private var _cur:XML;
		private var _parent:XML;
		
		private var _children:XMLList = null;
		
		public function XMLNodeWalk(xml:XML) {
			_xml = xml;
		}
		
		public function startNode(node:XML):void{
			_start = node;
			_cur = node;
			_parent = node.parent();
			
		}
		
		public function next():void{
			
			if(_children){
				var pos:int = _cur.childIndex();
				_cur = _children[pos];
			}
			else{
			}
			
		}
	}

}