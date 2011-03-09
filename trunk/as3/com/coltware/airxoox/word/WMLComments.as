/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.word {
	public class WMLComments {
		
		public static const RELATION_TYPE:String = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/comments";
		
		private var _xml:XML;
        private var _nsW:Namespace;
        private var _children:Array;
        private var _map:Object;
        
        public var isUpdate:Boolean = false;
		
		public function WMLComments(xml:XML) {
			_xml = xml;
			_nsW = xml.namespace("w");
			_children = new Array();
			_map = new Object();
			init();
		}
		
		private function init():void{
			var list:XMLList = _xml._nsW::comment;
			for each(var node:XML in list){
				var c_node:WMLCommentNode = new WMLCommentNode(node);
				_children.push(c_node);
				var id:String = c_node.getId();
				_map[id] = c_node;
			}
		}
		
		public function getCommentList():Array{
			return _children;
		}
		
		public function getCommentId(text:String):String{
			for each(var node:WMLCommentNode in _children){
				var t:String = node.getText();
				if(text == t){
					return node.getId();
				}
			}
			return null;
		
		}
		
		public function getComment(id:String):WMLCommentNode{
			return _map[id];
		}
		
		
	}

}