/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt {
	
	import com.coltware.airxoox.*;
	
	public class PPTRoot {
		
		public static const TYPE:String = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument";
		
		private var _ppt:PresentationML;
		private var _xml:XML;
		private var _nsP:Namespace;
		private var _nsR:Namespace;
		
		public function PPTRoot(xml:XML,pptML:PresentationML) {
			_nsP = xml.namespace("p");
			_nsR = xml.namespace("r");
			_xml = xml;
			_ppt = pptML;
		}
		
		public function getSlideIdList():Array{
			var ret:Array = new Array();
			var list:XMLList = _xml._nsP::sldIdLst._nsP::sldId;
			for each(var node:XML in list){
				var relId:String = node.@_nsR::id;
				ret.push(relId);
			}
			return ret;
		}
		
		public function getSlideSize():Size{
			var node:XML = _xml._nsP::sldSz[0];
			var cx:uint = uint(node.@cx);
			var cy:uint = uint(node.@cy);
			var size:Size = new Size(cx,cy);
			return size;
		}
		
	}

}