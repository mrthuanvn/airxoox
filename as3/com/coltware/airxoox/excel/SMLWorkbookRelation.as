/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	
	public class SMLWorkbookRelation {
		
		public static const FILENAME:String = "xl/_rels/workbook.xml.rels";
		
		private var _xml:XML;
		private var _ns:Namespace;
		private var _maxId:Number = 0;
		
		public var isUpdate:Boolean = true;
		
		public function SMLWorkbookRelation(xml:XML) {
			_xml = xml;
			_ns = _xml.namespace();
			init();
		}
		
		public function getFilename(rid:String):String{
			var target:Object = _xml._ns::Relationship.(@Id == rid).@Target;
			return target.toString();
		}
		
		public function addId():Number{
			_maxId = _maxId + 1;
			return _maxId;
		}
		
		
		/**
		*
		*  return rId
		*/
		public function addSheet(filename:String):String{
			var rid:String = "rId" + addId();
			var type:String = SMLWorksheet.TYPE;
			var node:XML = <Relationship Id={rid} Type={type} Target={filename} xmlns={_ns} />
			_xml.appendChild(node);
			isUpdate = true;
			return rid;
			
		}
		
		public function getXML():XML{
			return _xml;
		}
		
		private function init():void{
			var list:XMLList = _xml._ns::Relationship;
			for each(var node:XML in list){
				var _id:String = node.@Id;
				if(_id){
					var pos:int = _id.indexOf("rId");
					if(pos > -1){
						var nstr:String = _id.substr(pos + 3);
						var n:Number = Number(nstr);
						if(n){
							if(_maxId < n ){
								_maxId = n;
							}
						}
					}
				}
			}
		}
		
		
	}

}