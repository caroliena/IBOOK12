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

import starling.display.Button;
import starling.events.TouchEvent;

import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;

[SWF(backgroundColor="0xec9900")]
public class PageDetail extends Sprite{

    private var appModel:AppModel;

    private var pageContainer:Sprite;
    private var pageNumberField:TextField;
    private var previousButton:starling.display.Button;
    private var nextButton:starling.display.Button;

    public function PageDetail()
    {
        this.appModel = AppModel.getInstance();

        pageContainer = new Sprite();
        addChild(pageContainer);

        var quad:Quad = new Quad(768,1024,0xFF0000);
        pageContainer.addChild(quad);

        var bmpData:BitmapData = new BitmapData(25, 1024, false, 0x00ff00);

        previousButton = new Button(Texture.fromBitmapData(bmpData));
        previousButton.x = 0;
        previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
        pageContainer.addChild(previousButton);

        nextButton = new Button(Texture.fromBitmapData(bmpData));
        nextButton.x = 768-25;
        nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        pageContainer.addChild(nextButton);

        var text:String = appModel.currentPage.image;


        pageNumberField = new TextField(768,50,text,'EdmondSans',40,0xffffff);
        pageNumberField.autoScale = false;
        addChild(pageNumberField);

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);



    }

    private function previousClickHandler(event:starling.events.Event):void {

          appModel.previous();
    }

    private function nextClickHandler(event:starling.events.Event):void {

          appModel.next();
    }

    private function currentPageChangedHandler(event:Event):void {

        trace('Nu moeten we de pagina aanpassen');

    }

}
}
