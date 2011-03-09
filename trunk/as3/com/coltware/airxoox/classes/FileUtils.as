/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.classes {
	
	import flash.filesystem.*;
    import flash.utils.*;
	
	public class FileUtils {
		
		public static function getXML(file:File):XML{
		  var fs:FileStream = new FileStream();
		  fs.open(file,FileMode.READ);
		  var bytes:ByteArray = new ByteArray();
		  fs.readBytes(bytes,0,file.size);
		  bytes.position = 0;
		  var xml:String = bytes.readUTFBytes(bytes.bytesAvailable);
		  return XML(xml);
		}
		
	}

}