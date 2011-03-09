/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.core
{
	import com.coltware.airxlib.utils.DateUtils;
	
	import mx.logging.ILogger;
	import mx.logging.Log;

	public class CoreProps
	{
		import com.coltware.airxoox.airxoox_internal;
		use namespace airxoox_internal;
		
		private static const log:ILogger = Log.getLogger("com.coltware.airxoox.core.CoreProps");
		
		public static const CONTENT_TYPE:String = "application/vnd.openxmlformats-package.core-properties+xml";
		public static const FILENAME:String =  "docProps/core.xml";
		
		private var _nsDc:Namespace;
		private var _nsCp:Namespace;
		private var _nsDcterms:Namespace;
		
		private var _xml:XML;
		
		private var _update:Boolean = false;
		
		public function CoreProps(xml:XML)
		{
			this._xml = xml;
			this._nsCp = xml.namespace("cp");
			this._nsDc = xml.namespace("dc");
			this._nsDcterms = xml.namespace("dcterms");
		}
		
		public function get isUpdate():Boolean{
			return this._update;
		}
		
		/**
		 *  Get dc:title value
		 */
		public function getTitle():String{
			return this._get_prop_value("dc","title");
		}
		/**
		 *  Set dc:title
		 */
		public function setTitle(val:String):void{
			this._set_prop_value("dc","title",val);
		}
		/**
		 *  Get dc:subject
		 */
		public function getSubject():String{
			return this._get_prop_value("dc","subject");
		}
		
		public function setSubject(val:String):void{
			this._set_prop_value("dc","subject",val);
		}
		
		public function getCreator():String{
			return this._get_prop_value("dc","creator");
		}
		
		public function setCreator(val:String):void{
			this._set_prop_value("dc","creator",val);
		}
		
		public function getKeywords():String{
			return this._get_prop_value("cp","keywords");
		}
		
		public function setKeywords(val:String):void{
			this._set_prop_value("cp","keywords",val);
		}
		
		public function getDescription():String{
			return this._get_prop_value("dc","description");
		}
		
		public function setDescription(val:String):void{
			this._set_prop_value("dc","description",val);
		}
		
		public function getLastModifiedBy():String{
			return this._get_prop_value("cp","lastModifiedBy");
		}
		
		public function setLastModifedBy(val:String):void{
			this._set_prop_value("cp","lastModifiedBy",val);
		}
		
		public function getCreatedAt():Number{
			var val:String = this._get_prop_value("dcterms","created");
			if(val){
				return DateUtils.strToTime(val,"c");
			}
			else{
				return NaN;
			}
		}
		
		public function setCreatedAt(dateOrNumber:Object):void{
			this._set_prop_date("dcterms","created",dateOrNumber);
		}
		
		public function getModifiedAt():Number{
			var val:String = this._get_prop_value("dcterms","modified");
			if(val){
				return DateUtils.strToTime(val,"c");
			}
			else{
				return NaN;
			}
		}
		
		public function setModifiedAt(dateOrNumber:Object):void{
			this._set_prop_date("dcterms","modified",dateOrNumber);
		}
		
		public function getCategory():String{
			return this._get_prop_value("cp","category");
		}
		
		public function getContentType():String{
			return this._get_prop_value("cp","contentType");
		}
		
		public function getContentStatus():String{
			return this._get_prop_value("cp","contentStatus");
		}
		
		public function getIdentifier():String{
			return this._get_prop_value("dc","identifier");
		}
		
		public function setIdentifier(val:String):void{
			this._set_prop_value("dc","identifier",val);
		}
		
		public function getPropValue(prefix:String,name:String):String{
			return this._get_prop_value(prefix,name);
		}
		
		public function setPropValue(prefix:String,name:String,value:String):void{
			this._set_prop_value(prefix,name,value);
			this._update = true;
		}

		airxoox_internal function _get_prop_value(ns:String,name:String):String{
			var list:XMLList = this._xml.child(new QName(_xml.namespace(ns),name));
			if(list.length() > 0 ){
				return list[0].toString();
			}
			else{
				return "";
			}
		}
		
		/**
		 *  Set Propery Value ( Update or Insert ) 
		 */
		airxoox_internal function _set_prop_value(ns:String,name:String,value:String):void{
			var qn:QName = new QName(_xml.namespace(ns),name);
			var list:XMLList = this._xml.child(qn);
			if(list.length() > 0 ){
				var node:XML = list[0] as XML;
				node.setChildren(value);
			}
			else{
				var nx:XML  = XML("<" + ns + ":" + name + " xmlns:" + ns + '="' + _xml.namespace(ns) + '" />');
				nx.appendChild(value);
				this._xml.appendChild(nx);
			}
			this._update = true;
		}
		
		airxoox_internal function _set_prop_date(ns:String,name:String,dateOrNumber:Object):void{
			
			var cur:Boolean = DateUtils.UTC;
			DateUtils.UTC = true;
			var value:String = DateUtils.dateToString("Y-m-dTH:i:sZ",dateOrNumber);
			DateUtils.UTC = cur;
			
			var qn:QName = new QName(_xml.namespace(ns),name);
			var list:XMLList = this._xml.child(qn);
			if(list.length() > 0 ){
				var node:XML = list[0] as XML;
				node.setChildren(value);
			}
			else{
				var nx:XML  = XML("<" + ns + ":" + name + " xmlns:" + ns + '="' + _xml.namespace(ns) + '" xmlns:xsi="' + _xml.namespace("xsi") +  '"  xsi:type="dcterms:W3CDTF" />');
				nx.appendChild(value);
				this._xml.appendChild(nx);
			}
			this._update = true;
		}
		
		airxoox_internal function getXML():XML{
			return _xml;
		}
		
	}
}