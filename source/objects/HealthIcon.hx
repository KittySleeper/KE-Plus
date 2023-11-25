package objects;

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
	public var hasWinning:Bool = true;

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

		if (animation.exists(char))
			animation.remove(char);

		var finalIcon:String = "icons/icon-face";

		if (Assets.exists(Paths.image('icons/icon-$char')))
			finalIcon = 'icons/icon-$char';

		loadGraphic(Paths.image(finalIcon));

		hasWinning = width == 450;

		loadGraphic(Paths.image(finalIcon), true, 150, 150);

		if (hasWinning)
			animation.add(char, [0, 1, 2], 0, false, isPlayer);
		else
			animation.add(char, [0, 1], 0, false, isPlayer);

		animation.play(char);
	}
}