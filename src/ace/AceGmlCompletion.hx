package ace;
import ace.AceWrap;
import gml.GmlAPI;

/**
 * ...
 * @author YellowAfterlife
 */
@:keep class AceGmlCompletion implements AceAutoCompleter {
	//
	public var items:AceAutoCompleteItems;
	//
	public function new(items:AceAutoCompleteItems) {
		items.autoSort();
		this.items = items;
	}
	// interface AceAutoCompleter
	public function getCompletions(
		editor:AceEditor, session:AceSession, pos:AcePos, prefix:String, callback:AceAutoCompleteCb
	):Void {
		if (prefix.length < 2) {
			callback(null, []);
			return;
		}
		if (editor.completer != null) {
			editor.completer.exactMatch = true;
		}
		var tk = session.getTokenAtPos(pos);
		switch (tk.type) {
			case "comment", "comment.doc", "string", "preproc": {
				callback(null, []);
			};
			default: {
				callback(null, items);
			};
		}
	}
	public function getDocTooltip(item:AceAutoCompleteItem):String {
		return item.doc;
	}
	//
	public static function init(editor:AceWrap) {
		editor.setOptions({
			enableLiveAutocompletion: [
				new AceGmlCompletion(GmlAPI.stdComp),
				new AceGmlCompletion(GmlAPI.extComp),
				new AceGmlCompletion(GmlAPI.gmlComp),
			]
		});
	}
}
