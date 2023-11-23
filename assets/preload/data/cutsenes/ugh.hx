import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

function create()
{
	camHUD.visible = false;

	FlxG.camera.zoom += 0.10;
	dad.visible = false;

	var dadAlt = new FlxSprite(dad.x - 80, dad.y + 40);
	dadAlt.frames = Paths.getSparrowAtlas("week7/cutsene/ugh/tankTalkSong1");
	dadAlt.animation.addByPrefix('pt1', 'TANK TALK 1 P1', 24, false);
	dadAlt.animation.addByPrefix('pt2', 'TANK TALK 1 P2', 24, false);
	dadAlt.animation.play("pt1", true);
	add(dadAlt);

	camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
	FlxG.sound.play(Paths.sound("wellWellWell"));

	dadAlt.animation.finishCallback = function(anim)
	{
		camFollow.setPosition(bf.x, bf.y + 70);
		FlxG.sound.play(Paths.sound("bfBeep"));
		bf.playAnim("singUP");
		new FlxTimer().start(1.5, function(timer)
		{
			bf.playAnim("idle");

			camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
			dadAlt.animation.play("pt2", true);
			FlxG.sound.play(Paths.sound("killYou"));

			dadAlt.animation.finishCallback = function(anim)
			{
				new FlxTimer().start(2, function(timer)
				{
					dad.visible = true;
					dadAlt.destroy();
				});

				camHUD.visible = true;
				FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.6);
				startCountdown();
			};
		});
	};
}