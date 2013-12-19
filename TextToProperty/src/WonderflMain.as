package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0xFFFFFF, frameRate = 30)]
	public class WonderflMain extends Sprite 
	{
		
		public function WonderflMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(new Canvas());
		}
		
	}
	
}

	
	import com.bit101.components.CheckBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.TextArea;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	/**
	 * ...
	 * @author umhr
	 */
	 class Canvas extends Sprite 
	{
		private var _outPutTextArea:TextArea;
		private var _inPutTextArea:TextArea;
		private var _inputText:InputText;
		private var _numericStepper:NumericStepper;
		private var _checkBox:CheckBox;
		private var _new:CheckBox;
		
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			
			new Label(this, 8, 214, "Tab:");
			_numericStepper = new NumericStepper(this, 38, 214, textArea_change);
			_numericStepper.value = 3;
			_numericStepper.width = 60;
			_inputText = new InputText(this, 120, 214, "_text", textArea_change);
			_new = new CheckBox(this, 230, 218, "new", textArea_change);
			_new.selected = true;
			_checkBox = new CheckBox(this, 280, 218, "local prop", textArea_change);
			new PushButton(this, 357, 214, "Copy to Clipbord", onMouseClick);
			
			Style.embedFonts = false;
			Style.fontName = "PF Ronda Seven";
			Style.fontSize = 12;
			
			_inPutTextArea = new TextArea(this, 8, 8, '◆使い方\n複数行のテキストをここに"コピペ"すると、\n下に整形して表示されるよ。');
			_inPutTextArea.width = stage.stageWidth - _inPutTextArea.x - 8;
			_inPutTextArea.height = 200;
			_inPutTextArea.addEventListener(Event.CHANGE, textArea_change);
			_outPutTextArea = new TextArea(this, 8, 238, "");
			_outPutTextArea.width = stage.stageWidth - _outPutTextArea.x - 8;
			_outPutTextArea.height = stage.stageHeight - _outPutTextArea.y - 8;
			
			textArea_change(null);
		}
		
		private function textArea_change(e:Event):void 
		{
			var text:String = _inPutTextArea.text;
			text = text.replace(/\r\n/g, "\n");
			text = text.replace(/\r/g, "\n");
			var list:Array/*String*/ = text.split("\n");
			var prop:String = "";
			var n:int = _numericStepper.value;
			for (var i:int = 0; i < n; i++) 
			{
				prop += "\t";
			}
			
			text = "";
			
			_checkBox.enabled = _new.selected;
			var quotationMark:String = '"';
			var kaigyo:String = '\\n';
			
			n = list.length;
			for (i = 0; i < n; i++) 
			{
				if (list[i].search('"') > -1) {
					quotationMark = "'";
				}else {
					quotationMark = '"';
				}
				if (i + 1 == n) {
					kaigyo = "";
				}
				
				if (i == 0 && _new.selected) {
					if(_new.selected){
						if(_checkBox.selected){
							text = prop +'var ' + _inputText.text + ':String = ' + quotationMark + list[i] + kaigyo + quotationMark + ';\n';
						}else {
							text = prop +_inputText.text + ' = ' + quotationMark + list[i] + kaigyo + quotationMark + ';\n';
						}
					}
				}else{
					text += prop +_inputText.text +' += ' + quotationMark + list[i] + kaigyo + quotationMark + ';\n';
				}
			}
			
			_outPutTextArea.text = text;
			
		}
		
		private function onMouseClick(e:Event):void 
		{
			System.setClipboard(_outPutTextArea.text);
		}
	}
	
