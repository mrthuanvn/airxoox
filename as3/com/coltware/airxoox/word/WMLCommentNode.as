/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.word {
	public class WMLCommentNode {
		
		private var _xml:XML;
		private var _nsW:Namespace;
		
		private var _id:String;
		private var _author:String;
		private var _date:String;
		private var _text:String;
		
		public function WMLCommentNode(xml:XML) {
			_xml = xml;
			_nsW = xml.namespace("w");
			init();
		}
		
		private function init():void{
			_id = _xml.@_nsW::id;
			_author = _xml.@_nsW::author;	
			var qn:QName = new QName(_nsW,"t");
			var t_list:XMLList = _xml._nsW::p.descendants(qn);
			for each(var t:XML in t_list){
				_text = t.toString();
			}
		}
		
		public function getId():String{
			return _id;
		}
		
		public function getAuthor():String{
			return _author;
		}
		
		public function getText():String{
			return _text;
		}
	}

}