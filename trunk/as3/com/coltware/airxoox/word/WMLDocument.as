/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.word {
	
	import flash.utils.*;
	import com.coltware.airxoox.*;
	import com.coltware.airxoox.element.WMLBody;
	
	
	public class WMLDocument {
		
		public static const CONTENT_TYPE:String = "application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml";
		
		
		private var _xml:XML;
		private var _nsW:Namespace;
		private var _word_ml:WordML;
		
		public var isUpdate:Boolean = false;
		
		public function WMLDocument(ml:WordML) {
			_word_ml =ml;
		}
		
		public function load():void{
			_xml = _word_ml.getDocumentXML();
			isUpdate = true;
			init();
		}
		
		public function getBody():WMLBody{
			var __body:XML = _xml._nsW::body[0];
			var body:WMLBody = new WMLBody(_xml,__body);
			return body;
		}
		
		public function getCommentRage(search_id:String):WMLCommentRange{
			var start:XML = _xml.._nsW::commentRangeStart.(@_nsW::id == search_id)[0]; 
			var end:XML   = _xml.._nsW::commentRangeEnd.(@_nsW::id == search_id)[0];
			if(start && end){
				var ret:WMLCommentRange = new WMLCommentRange(search_id,_xml);
				ret.startNode = start;
				ret.endNode   = end;
				return ret;
			}
			else{
				return null;
			}
		}
		
		/**
		*  no use !!
		*/
		public function getCommentRangeList():Array{
			
			var qn1:QName = new QName(_nsW,"commentRangeStart");
			var qn2:QName = new QName(_nsW,"commentRangeEnd");
			var c_start_list:XMLList = _xml.descendants(qn1);
			var c_end_list:XMLList   = _xml.descendants(qn2);
			var map:Object = new Object();
			var ret:Array = new Array();
			
			var node:XML;
			var id:String;
			var cmt:WMLCommentRange;
			for each(node in c_start_list){
				id = node.@_nsW::id;
				cmt = new WMLCommentRange(id,_xml);
				map[id] = cmt;
				cmt.startNode = node;
				ret.push(cmt);
			}
			
			for each(node in c_end_list){
				id = node.@_nsW::id;
				cmt = map[id];
				if(cmt){
					cmt.endNode = node;
				} 
			}
			
			return ret;
		}
		
		
		/**
		*  initial process
		*
		*  get namespace objects
		*/ 
		protected function init():void{
			_nsW = _xml.namespace("w");
		}
		
		public function getXML():XML{
            return _xml;
		}
		
	}

}