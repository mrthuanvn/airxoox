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
	
	public class SMLWorkbook {
		
		public static const CONTENT_TYPE:String = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml";
		
		private var _xml:XML;
		private var _ml:SpreadsheetML;
		private var _filename:String;
		
		private var _maxSheetId:Number = 0;
		
		private var _ns:Namespace;
		private var _nsR:Namespace;
		
		private var _sheetList:Array;
		
		public var isUpdate:Boolean = false;
		
		public function SMLWorkbook(ml:SpreadsheetML,xml:XML) {
			_ml = ml;
			_xml = xml;
			init();
		}
		
		public function setFilename(filename:String):void{
			_filename = filename;
		}
		public function getFilename():String{
			return _filename;
		}
		
		
		
		public function getSheetList():Array{
			return _sheetList;
		}
		
		/**
		*  get worksheet
		*
		*  @sample
		*  var sheet:SMLWorksheet = wb.getSheetAt(0);
		*/  
		public function getSheetAt(num:int):SMLWorksheet{
			if(_sheetList.length > num){
				return _sheetList[num];
			}
			else{
				return null;
			}
		}
		
		public function addSheet(name:String = null):SMLWorksheet{
			
			isUpdate = true;
			
			var p_xml:XML = _xml._ns::sheets[0];
			var blankSheet:BlankSheet = new BlankSheet();
			var newSheet_xml:XML = blankSheet.create();
			
			_maxSheetId++;
			if(name == null){
				name = "Sheet" + _maxSheetId;
			}
			var sheetId:String = String(_maxSheetId);
			var rId:String = _ml.addSheetEntry(name,sheetId);
			
			var sheet:SMLWorksheet = new SMLWorksheet(_ml,rId);
			sheet.loadXML(newSheet_xml);
			
			sheet.isUpdate = true;
			_sheetList.push(sheet);
			
			return sheet;
		}
		
				
		
		protected function init():void{
			_ns = _xml.namespace();
			_nsR = _xml.namespace("r");
			_sheetList = new Array();
			//  parse sheet list
			var _list:XMLList = _xml._ns::sheets._ns::sheet;
            for each(var node:XML in _list){
            	
            	var sheetId:String = node.@sheetId;
            	var sheetId_num:Number = Number(sheetId);
            	if(_maxSheetId < sheetId_num){
            		_maxSheetId = sheetId_num;
            	}
            	
                var sheet:SMLWorksheet = new SMLWorksheet(_ml,node.@_nsR::id);
                sheet.setName(node.@name);
                _sheetList.push(sheet);
            }
		}
		
		public function getXML():XML{
			return _xml;
		}
	}

}