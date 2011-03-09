/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt.classes {
	public class ShapeTree {
		
		private var _xml:XML;
		private var _nsP:Namespace;
		
		
		public function ShapeTree(xml:XML) {
			_xml = xml;
			_nsP = xml.namespace("p");
		}
		
		public function getShapeList():Array{
			var ret:Array = new Array();
			var spList:XMLList = _xml._nsP::sp;
			for each(var node:XML in spList){
				var sp:PShape = new PShape(node);
				ret.push(ret);
			}
			return ret;
		}
		
		public function toString():String{
			return _xml.toXMLString();
		}
		
	}

}