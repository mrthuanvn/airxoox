/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.element {
	public class WMLNode {
		
		protected var _nodeXml:XML;
		protected var _rootXml:XML;
		protected var _nsW:Namespace;
		protected var _nsR:Namespace;
		
		public function WMLNode(rootXml:XML,nodeXml:XML){
			_nodeXml = nodeXml;
			_rootXml = rootXml;
			_nsW = rootXml.namespace("w");
			_nsR = rootXml.namespace("r");
		}
		
		public function getChildren():Array{
		  return null;
		}
		
		public function getRunList():Array{
			var arr:Array = new Array();
			var list:XMLList = _nodeXml._nsW::r;
			
			for each(var n:XML in list){
				var r:WMLRun = new WMLRun(_rootXml,n);
				arr.push(r);
			}
			return arr;
		}
		
		public function getTextElements():Array{
			var arr:Array = new Array();
			var runList:Array = this.getRunList();
			for(var i:int = 0; i<runList.length; i++){
				var runNode:WMLRun = runList[i];
				var texts:Array = runNode.getTextElements();
				arr = arr.concat(texts);
				
			}
			return arr;
		}
		
		
		public function toString():String{
			return _nodeXml.toString();
		}
		
		public function toXMLString():String{
			return _nodeXml.toXMLString();
		}
		
		public function getXML():XML{
			return _nodeXml;
		}
		
		public function deleteNode():void{
			delete _nodeXml.(true)[0];
		}
		
		
	}
}