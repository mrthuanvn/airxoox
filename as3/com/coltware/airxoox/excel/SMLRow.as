/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	
	import com.coltware.airxoox.SpreadsheetML;
	
	
	public class SMLRow {
		
		
		private var _rowXml:XML;
		private var _ml:SpreadsheetML;
		private var _ns:Namespace;
		
		private var _rowNum:int = 0;
		
		private var _sheet:SMLWorksheet;
		
		
		public function SMLRow(sml:SpreadsheetML,sheet:SMLWorksheet,rowXml:XML) {
			_rowXml = rowXml;
			_ml = sml;
			_ns = _rowXml.namespace();
			_rowNum = int(rowXml.@r);
			_sheet = sheet;
		}
		
		public function getCellList():Array{
			var ret:Array = new Array();
			var list:XMLList = _rowXml._ns::c;
			for each(var cellXml:XML in list){
				var cell:SMLCell = new SMLCell(_ml,cellXml);
				ret.push(cell);
			}
			return ret;
		}
		
		public function getCell(alp:String,createIfNotExist:Boolean = false):SMLCell{
			var rid:String = alp.toUpperCase() + String(_rowNum);
			var _cell_xml:XML = _rowXml._ns::c.(@r == rid)[0];
			if(_cell_xml){
				var cell:SMLCell = new SMLCell(_ml,_cell_xml);
				return cell;
			}
			if(createIfNotExist){
				return addCell(alp);
			}
			return null;
		}
		
		
		/**
		*  Add cell object at the given location
		*
		* @param alphabet ex) "A" ,"C" , "AA"
		* @return The SMLCell object
		*/
		public function addCell(alp:String):SMLCell{
			var rid:String = alp.toUpperCase() + String(_rowNum);
			var _cell_xml:XML = <c></c>
			_cell_xml.@r = rid;
			_rowXml.appendChild(_cell_xml);
			return new SMLCell(_ml,_cell_xml);
		}
	}
}