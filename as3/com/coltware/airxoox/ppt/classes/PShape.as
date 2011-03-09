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
	import flashx.textLayout.container.*;
	import flashx.textLayout.compose.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.edit.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.conversion.*;
	import flash.display.Sprite;
	import mx.core.*;
	
	/**
	*  5.1.2.1.33 sp (Shape)
	*
	* <complexType name="CT_GvmlShape">
    * <sequence>
    * <element name="nvSpPr" type="CT_GvmlShapeNonVisual" minOccurs="1" maxOccurs="1"/>
    * <element name="spPr" type="CT_ShapeProperties" minOccurs="1" maxOccurs="1"/>
    * <element name="txSp" type="CT_GvmlTextShape" minOccurs="0" maxOccurs="1"/>
    * <element name="style" type="CT_ShapeStyle" minOccurs="0" maxOccurs="1"/>
    * <element name="extLst" type="CT_OfficeArtExtensionList" minOccurs="0" maxOccurs="1"/>
    * </sequence>
    * </complexType>
	*/
	public class PShape {
		
		private var _xml:XML;
		private var _nsP:Namespace;
		private var _property:PShapeProperty = null;
		
		public function PShape(xml:XML) {
			_xml = xml;
			_nsP = xml.namespace("p");
		}
		
		public function get property():PShapeProperty{
			if(_property){
				return _property;
			}
			var node:XML = _xml._nsP::spPr[0];
			if(node){
				_property = new PShapeProperty(node);
				return _property;
			}
			return null;
		}
		
		public function get xfrm():Xfrm{
			if(property){
				return property.xfrm;
			}
			else{
				return null;
			}
		}
		
		/**
		*  minOccurs=0
		*  maxOccurs=1
		*
		*/
		public function getTextBody():TextBody{
			var node:XML = _xml._nsP::txBody[0];
			if(node){
				var txBody:TextBody = new TextBody(node);
				return txBody;
			}
			return null;
		}
		
		public function createTextFlow(ui:UIComponent):TextFlow{
			var sprite:Sprite = new Sprite();
			var textFlow:TextFlow = new TextFlow();
			var controller:ContainerController =  new ContainerController(sprite);
			var flowComposer:IFlowComposer = textFlow.flowComposer;
			flowComposer.addController(controller);
			ui.addChild(sprite);
			return textFlow;
		}
	}

}