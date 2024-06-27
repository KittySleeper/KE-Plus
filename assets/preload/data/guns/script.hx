import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

var state;
var tankTalk = false;
var dadAlt:FlxSprite;

function create() {
    state = FlxG.state;

    state.inCutscene = true;
    state.songHasCutscene = true;
}

function createPost() {
    if (state.inCutscene) {
        state.dad.visible = false;
        state.camHUD.alpha = 0.0001;
        FlxTween.tween(FlxG.camera, {zoom: state.defaultCamZoom + 0.15}, 0.5);

        FlxG.sound.playMusic(Paths.music("DISTORTO"), 0);
        FlxG.sound.music.fadeIn(5, 0, 0.5);

        dadAlt = new FlxSprite(state.dad.x - 80, state.dad.y + 40);
        dadAlt.frames = Paths.getSparrowAtlas("cutsene/guns/tankTalkSong2");
        dadAlt.animation.addByPrefix('talk', 'TANK TALK 2', 24, false);
        dadAlt.animation.play("talk", true);
        add(dadAlt);

        FlxG.sound.play(Paths.sound("tankSong2"), 1, false, null, true, function() {
            state.startCountdown();
            FlxTween.tween(state.camHUD, {alpha: 1}, 0.2);
        });

        camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
    }
}

function update(elapsed) {
    if (dadAlt.animation.curAnim.curFrame == 99) {
        state.gf.playAnim("cry", true);
        FlxTween.tween(FlxG.camera, {zoom: state.defaultCamZoom + 0.35}, 0.6, {onComplete: function() {
            FlxTween.tween(FlxG.camera, {zoom: state.defaultCamZoom - 0.10}, 0.8);
        }});
    }
}

function playerTwoSing(note) {
    if (dadAlt != null) {
        dadAlt.visible = false;
        state.dad.visible = true;
    }
}

function gameOver() {
    trace("oof");
}

function updateDead() {
    if (tankTalk)
        FlxG.sound.music.volume = 0.2;
    
    if (gameOverScreen.bf.animation.curAnim.name == 'firstDeath' && gameOverScreen.bf.animation.curAnim.finished) {
        tankTalk = true;

        FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25)), 1, false, null, true, function()
        {
            tankTalk = false;
            FlxG.sound.music.fadeIn(4, 0.2, 1);
        });    
    }
}