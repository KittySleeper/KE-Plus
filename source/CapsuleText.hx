package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CapsuleText extends FlxSprite {
    public var label:FlxText;
    public var songName:String;

    public function new(x:Float, y:Float, songName:String) {
        super(x, y);
        this.songName = songName;

        label = new FlxText(x, y, 200, songName);
        label.setFormat(null, 16, FlxColor.WHITE, "center");
        add(label);

        // Adjust size and position if needed
        this.setSize(200, 50); // Adjust size as needed
        this.setPosition(x, y);
    }

    public function setHoverState():Void {
        label.color = FlxColor.RED;
    }

    public function resetState():Void {
        label.color = FlxColor.WHITE;
    }
}