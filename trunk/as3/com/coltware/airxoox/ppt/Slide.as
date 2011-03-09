/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt {
	
	import coltware.airxoox.*;
	import com.coltware.airxoox.ppt.*;
	import com.coltware.airxoox.ppt.classes.*;
	
	public class Slide {
		
		public static const RELATION_TYPE:String = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide";


		private var _xml:XML;
		private var _nsP:Namespace;
		
		public function Slide(xml:XML) {
			_xml = xml;
			_nsP = xml.namespace("p");
		}
		
		public function getShapeTree():ShapeTree{
			var node:XML = _xml.._nsP::spTree[0];
			if(node){
				var spTree:ShapeTree = new ShapeTree(node);
				return spTree;
			}
			return null;
		}
		
		/**
		*  スライドにあるShapeListをすべて取得する
		*
		*/
		public function getShapeDescendants():Array{
			var ret:Array = new Array();
			var spList:XMLList = _xml.._nsP::sp;
			for each(var node:XML in spList){
				var sp:PShape = new PShape(node);
				ret.push(sp);
			}
			return ret;
		}
		
		public function toString():String{
			return _xml.toXMLString();
		}
	}

}