/**
 *  Copyright (c)  2009 coltware.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxoox.excel {
	public class BlankSheet {
		public function BlankSheet() {
			
		}
		
		public function create():XML{
			return <worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<dimension ref="A1"/><sheetViews><sheetView workbookViewId="0"/>
</sheetViews>
<sheetFormatPr defaultRowHeight="13.5"/>
<sheetData/>
<phoneticPr fontId="2"/>
<pageMargins left="0.78700000000000003" right="0.78700000000000003" top="0.98399999999999999" bottom="0.98399999999999999" header="0.51200000000000001" footer="0.51200000000000001"/>
<headerFooter alignWithMargins="0"/>
</worksheet>
		}
	}

}