/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox {
	
	import com.coltware.airxoox.classes.*;
	import com.coltware.airxoox.dml.*;
	import com.coltware.airxoox.ppt.*;
	import com.coltware.airxzip.*;
	
	import flash.filesystem.*;
	import flash.net.*;
	
	
	public class PresentationML extends OoxML{
		
		protected static const ROOT_TYPE:String = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument";
		
		/**
		*  ppt/_rels/presentaion.xml.rels
		*/
		protected var pptRels:Relationships;
		
		protected var pptRoot:PPTRoot;
		
		protected var slideSize:Size;
		
		public function PresentationML() {
			
		}
		
		/**
        *  override
        *
        */
        override protected function completeStartup():void{
        	var rootTypeFilename:String = appRelationShips.getTarget(PPTRoot.TYPE);
        	
        	pptRoot = new PPTRoot(getPackageXML(rootTypeFilename),this);
        	slideSize = pptRoot.getSlideSize();
        	pptRels = new Relationships(getPackageXML("ppt/_rels/presentation.xml.rels"));
        	
        }
        
        /**
        *  スライドのID一覧を取得する
        *
        */
        public function getSlideIdList():Array{
        	var ret:Array = new Array();
        	var list:Array = pptRoot.getSlideIdList();
        	return list;
        }
        
        public function getSlide(rid:String):Slide{
        	var filename:String = pptRels.getTargetFromId(rid);
        	if(filename){
        		filename = "ppt/" + filename;
        		var xml:XML = getPackageXML(filename);
        		var s:Slide = new Slide(xml);
        		return s;
        	}
        	else{
        		return null;
        	}
        }
        /**
        *  width, height で指定されたサイズをもとに、表示するサイズ、位置を計算する
        *  おもに、実際のCanvasなどに配置する際に使用する。
        */
        public function computeXfrm(xfrm:Xfrm,width:uint,height:uint):Xfrm{
        	var w:uint = Math.floor((xfrm.width / slideSize.cx ) * width);
        	var h:uint = Math.floor((xfrm.height / slideSize.cy ) * height);
        	var x:uint = Math.floor((xfrm.x / slideSize.cx ) * width );
        	var y:uint = Math.floor((xfrm.y / slideSize.cy ) * height);
        	
        	xfrm.setScale(x,y,w,h);
        	return xfrm;
        }
	}

}