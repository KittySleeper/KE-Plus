package objects;

import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class FunkinBar extends FlxTypedSpriteGroup<FlxSprite> {
    public var bar:FlxBar;
    public var bg:FlxSprite;

    public override function new(x:Float, y:Float, image:String = "healthBar", colorLeft:FlxColor, colorRight:FlxColor, direction:FlxBarFillDirection, value:String, min:Float, max:Float) {
        super(x, y);

        bg = new FlxSprite(x, y).loadGraphic(Paths.image(image));
		add(bg);

		bar = new FlxBar(x + 4, y + 4, direction, Std.int(bg.width - 8), Std.int(bg.height - 8), FlxG.state, value, min, max);
		bar.createFilledBar(colorLeft, colorRight);
		add(bar);
    }
}