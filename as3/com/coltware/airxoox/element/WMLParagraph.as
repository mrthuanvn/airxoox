/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.element {
	public class WMLParagraph extends WMLNode {
		
		private var _curP:XML;
		
		public function WMLParagraph(rootXml:XML,nodeXml:XML) {
			super(rootXml,nodeXml);
			_curP = nodeXml;
		}
		
		public function addRunText(text:String):WMLRun{
			var run_xml:XML = <w:r xmlns:w={_nsW} />;
			var run:WMLRun = new WMLRun(_rootXml,run_xml);
			run.setText(text);
			_nodeXml.appendChild(run.getXML());
			return run;
		}
		
		public function removeText():void{
			var tlist:XMLList = _nodeXml.._nsW::t;
			for each(var node:XML in tlist){
				var p:XML = node.parent();
				delete p.(true)[0];
			}
		}
		
		
		public function insertAfter():WMLParagraph{
			var newNode:XML = _nodeXml.copy();
			var rlist:XMLList = newNode._nsW::r;
			for each(var n:XML in rlist){
				delete n.(true)[0];
			}
			delete newNode._nsW::commentRangeStart[0];
			delete newNode._nsW::commentRangeEnd[0];
			
			var pn:XML = _nodeXml.parent();
			trace(newNode);
			pn.insertChildAfter(_curP,newNode);
			var p:WMLParagraph = new WMLParagraph(_rootXml,newNode);
			_curP = newNode;
			return p;
		}
		
		public function insertMultiTextAfter(text:String):void{
			
		}
		
		public function insertTextAfter(text:String):WMLParagraph{
			var p:WMLParagraph = insertAfter();
			p.addRunText(text);
			return p;
		}
		
		public function removeComment():void{
			delete _nodeXml._nsW::commentRangeStart[0];
            delete _nodeXml._nsW::commentRangeEnd[0];
            
            var cr:XML = _nodeXml.._nsW::commentReference[0];
            if(cr){
                var pcr:XML = cr.parent();
                delete pcr.(true)[0];
            }
            else{
            	trace("delete comment ref");
            }
            
		}
		
		
	}

}