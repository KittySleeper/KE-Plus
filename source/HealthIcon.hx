package;

import openfl.Assets;
import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var char:String;
	public var isPlayer:Bool;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		changeChar(char, isPlayer);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function changeChar(char:String, isPlayer:Bool = false) {
		this.char = char;
		this.isPlayer = isPlayer;

		if (Assets.exists(Paths.image('icons/$char')))
			loadGraphic(Paths.image('icons/$char'), true, 150, 150);
		else if (Assets.exists(Paths.image('icons/icon-$char')))
			loadGraphic(Paths.image('icons/icon-$char'), true, 150, 150);
		else
			loadGraphic(Paths.image('icons/icon-face'), true, 150, 150);

		if (animation.exists(char))
			animation.remove(char);

		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);
	}
}