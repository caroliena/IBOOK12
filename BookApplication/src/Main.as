package {

import be.devine.cp3.view.IBook;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;

public class Main extends Sprite
{

    public static var w:int = (768/100) * 75;
    public static var h:int = (1024/100) * 75;

    public function Main()
    {
        /* Setup stage align and mode. */
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = w;
        stage.nativeWindow.height = h;
        stage.nativeWindow.bounds = new Rectangle(stage.nativeWindow.x,stage.nativeWindow.y,w,h);

        var iBook:IBook = new IBook();
        addChild(iBook);
        //appModel.loadXML();
    }


}
}
