/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.core {
	public class ContentTypes {
		
		private var _xml:XML;
		private var _ns:Namespace;
		
		public static const FILENAME:String = "[Content_Types].xml";
		
		public var isUpdate:Boolean = false;
		
		public function ContentTypes(xml:XML) {
			_xml = xml;
			_ns = _xml.namespace();
		}
		
		/**
		*  get ContentType 
		* 
		*  @param filename
		*
		*/
		public function getContentType(filename:String):String{
			var ret:String = getOverrideContentType(filename);
			if(ret){
				return ret;
			}
			
			var pos:int = filename.lastIndexOf(".");
			if(pos){
				var ext:String = filename.substr(pos+1);
				return getDefaultContentType(ext);
			}
			
			return null;
		}
		
		/**
		*
		*  @param file extension ( ex. "png","gif"... )
		*
		*/
		public function getDefaultContentType(ext:String):String{
		  var type:Object = _xml._ns::Default.(@Extension == ext).@ContentType;
		  
		  if(type){
		  	return type.toString();
		  }
		  else{
		  	return null;
		  }
		}
		
		public function getOverrideContentType(file:String):String{
			if(file.charAt(0) != "/"){
			     file = "/" + file;
			}
			var type:Object = _xml._ns::Override.(@PartName == file).@ContentType;
			if(type){
				return type.toString();
			}
			else{
				return null;
			}
		}
		
		public function addDefaultType(ext:String,contentType:String):void{
			isUpdate = true;
			var defs:XMLList = _xml._ns::Default;
			var idx:int = defs.length() -1;
			
			var def_xml:XML = <Default Extension={ext} ContentType={contentType} />;
			
			_xml.insertChildAfter(defs[idx],def_xml);
		}
		/**
		*  @param content type
		*
		*/
		public function getFilename(contentType:String):String{
			var partName:Object = _xml._ns::Override.(@ContentType == contentType).@PartName;
			if(partName){
				return partName.toString();
			}
			else{
				return null;
			}
		}
		
		public function getXML():XML{
			return _xml;
		}
	}

}