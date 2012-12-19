package {

import be.devine.cp3.IBook;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.geom.Rectangle;

import starling.core.Starling;

[SWF(width="1024", height="768", frameRate="60", backgroundColor="#ffffff")]

public class Main extends Sprite
{
    private var starling:Starling;

    public function Main()
    {
        /* Setup stage align and mode. */
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = 768;
        stage.nativeWindow.height = 1024;
        stage.nativeWindow.bounds = new Rectangle(stage.nativeWindow.x,stage.nativeWindow.y,768,1024);

        starling = new Starling(IBook, stage);
        starling.antiAliasing = 2;
        starling.start();

        /*
            TODO: Pas op einde - Niet resizable maken
            TODO: ATF images
            TODO: Testen snelheid met programmatje??
            TODO: Optimaliseren voor presentatie&screencast xml: kleuren goedzetten & thumbnails maken
            TODO: Preloader nodig?
            TODO: Graphics: next, previous, link background over/hover, overview over/hover, punt voor thumbnailgallery
            TODO: Code optimaliseren
            TODO: Pointer kleur aanpassen lukt niet met color - nog oplossing bedenken
            aanpassen in IBook.xml
            <systemChrome>none</systemChrome>
            <minimizable>false</minimizable>
            <maximizable>false</maximizable>
            <resizable>false</resizable>
         */

    }



}
}
