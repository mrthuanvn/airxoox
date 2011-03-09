/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.ppt.classes {
	
	import com.coltware.airxoox.dml.*;
	
	/**
	*  5.1.2.1.35 spPr (Shape Properties)
    * 
    *  This element specifies the visual shape properties that can be applied to a shape.
    */
	public class PShapeProperty {
		
		private var _xml:XML;
		private var _xfrm:Xfrm;
		private var _nsA:Namespace;
		
		
		public function PShapeProperty(x:XML) {
			_xml = x;
			_nsA = x.namespace("a");
		}
		
		public function get xfrm():Xfrm{
			if(_xfrm){
				return _xfrm;
			}
			var node:XML = _xml._nsA::xfrm[0];
			if(node){
				_xfrm = new Xfrm(node);
				return _xfrm;
			}
			return null;
		}
	}

}