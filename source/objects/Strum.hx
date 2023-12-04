package objects;

import flixel.FlxSprite;

class Strum extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var animArray:Array<Array<String>> = [
		["arrowLEFT", "left press", "left confirm"],
		["arrowDOWN", "down press", "down confirm"],
		["arrowUP", "up press", "up confirm"],
		["arrowRIGHT", "right press", "right confirm"]
	];
	public var noteData:Int = 0;

	override public function new(x:Float, y:Float, image:String = "NOTE_assets", noteID:Int = 0, ?animArray:Array<Array<String>>)
	{
		super(x, y);
		animOffsets = new Map<String, Array<Float>>();

		this.animArray = animArray;

		this.noteData = noteID;

		frames = Paths.getSparrowAtlas(image);
		animation.addByPrefix("static", animArray[noteID][0], 24, false);
		animation.addByPrefix("pressed", animArray[noteID][1], 24, false);
		animation.addByPrefix("confirm", animArray[noteID][2], 24, false);
		playAnim("static");

		setGraphicSize(Std.int(this.width * 0.7));

		antialiasing = true;
		updateHitbox();
		scrollFactor.set();
	}

	public function addOffset(animName:String, x:Float, y:Float)
	{
		animOffsets[animName] = [x, y];
	}

	public function playAnim(animName:String, forced:Bool = false)
	{
		animation.play(animName, forced);

		var daOffset = animOffsets.get(animName);
		if (animOffsets.exists(animName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (animName == "static")
			centerOffsets();
	}
}