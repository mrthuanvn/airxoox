/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox
{
	import com.coltware.airxoox.classes.OoxML;
	
	import com.coltware.airxlib.utils.FilenameUtils;
	
	import flash.filesystem.File;
	
	public final class Airxoox
	{
		public static const EXTENSIONS:Array = ["xlsx","docx","pptx"];
		
		public static function openFile(file:File,mode:String = null):OoxML{
			
			var ext:String = FilenameUtils.getExtension(file.name);
			var oox:OoxML = null;
			if( ext == "xlsx"){
				oox = new SpreadsheetML();
			}
			else if( ext == "docx"){
				oox = new WordML();
			}
			else if(ext == "pptx"){
				oox = new PresentationML();
			}
			
			if(oox){
				oox.openFile(file,mode);
				return oox;
			}
			return null;
			
		}
	}
}