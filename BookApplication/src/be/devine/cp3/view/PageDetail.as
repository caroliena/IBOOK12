/**
 * Created by Nicholas Olivier on 28/11/12 at 15:46
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;

import flash.display.BitmapData;
import flash.events.Event;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.TouchEvent;
import starling.text.TextField;
import starling.textures.Texture;

[SWF(backgroundColor="0xec9900")]

public class PageDetail extends Sprite{

    private var appModel:AppModel;

    private var pageContainer:Sprite;
    private var pageNumberField:TextField;
    private var previousButton:Button;
    private var nextButton:Button;

    public function PageDetail()
    {
        this.appModel = AppModel.getInstance();

        pageContainer = new Sprite();
        var quad:Quad = new Quad(768,1024,0xFF0000);
        var bmpData:BitmapData = new BitmapData(25, 1024, false, 0x00ff00);

        addChild(pageContainer);
        pageContainer.addChild(quad);

        previousButton = new Button(Texture.fromBitmapData(bmpData));
        previousButton.x = 0;
        previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
        pageContainer.addChild(previousButton);

        nextButton = new Button(Texture.fromBitmapData(bmpData));
        nextButton.x = Starling.current.stage.stageWidth - nextButton.width; //van Nicholas: non-hardcoded positioning added
        nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        pageContainer.addChild(nextButton);

       // var text:String = appModel.pages[appModel.currentPageIndex].image;

        display();

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
    }

    private function display():void
    {
        trace('Nu moeten we de pagina aanpassen');

        var title:String = String( appModel.pages[appModel.currentPageIndex].image );
        if(pageNumberField == null)
        {
            pageNumberField = new TextField(768,50,title,'EdmondSans',40,0xffffff);
            pageNumberField.autoScale = false;
            addChild(pageNumberField);
        } else {
            pageNumberField.text = appModel.pages[appModel.currentPageIndex].image;

        }

    }

    private function previousClickHandler(event:starling.events.Event):void {

          appModel.previous();
    }

    private function nextClickHandler(event:starling.events.Event):void {

          appModel.next();
    }

    private function currentPageChangedHandler(event:Event):void {

        display();
    }

}
}
