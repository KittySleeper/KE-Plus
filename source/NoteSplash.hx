package;

import flixel.FlxG;
import flixel.FlxSprite;
import haxe.io.Path;

class NoteSplash extends FlxSprite
{
	public var noteData:Int;

	public function new(x:Float, y:Float, noteData:Int = 0):Void
	{
		super(x, y);

		this.noteData = noteData;

		frames = Paths.getSparrowAtlas('noteSplashes_desaturated');
		animation.addByPrefix('splash1', 'splash1', 24, false);
		animation.addByPrefix('splash2', 'splash2', 24, false);
		setupNoteSplash(x, y, noteData);

		color = Note.noteColor[noteData];

		// alpha = 0.75;
	}

	public function setupNoteSplash(x:Float, y:Float, noteData:Int = 0)
	{
		setPosition(x, y);
		alpha = 0.6;

		animation.play('splash' + FlxG.random.int(1, 2), true);
		animation.curAnim.frameRate += FlxG.random.int(-2, 2);
		updateHitbox();

		offset.set(width * 0.3, height * 0.3);
	}

	override function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
			kill();

		super.update(elapsed);
	}
}