/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.word {
	
	import com.coltware.airxoox.element.*;
	
	public class WMLRelation {
		
		public static const FILENAME:String = "word/_rels/document.xml.rels";
		
		private var _xml:XML;
        private var _ns:Namespace;
        private var _maxId:Number = 0;
        
        public var isUpdate:Boolean = false;
		
		public function WMLRelation(xml:XML) {
			_xml = xml;
			_ns = _xml.namespace();
            init();
		}
		
		public function add(type:String,target:String):String{
			var rid:String = "rId" + addId();
            var node:XML = <Relationship Id={rid} Type={type} Target={target} xmlns={_ns} />
            _xml.appendChild(node);
            isUpdate = true;
            return rid;
		}
		
		public function addAltChunk(target:String,targetMode:String):String{
			var type:String = WMLAltChunk.RELATION_TYPE;
			var rid:String = "rId" + addId();
			var node:XML = <Relationship Id={rid} Type={type} Target={target} TargetMode={targetMode} xmlns={_ns} />
            _xml.appendChild(node);
            isUpdate = true;
            return rid;
		}
		
		public function addId():Number{
            _maxId = _maxId + 1;
            return _maxId;
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
        
        public function getXML():XML{
            return _xml;
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