package states;

import flixel.FlxG;

class ModState extends MusicBeatState
{
	var state:String;
	var script:HScript;

	override public function new(state:String)
	{
		super();

		this.state = state;
	}

	override public function create()
	{
		super.create();

		script = new HScript('assets/states/$state');

		if (!script.isBlank && script.expr != null)
		{
			script.interp.scriptObject = this;
			script.setValue('add', add);
			script.setValue('remove', remove);
			script.interp.execute(script.expr);
		}
		else
		{
			FlxG.switchState(new states.mainmenu.MainMenuState()); // softlock prevention
		}

		#if sys
		script.callFunction("create");
		#end
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		#if sys
		script.callFunction("update", [elapsed]);
		#end
	}

	override public function stepHit()
	{
		super.stepHit();

		#if sys
		script.callFunction("stepHit");
		#end
	}

	override public function beatHit()
	{
		super.beatHit();

		#if sys
		script.callFunction("beatHit");
		#end
	}
}