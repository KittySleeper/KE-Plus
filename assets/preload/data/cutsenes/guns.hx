import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

function create()
{
	FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.15}, 0.10);
	dad.visible = false;
	camHUD.visible = false;

	var dadAlt = new FlxSprite(dad.x - 80, dad.y + 40);
	dadAlt.frames = Paths.getSparrowAtlas("week7/cutsene/guns/tankTalkSong2");
	dadAlt.animation.addByPrefix('talktankie', 'TANK TALK 2', 24, false);
	dadAlt.animation.play("talktankie", true);
	add(dadAlt);
	dadAlt.animation.finishCallback = function(anim)
	{
		camHUD.visible = true;
		FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.6);
		new FlxTimer().start(12, function(timer)
		{
			dad.visible = true;
			dadAlt.destroy();
		});

		startCountdown();
	};

	camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
	FlxG.sound.play(Paths.sound("cutsenes/guns/tankSong2"));

	new FlxTimer().start(4, function(timer)
	{
		FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.20}, 0.4);
		gf.playAnim("sad", true);
		bf.playAnim("singLEFTmiss", true);
	});
}