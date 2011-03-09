/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	
	import com.coltware.airxoox.*;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	/**
	 * CELL Class
	 */
	public class SMLCell {
		
		private static var log:ILogger = Log.getLogger("com.coltware.airxoox.excel.SMLCell");
		
		public static const TYPE_BOOLEAN:String = "b";
        public static const TYPE_ERROR:String = "e";
        public static const TYPE_INLINE_STR:String = "inlineStr";
        public static const TYPE_NUMBER:String = "n";
        public static const TYPE_SHARED_STR:String = "s";
		
		private var _ml:SpreadsheetML;
		private var _xml:XML;
		private var _sharedStrings:SMLSharedStrings;
		private var _cellXml:XML;
		private var _type:String = TYPE_NUMBER;
		private var _ns:Namespace;
		
		public static const TYPE_STR:String = "str";
		
		public function SMLCell(sml:SpreadsheetML,cellXml:XML) {
			_ml = sml;
			_cellXml = cellXml;
			_ns = _cellXml.namespace();
			if(_cellXml.@t){
				_type = _cellXml.@t;
			}
			else{
				_type = TYPE_NUMBER;
			}
			_sharedStrings = sml.getSharedStrings();
		}
		
		public function getCellType():String{
			return _type;
		}
		
		/**
		*  get CELL ID
		* 
		*  ex) "A3", "C25"
		*
		*/
		public function getCellId():String{
			return _cellXml.@r;
		}
		
		public function setType(t:String):void{
			_cellXml.@t = t;
		}
		
		public function getValue():String{
			
			if(!_type){
				return this.getStringValue();
			}
			
			switch(_type){
				case TYPE_SHARED_STR:
				case TYPE_INLINE_STR:
				case TYPE_NUMBER:
					return this.getStringValue();
					break;
			}
			return "";
		}
		
		public function getStringValue():String{
			log.debug("type is " + _type);
			
			if(_type == TYPE_SHARED_STR){
				var v:XMLList = _cellXml._ns::v;
				var vv:String = v.toString();
				return _ml.getSharedStringValue(int(vv));
			}
			else if(_type == TYPE_INLINE_STR){
				return getInlineStringValue();
			}
			else{
				return _cellXml._ns::v;
			}
			return "";
		}
		
		public function setStringValue(vv:String):void{
			var idx:int = _sharedStrings.getStringIndex(vv);
			if(idx > -1){
				this.setSharedStringValue(idx);
			}
			else{
				this.setInlineStringValue(vv);
			}
		}
		
		/**
		*  set inline string
		*
		*/		
		public function setInlineStringValue(value:String):void{
			_cellXml.@t = _type = TYPE_INLINE_STR;
			_cellXml.setChildren(<is><t>{value}</t></is>);
		}
		
		protected function getInlineStringValue():String{
			var _is:XML = _cellXml.elements("is")[0];
			var ret:String = "";
			if(_is){
				var _list:XMLList = _is._ns::t;
				for each(var node:XML in _list){
					ret += node.toString();
				}
			}
			return ret;
		}
		
		/**
		*  set shared string
		*
		*/
		public function setSharedStringValue(v:int):void{
			_cellXml.@t = _type = TYPE_SHARED_STR;
			_cellXml.setChildren(<v>{v}</v>);
		}
		
		public function getNumberValue():Number{
			if(_type == TYPE_NUMBER){
				return Number(this.getStringValue());
			}
			else{
				return undefined;
			}
		}
		
		public function setNumberValue(v:Number):void{
			_cellXml.@t = _type = TYPE_NUMBER;
			_cellXml.setChildren(<v>{v}</v>);
		}
	}
}