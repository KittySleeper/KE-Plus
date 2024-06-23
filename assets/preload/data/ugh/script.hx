import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

var state;
var canBeep = false;
var hasBeeped = false;
var dadAlt:FlxSprite;
var tankTalk = false;

function create() {
    state = FlxG.state;

    state.inCutscene = true;
    state.songHasCutscene = true;
}

function createPost() {
    if (state.inCutscene) {
        state.dad.visible = false;
        state.camHUD.alpha = 0.0001;
        FlxTween.tween(FlxG.camera, {zoom: state.defaultCamZoom + 0.15}, 0.6);

        FlxG.sound.playMusic(Paths.music("DISTORTO"), 0);
        FlxG.sound.music.fadeIn(5, 0, 0.5);

        dadAlt = new FlxSprite(state.dad.x - 80, state.dad.y + 40);
        dadAlt.frames = Paths.getSparrowAtlas("cutsene/ugh/tankTalkSong1");
        dadAlt.animation.addByPrefix('pt1', 'TANK TALK 1 P1', 24, false);
        dadAlt.animation.addByPrefix('pt2', 'TANK TALK 1 P2', 24, false);
        dadAlt.animation.play("pt1", true);
        add(dadAlt);

        FlxG.sound.play(Paths.sound("wellWellWell"), 1, false, null, true, function() {
            canBeep = true;

            camFollow.setPosition(state.boyfriend.x, state.boyfriend.y + 70);
        });

        camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
    }
}

function update(elapsed) {
    if (state.inCutscene) {
        if (canBeep) {
            if (state.controls.UP_P) {
                hasBeeped = true;

                FlxG.sound.play(Paths.sound("bfBeep"));
                state.boyfriend.playAnim("singUP", true);
            }

            if (hasBeeped && state.controls.ACCEPT) {
                canBeep = false;
                state.boyfriend.dance();

                camFollow.setPosition(dadAlt.x + 400, dadAlt.y + 220);
                FlxG.sound.play(Paths.sound("killYou"), 1, false, null, true, function() {
                    state.startCountdown();
                    FlxTween.tween(state.camHUD, {alpha: 1}, 0.2);
                });        
                dadAlt.animation.play("pt2", true);
            }
        }
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