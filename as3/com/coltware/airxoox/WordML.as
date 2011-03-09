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
	import com.coltware.airxoox.word.*;
	import com.coltware.airxzip.*;
	import flash.filesystem.*;
	import flash.net.*;
	
	public class WordML extends OoxML{
		
		//public static const CONTENT_TYPE:String = "application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml";
		
		private var _document:WMLDocument;
		private var _relation:WMLRelation;
		private var _comments:WMLComments;
		private var _media:Array;
		
		public function WordML() {
			_media = new Array();
		}
		
		public function getDocument():WMLDocument{
			_document = new WMLDocument(this);
			return _document;
		}
		
		override public function saveFile(file:File):void{
			var filename:String;
			if(_document){
				if(_document.isUpdate){
					filename = contentTypes.getFilename(WMLDocument.CONTENT_TYPE);
					writeXMLFile(filename,_document.getXML());
				}
			}
			if(_relation.isUpdate){
                filename = WMLRelation.FILENAME;
                writeXMLFile(filename,_relation.getXML());
            }
			
			super.saveFile(file);
		}
		
		/**
		*  @private
		*
		*/
		public function getDocumentXML():XML{
			var filename:String = contentTypes.getFilename(WMLDocument.CONTENT_TYPE);
            return getPackageXML(filename);
		}
		
		public function replaceMedia(filename:String,replaceFile:File):void{
			if(_openMode == FileMode.UPDATE){
				var to_file:FileReference = _tmpDir.resolvePath(filename);
				if(to_file && replaceFile){
					replaceFile.copyTo(to_file,true);
				}
			}
		}
		
		public function getMediaList():Array{
			return _media;
		}
		
		
		public function getComment(id:String):WMLCommentNode{
			if(_comments){
				return _comments.getComment(id);
			}
			return null;
		}
		
		
		public function getCommentId(text:String):String{
			if(_comments){
				return _comments.getCommentId(text);
			}
			return null;
		}
		
		public function addAltChunkResource(file:File,targetMode:String = "Internal"):String{
			var target:String = file.name;
			var tmpFile:String = "word/" + target;
			var dist:File = _tmpDir.resolvePath(tmpFile);
			file.copyTo(dist,true);
			_fileList.push(tmpFile);
			return _relation.addAltChunk(target,targetMode);
		}
		
		
		
		override protected function loadOnStartup(filename:String,entry:ZipEntry):Boolean{
			if(_openMode == FileMode.UPDATE){
				var _m:String = "word/media";
				var pos:int = filename.indexOf(_m);
				if(pos > -1){
					_media.push(filename);
				}
			}
			
			if(filename == WMLRelation.FILENAME){
				_relation = new WMLRelation(getEntryXML(entry));
			}
			
			
            return false;
        }
        
        override protected function completeStartup():void{
        	
        	var filename:String = _relation.getTarget(WMLComments.RELATION_TYPE);
        	if(filename){
        		filename = "word/" + filename;
        		var xml:XML = getPackageXML(filename);
        		if(xml){
        			_comments = new WMLComments(xml);
        		}
        	}
        }

		
	}

}