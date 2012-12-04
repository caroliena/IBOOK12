package {

import be.devine.cp3.IBook;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;


public class Main extends flash.display.Sprite
{

    private var starling:Starling;


    public function Main()
    {
        /* Setup stage align and mode. */
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = 420;
        stage.nativeWindow.height = 594;
        stage.nativeWindow.bounds = new Rectangle(stage.nativeWindow.x,stage.nativeWindow.y,420,594);

        starling = new Starling(IBook, stage);
        starling.start();

        stage.addEventListener(Event.RESIZE, layout);
        layout();

    }

    private function layout(event:Event = null):void
    {
        /*
        if(app != null)
        {
            app.x = (stage.stageWidth - app.width) * 0.5;
            app.y = 10;
        }
        */
    }

}
}
