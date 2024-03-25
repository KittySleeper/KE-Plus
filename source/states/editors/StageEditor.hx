package states.editors;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class StageEditor extends MusicBeatState {
    var stage:String = 'stage';
	public var script:HScript;
    public function new(stage:String = 'stage')
	{
		super();
		this.stage = stage;
	}

    override function create() {
        #if sys
		script = new HScript('assets/stages/$stage');
		script.interp.scriptObject = this;
		script.setValue('add', add);
		script.setValue('remove', remove);
		script.interp.execute(script.expr);
		script.callFunction("create");
		#end
        super.create();
        #if sys
		script.callFunction("createPost");
		#end
    }
}