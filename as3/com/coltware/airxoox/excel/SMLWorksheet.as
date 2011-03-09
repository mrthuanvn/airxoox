/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	import mx.logging.ILogger;
	import mx.logging.Log;

	import com.coltware.airxoox.*;
	import com.coltware.airxoox.airxoox_internal;
	
	use namespace airxoox_internal;
	
	public class SMLWorksheet {
		
		private static var log:ILogger = Log.getLogger("com.coltware.airxoox.excel.SMLWorksheet");
		
		public static const CONTENT_TYPE:String = "application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml";
		public static const TYPE:String         = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet";
		
		private var _rId:String;
		private var _name:String;
        private var _ml:SpreadsheetML;
        private var _xml:XML;
        
        private var _ns:Namespace;
        
        public var isUpdate:Boolean = false;
		
		private var _load:Boolean = false;
		
		/**
		*
		*  @param SpreadsheetML Object
		*  @param XML Node of "/ml/workbook.xml"sheet
		*/ 
		public function SMLWorksheet(sml:SpreadsheetML,rId:String) {
			_ml = sml;
			_rId = rId;
		}
		
		public function setName(name:String):void{
			_name = name;
		}
		
		public function get name():String{
			return _name;
		}
		
		public function getRId():String{
			return _rId;
		}
		
		/**
		*
		*
		*/
		public function load():void{
			_xml = _ml.getSheetXML(_rId);
			_ns = _xml.namespace();
			
			//  @TODO
			isUpdate = true;
			
			this._load = true;
		}
		
		public function loadXML(xml:XML):void{
			_xml = xml;
			_ns = _xml.namespace();
		}
		
		public function getRowList():Array{
			var list:XMLList = _xml._ns::sheetData._ns::row;
			var arr:Array = new Array();
			for each(var row:XML in list){
				var smlrow:SMLRow = new SMLRow(_ml,this,row);
				arr.push(smlrow);
			}
			return arr;
		}
		
		public function getRow(index:int):SMLRow{
			if(index < 1){
				throw new Error("getRow arg starts '1'");
			}
			
			var indexStr:String = String(index);
			var rowXml:XML = _xml._ns::sheetData._ns::row.(@r == indexStr)[0];
			if(rowXml){
				var row:SMLRow = new SMLRow(_ml,this,rowXml);
				return row;
			}
			return null;
		}
		
		/**
		 *  Add or Get Row Object
		 * 
		 */
		public function addRow(index:int):SMLRow{
			var row:SMLRow = this.getRow(index);
			if(row){
				return row;
			}
			var row_list:XMLList = _xml._ns::sheetData._ns::row;
			for each(var row_xml:XML in row_list){
				var num:int = int(row_xml.@r);
				
				if(num > index){
					log.debug("addRow insertChildBefore(" + num + "," + index + ")");
					var _new_xml:XML = <row></row>
					_new_xml.@r = index;
					_xml._ns::sheetData.insertChildBefore(row_xml,_new_xml);
					return new SMLRow(_ml,this,_new_xml);
				}
			}
			log.debug("addRow newLastRow(" + index + ")");
			var _row_xml:XML = <row></row>
			_row_xml.@r = index;
			_xml._ns::sheetData.appendChild(_row_xml);
			return new SMLRow(_ml,this,_row_xml);
		}
		/**
		*
		*  @return The SMLRow object 
		*/
		public function createLastRow():SMLRow{
			var rows:XMLList = _xml._ns::sheetData._ns::row;
			var len:int = rows.length() -1;
			
			var row_xml:XML = <row></row>
			row_xml.@r = int(rows[len].@r) + 1;
			
			_xml._ns::sheetData.appendChild(row_xml);
			
			return new SMLRow(_ml,this,row_xml);
		}
		
		
		
		/**
		 *  Get Cell Object
		 * 
		 *  ex) getCell("A2");
		 */
		public function getCell(cellId:String):SMLCell{
			if(!this._load){
				this.load();
			}
			
			var cellXml:XMLList = _xml._ns::sheetData._ns::row._ns::c.(@r == cellId);
			if(cellXml.length() > 0){
				var cell:SMLCell = new SMLCell(_ml,cellXml[0]);
				return cell;
			}
			return null;
		}
		
		airxoox_internal function getXML():XML{
			return _xml;
		}
	}

}