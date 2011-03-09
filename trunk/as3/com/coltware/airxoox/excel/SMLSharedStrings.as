/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	public class SMLSharedStrings {
		
		public static const FILENAME:String = "xl/sharedStrings.xml";
		
		private var _xml:XML;
		private var _ns:Namespace;
		
		private var _siList:Array;
		private var _wordList:Array;
		
		public var isUpdate:Boolean = false;
		
		public function SMLSharedStrings(xml:XML) {
			_xml = xml;
			_ns = _xml.namespace();
			init();
		}
		
		private function init():void{
			_siList = new Array();
			_wordList = new Array();
			var list:XMLList = _xml._ns::si;
			for each(var node:XML in list){
				_siList.push(node);
				var t:XML = node._ns::t[0];
				if(t){
					_wordList.push(t.toString());
				}
				else{
					var tt:String = getRichTextStringValue(node);
					_wordList.push(tt);
				}
			}
		}
		
		public function getStringValue(index:int):String{
			var si:XML = _siList[index];
			if(si){
				var t:XML = si._ns::t[0];
				if(t){
					return t.toString();
				}
				else{
					return getRichTextStringValue(si);
				}
			}
			return "";
		}
		
		public function getStringIndex(v:String):int{
			var idx:int = _wordList.indexOf(v);
			return idx;
		}
		
		protected function getRichTextStringValue(node:XML):String{
			var rlist:XMLList = node._ns::r;
			var ret:String = "";
			for each(var rnode:XML in rlist){
				var t:XML = rnode._ns::t[0];
				if(t){
					ret += t.toString();
				}
			}
			trace(ret);
			return ret;
		}
	}

}