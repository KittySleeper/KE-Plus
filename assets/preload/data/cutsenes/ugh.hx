import flixel.util.FlxTimer;

function create()
{
	dad.visible = false;

	var dadAlt = new FlxSprite(dad.x, dad.y);
	dadAlt.frames = Paths.getSparrowAtlas("week7/cutsene/ugh/tankTalkSong1");
	dadAlt.animation.addByPrefix('pt1', 'TANK TALK 1 P1', 24, false);
	dadAlt.animation.addByPrefix('pt2', 'TANK TALK 1 P2', 24, false);
	dadAlt.animation.play("pt1", true);
	add(dadAlt);

	camFollow.setPosition(dadAlt.x + 250, dadAlt.y + 100);
	FlxG.sound.play(Paths.sound("wellWellWell"));

	dadAlt.animation.finishCallback = function(anim)
	{
		camFollow.setPosition(bf.x, bf.y);
		FlxG.sound.play(Paths.sound("bfBeep"));
		bf.playAnim("singUP");
		new FlxTimer().start(0.7, function(timer)
		{
			camFollow.setPosition(dadAlt.x + 250, dadAlt.y + 100);
			dadAlt.animation.play("pt2", true);
			FlxG.sound.play(Paths.sound("killYou"));

			dadAlt.animation.finishCallback = function(anim)
			{
				new FlxTimer().start(1.70, function(timer)
				{
					dad.visible = true;
					dadAlt.destroy();
				});

				startCountdown();
			};
		});
	};
}
