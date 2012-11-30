package {

import be.devine.cp3.view.IBook;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;

public class Main extends Sprite
{

    public function Main()
    {
        /* Setup stage align and mode. */
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = 420;
        stage.nativeWindow.height = 594;
        stage.nativeWindow.bounds = new Rectangle(stage.nativeWindow.x,stage.nativeWindow.y,420,594);

        var iBook:IBook = new IBook();
        addChild(iBook);
        //appModel.loadXML();
    }


}
}
