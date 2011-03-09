/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox {
	
	import com.coltware.airxoox.classes.OoxML;
	import com.coltware.airxoox.core.AppProps;
	import com.coltware.airxoox.core.ContentTypes;
	import com.coltware.airxoox.excel.*;
	import com.coltware.airxoox.excel.SMLSharedStrings;
	import com.coltware.airxoox.excel.SMLWorkbook;
	import com.coltware.airxoox.excel.SMLWorksheet;
	import com.coltware.airxzip.*;
	
	import flash.events.*;
	import flash.filesystem.*;
	import flash.utils.*;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	use namespace airxoox_internal;
	
	public class SpreadsheetML extends OoxML{
		
		private static var log:ILogger = Log.getLogger("com.coltware.airxoox.SpreadsheetML");
		
		private var _relation:SMLWorkbookRelation;
		private var _workbook:SMLWorkbook;
		private var _sharedString:SMLSharedStrings;
		
		public function SpreadsheetML() {

		}
		
		/**
		*   
		*
		*/
		override protected function loadOnStartup(filename:String, entry:ZipEntry):Boolean{
			
			if(filename == SMLWorkbookRelation.FILENAME){
				    _relation = new SMLWorkbookRelation(getEntryXML(entry));
			}
			else if(filename == SMLSharedStrings.FILENAME){
                   _sharedString = new SMLSharedStrings(getEntryXML(entry));
			}
			return false;
		}
		
		override public function saveFile(file:File):void{
			
			var filename:String;
			
			if(_workbook.isUpdate){
				filename = _workbook.getFilename();
				writeXMLFile(filename,_workbook.getXML());
			}
			if(_relation.isUpdate){
				filename = SMLWorkbookRelation.FILENAME;
				writeXMLFile(filename,_relation.getXML());
			}
			
			//  if sheet is updated, save file
			var sheets:Array = _workbook.getSheetList();
			var sheet:SMLWorksheet;
			for each(sheet in sheets){
				if(sheet.isUpdate){
					var rid:String = sheet.getRId();
					filename = _relation.getFilename(rid);
					if(filename){
						filename = "xl/" + filename;
						writeXMLFile(filename,sheet.getXML());
						if(_fileList.indexOf(filename) == -1){
							_fileList.push(filename);
						}
					}
				}
			}
			
			super.saveFile(file);
		}
		
		public function getWorkbook():SMLWorkbook{
			var filename:String = $contentTypes.getFilename(SMLWorkbook.CONTENT_TYPE);
			var entry:ZipEntry = $packages[filename] as ZipEntry;
			var xml:XML = getEntryXML(entry);
			_workbook = new SMLWorkbook(this,xml);
			_workbook.setFilename(filename);
			return _workbook;
		}
		
		public function addSheetEntry(name:String,sheetId:String):String{
			
			var filename:String = "worksheets/sheet" + sheetId + ".xml";
			var rid:String = "";
			
			//  add workbook.xml.rels
			rid = _relation.addSheet(filename);
			
			//  add xl/workbook.xml
			var workbook_xml:XML = _workbook.getXML();
			var ns:Namespace = workbook_xml.namespace();
			var ns_r:Namespace = workbook_xml.namespace("r");
			var sheet_xml:XML = <sheet name={name} sheetId={sheetId} r:id={rid} xmlns:r={ns_r} />;
			var sheets:XML = workbook_xml.ns::sheets[0];
			sheets.appendChild(sheet_xml);
			
			//  add [Content-Types].xml
			var ct_xml:XML = $contentTypes.getXML();
			ns = ct_xml.namespace();
			var partName:String = "/xl/" + filename;
			var contentType:String = SMLWorksheet.CONTENT_TYPE;
			var override_xml:XML = <Override PartName={partName} ContentType={contentType} />;
			ct_xml.appendChild(override_xml);
			$contentTypes.isUpdate = true;
			
			return rid;
		}
		
	    
		airxoox_internal function getSheetXML(sheet_rId:String):XML{
			var filename:String = _relation.getFilename(sheet_rId);
			var entry:ZipEntry = getZipEntry(filename);
			if(entry){
				return getEntryXML(entry);
			}
			return null;
			
		}
		
		/**
		*  get zip entry
		*/
		protected function getZipEntry(filename:String):ZipEntry{
			if(filename.charAt(0) != "/"){
				filename = "/" + filename;
			}
			filename = "/xl" + filename;
			return $packages[filename] as ZipEntry;
		}

		
		public function getSharedStringValue(index:int):String{
			if(_sharedString){
				return _sharedString.getStringValue(index);
			}
			else{
				return "";
			}
		}
		
		public function getSharedStrings():SMLSharedStrings{
			return _sharedString;
		}
	}
}