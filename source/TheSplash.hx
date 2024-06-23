//CUM
package;

import flixel.FlxG;
import flixel.FlxSprite;

class TheSplash extends FlxSprite
{
    function create() {
        frames = Paths.getSparrowAtlas('noteSplashes', 'shared');
        animation.addByPrefix("0", "note impact 1 purple", 24, false);
        animation.addByPrefix("1", "note impact 1  blue", 24, false);
        animation.addByPrefix("2", "note impact 1 green", 24, false);
        animation.addByPrefix("3", "note impact 1 red", 24, false);
    }
}
