/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.core {
	
	import com.coltware.airxoox.airxoox_internal;
	use namespace airxoox_internal;
	
	public class AppProps {
		
		/**
		 *  ファイル名
		 */
		public static const FILENAME:String = "docProps/app.xml";
		
		public var isUpdate:Boolean = true;
		
		protected var _ns:Namespace;
		protected var _nsVt:Namespace;
		
		private var _xml:XML;
		
		public function AppProps(xml:XML) {
			_xml = xml;
			
			_ns = _xml.namespace();
		}
		
		airxoox_internal function getXML():XML{
			return _xml;
		}
	}

}