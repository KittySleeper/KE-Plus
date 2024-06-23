import flixel.math.FlxMath;

var state;
var inRumble = false;

function create() {
    state = FlxG.state;

    inRumble = state.storyDifficulty.toLowerCase() == "rumble";
}

function createPost() {}

var left:Bool = false;
var strumIndex = -1;

function update(elapsed) {
    if (inRumble) {
        if (state.SONG.notes[Math.floor(curStep / 16)] != null)
        {
            left = !state.SONG.notes[Math.floor(curStep / 16)].mustHitSection;
        }
        
        if (left) {
            state.camHUD.angle = FlxMath.lerp(-20, state.camHUD.angle, 0.95);

            /*for (strum in state.playerStrums.members) {
                strumIndex++;
                strum.x = FlxMath.lerp((strumIndex * 110) + 10000, strum.x, 0.95);
            }

            for (strum in state.cpuStrums.members) {
                strumIndex++;
                strum.x = FlxMath.lerp((strumIndex * 110), strum.x, 0.95);
            }*/
        } else {
            state.camHUD.angle = FlxMath.lerp(20, state.camHUD.angle, 0.95);

            /*for (strum in state.playerStrums.members) {
                strumIndex++;
                strum.x = FlxMath.lerp((strumIndex * 110) + 420, strum.x, 0.95);
            }

            for (strum in state.cpuStrums.members) {
                strumIndex++;
                strum.x = FlxMath.lerp((strumIndex * 110) + 10000, strum.x, 0.95);
            }*/
        }

        strumIndex = -1;
    }
}