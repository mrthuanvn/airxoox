/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.classes {
	public class Relationships {
		
		private var _xml:XML;
		private var _ns:Namespace;
        private var _maxId:Number = 0;
		
		public function Relationships(xml:XML) {
			_xml = xml;
			_ns = _xml.namespace();
            init();
		}
		
		private function init():void{
            var list:XMLList = _xml._ns::Relationship;
            for each(var node:XML in list){
                var _id:String = node.@Id;
                if(_id){
                    var pos:int = _id.indexOf("rId");
                    if(pos > -1){
                        var nstr:String = _id.substr(pos + 3);
                        var n:Number = Number(nstr);
                        if(n){
                            if(_maxId < n ){
                                _maxId = n;
                            }
                        }
                    }
                }
            }
        }
        
        public function getTargetFromId(id:String):String{
        	var node:XML = _xml._ns::Relationship.(@Id == id)[0];
        	if(node){
        		return node.@Target;
        	}
        	else{
        		return null;
        	}
        }
        
        public function getTarget(type:String):String{
        	var node:XML = _xml._ns::Relationship.(@Type == type)[0];
        	if(node){
        		return node.@Target;
        	}
        	else{
        		return null;
        	}
        }
	}

}