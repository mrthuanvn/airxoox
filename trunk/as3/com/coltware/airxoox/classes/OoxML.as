/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.classes {
	
	import coltware.airxoox.*;
	import com.coltware.airxoox.classes.Relationships;
	import com.coltware.airxoox.core.AppProps;
	import com.coltware.airxoox.core.ContentTypes;
	import com.coltware.airxoox.core.CoreProps;
	import com.coltware.airxoox.airxoox_internal;
	import com.coltware.airxzip.*;
	
	import flash.filesystem.*;
	import flash.utils.*;
	
	use namespace airxoox_internal;
	
	public class OoxML {

		private var _inputFile:File;
        private var _zipReader:ZipFileReader;
        
		protected var _openMode:String;
        // if file open mode is "UPDATE" , create tmpDir to unzip
        protected var _tmpDir:File;
        protected var _fileList:Array;
        
        protected var appRelationShips:Relationships;
		
		airxoox_internal var $packages:Object;
		airxoox_internal var $contentTypes:ContentTypes;
		/**
		 *   object for app.xml 
		 */
		airxoox_internal var $appProps:AppProps;
		
		/**
		 *  Object for core.xml
		 */
		airxoox_internal var $coreProps:CoreProps;
		
		public function OoxML() {
			$packages = new Object();
            _fileList = new Array();
		}
		
		/**
        *   
        *
        */
        public function openFile(file:File,mode:String = null):void{
        	if(mode == null){
        		mode = FileMode.READ;
        	}
            _openMode = mode;
            if(_openMode == FileMode.UPDATE){
                _tmpDir = File.desktopDirectory.resolvePath("tmp");
                if(_tmpDir.isDirectory){
                	/*
                	_tmpDir.deleteDirectory(true);
                	_tmpDir.createDirectory();
                	*/
                }
                //File.createTempDirectory();
            }
            
            _inputFile = file;
            _zipReader = new ZipFileReader();
            _zipReader.open(file);
            var entries:Array = _zipReader.getEntries();
            
            //  def work vars
            var bytes:ByteArray;
            var data:String;
            
            for(var i:int = 0; i<entries.length; i++){
                var entry:ZipEntry = entries[i] as ZipEntry;
                var name:String = entry.getFilename();
                
                if(_tmpDir){
                    unzipFile(entry);
                    _fileList.push(name);
                }
                
                if(name == "_rels/.rels"){
                	appRelationShips = new Relationships(getEntryXML(entry));
                }
                else if(name == ContentTypes.FILENAME){
                    $contentTypes = new ContentTypes(getEntryXML(entry));
                }
				else if(name == AppProps.FILENAME){
					$appProps = new AppProps(getEntryXML(entry));
				}
                else if(!loadOnStartup(name,entry)){
                    if(name.charAt(0) != "/"){
                       name = "/" + name;
                    }
                    $packages[name] = entry;
                }
            }
            
            completeStartup();
            
            if(_tmpDir){
                _zipReader.close();
                _zipReader = null;
            }
        }
        
        public function saveFile(file:File):void{
        	
        	if($contentTypes.isUpdate){
                filename = ContentTypes.FILENAME;
                writeXMLFile(filename,$contentTypes.getXML());
            }
			
			if($appProps.isUpdate){
				filename = AppProps.FILENAME;
				writeXMLFile(filename,$appProps.getXML());
			}
			
			if($coreProps && $coreProps.isUpdate){
				filename = CoreProps.FILENAME;
				writeXMLFile(filename,$coreProps.getXML());
			}
        	
        	
            var zipWriter:ZipFileWriter = new ZipFileWriter();
            zipWriter.open(file);
            
            var filename:String;
                       
            for(var i:int = 0 ; i<_fileList.length; i++){
                var name:String = _fileList[i];
                var file:File = _tmpDir.resolvePath(name);
                if(file){
                    zipWriter.addFile(file,name);
                }
            }
            zipWriter.close();
        }
        
        public function closeFile():void{
            if(_tmpDir){
                //_tmpDir.deleteDirectory(true);
            }
            else{
                if(_zipReader)
                    _zipReader.close();
            }
        }
        
        /**
        *  override
        *
        */
        protected function loadOnStartup(filename:String,entry:ZipEntry):Boolean{
        	return false;
        }
        
        protected function completeStartup():void{
        }
		
		public function getCoreProperties():CoreProps{
			if(this.$coreProps){
				return this.$coreProps;
			}
			this.$coreProps = new CoreProps(this.getPackageXML(CoreProps.FILENAME));
			return this.$coreProps;
		}
        
        protected function getEntryXML(entry:ZipEntry):XML{
            if(_openMode == FileMode.UPDATE){
                var file:File = _tmpDir.resolvePath(entry.getFilename());
                var fs:FileStream = new FileStream();
                fs.open(file,FileMode.READ);
                var data1:String = fs.readUTFBytes(file.size);
                fs.close();
                return XML(data1);
            }
            else{
                var bytes:ByteArray = _zipReader.unzip(entry);
                bytes.position = 0;
                var data2:String = bytes.readUTFBytes(bytes.length);
                return XML(data2);
            }
        }
        
        protected function getPackageXML(filename:String):XML{
        	if(filename.charAt(0) != '/'){
        	   filename = "/" + filename;
        	}
        	var entry:ZipEntry = $packages[filename] as ZipEntry;
        	if(entry){
        	   return getEntryXML(entry);
        	}
        	else{
        		trace("getPackageXML Error filename:" + filename);
        		throw new Error("no such filename [" + filename + "]");
        	}
        }
        
        public function get contentTypes():ContentTypes{
        	return $contentTypes;
        }
                
        
        private function unzipFile(entry:ZipEntry):File{
            var bytes:ByteArray = _zipReader.unzip(entry);
            var filename:String = entry.getFilename();
            var file:File = _tmpDir.resolvePath(filename);
            var pos:int = filename.lastIndexOf("/");
            if(pos > 0 ){
                var dirname:String = filename.substr(0,pos);
                var dir:File = _tmpDir.resolvePath(dirname);
                dir.createDirectory();
            }
            var fs:FileStream = new FileStream();
            fs.open(file,FileMode.WRITE);
            bytes.position = 0;
            fs.writeBytes(bytes);
            fs.close();
            fs = null;
            return file;
        }
        
        protected function writeXMLFile(filename:String,xml:XML):void{
            var ch1:String = filename.charAt(0);
            if(ch1 == "/"){
                filename = filename.substr(1);
            }
            var file:File = _tmpDir.resolvePath(filename);
            //trace(file.nativePath);
            var fs:FileStream = new FileStream();
            fs.open(file,FileMode.WRITE);
            
            fs.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>\n");
            fs.writeUTFBytes(xml.toXMLString());
            fs.close();
        }
	}

}