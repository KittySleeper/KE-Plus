var state;
var tankTalk = false;

function create() {
    state = FlxG.state;
}

function update(elapsed) {
    if (state.curStep == 736) {
        state.dad.canDance = false;
        state.dad.canSing = false;
        state.dad.playAnim("good", true);
    }

    if (state.curStep == 767) {
        state.dad.canDance = true;
        state.dad.canSing = true;
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