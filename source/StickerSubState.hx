package;

import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class StickerSubState extends MusicBeatSubstate {
    public var stickers:Array<FlxSprite> = [];
    var nextState:FlxState;
    var resetState:Bool = false;
    var requiredStickerCount:Int = 45; // Declare and initialize requiredStickerCount here

    override public function new(nextState:FlxState, resetState:Bool = false) {
        super();

        this.nextState = nextState;
        this.resetState = resetState;

        for (i in 0...requiredStickerCount) {
            placeSticker("bfSticker1");
            placeSticker("bfSticker2");
            placeSticker("bfSticker3");
            placeSticker("gfSticker1");
            placeSticker("gfSticker2");
            placeSticker("gfSticker3");
            placeSticker("dadSticker1");
            placeSticker("dadSticker2");
            placeSticker("dadSticker3");
            placeSticker("momSticker1");
            placeSticker("momSticker2");
            placeSticker("momSticker3");
            placeSticker("picoSticker1");
            placeSticker("picoSticker2");
            placeSticker("picoSticker3");
            placeSticker("monsterSticker1");
            placeSticker("monsterSticker2");
            placeSticker("monsterSticker3");
        }
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        // Debug log to check the number of stickers
        trace("Number of stickers: " + stickers.length);

        if (stickers.length >= requiredStickerCount) {
            trace("Transitioning...");
            if (resetState)
                FlxG.resetState();
            else
                FlxG.switchState(nextState);

            PlayState.instance.transIn = FlxTransitionableState.defaultTransIn;
            PlayState.instance.transOut = FlxTransitionableState.defaultTransOut;
        }
    }

    function placeSticker(stickerName:String) {
        var sticker = new FlxSprite(FlxG.random.float(-FlxG.width, FlxG.width), FlxG.random.float(-FlxG.height, FlxG.height)).loadGraphic(Paths.image("transitionSwag/Base Game Stickers/" + stickerName));
        sticker.angle = FlxG.random.int(-60, 70);
        sticker.scrollFactor.set();
        stickers.push(sticker);
        add(sticker);
    }

    public function degenStickers():Void {
        if (stickers.length == 0) {
            return;
        }

        for (i in 0...stickers.length) {
            var sticker = stickers[i];
            new FlxTimer().start(0.5, function(_) {
                sticker.visible = false;
                var daSound:String = FlxG.random.getObject(["sound1", "sound2", "sound3"]); // replace with your sound names
                new FlxSound().loadEmbedded(Paths.sound(daSound)).play();
            });
        }
    }
}