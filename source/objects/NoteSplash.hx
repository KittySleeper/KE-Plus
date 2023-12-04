package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite{
    override public function new(x:Float, y:Float, noteData:Int) {
        super(x, y);

        var anims = ["purple" + FlxG.random.int(1, 2), "blue" + FlxG.random.int(1, 2), "green" + FlxG.random.int(1, 2), "red" + FlxG.random.int(1, 2)];

        frames = Paths.getSparrowAtlas("noteSplashes");

        animation.addByPrefix("purple1", "note impact 1 purple", false);
        animation.addByPrefix("purple2", "note impact 2 purple", false);
        animation.addByPrefix("blue1", "note impact 1  blue", false);
        animation.addByPrefix("blue2", "note impact 2 blue", false);
        animation.addByPrefix("green1", "note impact 1 green", false);
        animation.addByPrefix("green2", "note impact 2 green", false);
        animation.addByPrefix("red1", "note impact 1 red", false);
        animation.addByPrefix("red2", "note impact 2 red", false);

        animation.play(anims[noteData]);

        animation.finishCallback = function(name){
            kill();
        };

        alpha = FlxG.random.float(0.6, 1);
    }
}