function create()
{
	camHUD.visible = false;

	var vid = new FlxVideo();
	vid.play(Paths.video("stressCutscene"));
	vid.onEndReached.add(function()
	{
		vid.dispose();
		camHUD.visible = true;
		startCountdown();
	});
	add(vid);
}