function create() {
    defaultCamZoom = 0.9;
	curStage = 'stage';
	var bg:BGSprite = new BGSprite('stageback', -600, -200, 0.9, 0.9);
	bg.antialiasing = true;
	bg.active = false;
	add(bg);

	var stageFront:BGSprite = new BGSprite('stagefront', -650, 600, 0.9, 0.9);
	stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
	stageFront.updateHitbox();
	stageFront.antialiasing = true;
	stageFront.active = false;
	add(stageFront);

	var stageCurtains:BGSprite = new BGSprite('stagecurtains', -500, -300, 1.3, 1.3);
	stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
	stageCurtains.updateHitbox();
	stageCurtains.antialiasing = true;
	stageCurtains.active = false;
	
	add(stageCurtains);
}