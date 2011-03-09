/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.element {
	
	public class WMLAltChunk extends WMLParagraph{
		
		public static const RELATION_TYPE:String = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/aFChunk"; 
		
		
		public function WMLAltChunk(rootXml:XML,nodeXml:XML) {
            super(rootXml,nodeXml);
		}
	}

}