package;

import openfl.Lib;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class VSliceFreeplayState extends MusicBeatSubstate
{
    var bgDad:FlxSprite;
    var pinkBack:FlxSprite;

    public function new()
	{
		super();

        var bgDad:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('freeplay/freeplayBGdad'));
		bgDad.scrollFactor.x = 0;
		bgDad.scrollFactor.y = 0;
		bgDad.setGraphicSize(FlxG.width, FlxG.height);
		bgDad.updateHitbox();
		bgDad.screenCenter();
		bgDad.antialiasing = true;
		add(bgDad);
	}
}