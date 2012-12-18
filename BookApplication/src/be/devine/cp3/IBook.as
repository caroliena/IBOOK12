/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.service.PageService;
import be.devine.cp3.service.ThumbnailService;
import be.devine.cp3.view.*;

import flash.events.Event;
import flash.geom.Point;
import flash.ui.Keyboard;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.KeyboardEvent;
import starling.events.Touch;
import starling.events.TouchEvent;

public class IBook extends Sprite{

    private var appModel:AppModel;
    private var pageService:PageService;
    private var thumbnailService:ThumbnailService;

    public function IBook()
    {
        appModel = AppModel.getInstance();

        pageService = new PageService();
        pageService.addEventListener(Event.COMPLETE, pagesCompleteHandler);
        pageService.load();

        this.addEventListener(TouchEvent.TOUCH, mousePositionHandler);

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
    }

    private function pagesCompleteHandler(evt:Event):void{

        thumbnailService = new ThumbnailService();
        thumbnailService.addEventListener(Event.COMPLETE, thumbnailsCompleteHandler);
        thumbnailService.load();

    }

    private function thumbnailsCompleteHandler(event:Event):void {
        appModel.currentPage = appModel.currentThumbnailIndex = appModel.pages[0];
        appModel.theme = appModel.currentPage.theme;
        display();
    }

    private function keyDownHandler(event:KeyboardEvent):void
    {
        var key:uint = event.keyCode;
        switch(key)
        {
            case Keyboard.LEFT: appModel.previous(); break;
            case Keyboard.RIGHT: appModel.next(); break;
        }
    }

    private function mousePositionHandler(event:TouchEvent):void {

        var touch:Touch = event.getTouch(Starling.current.stage);
        if( touch != null ){
            var point:Point = new Point(touch.globalX,touch.globalY);
            appModel.mouseCoords = point;
        }
    }

    private function display():void
    {
        var page:Page = new Page();
        var pageInfo:PageInfo = new PageInfo();
        var readingControls:ReadingControls = new ReadingControls(); //TODO 3 seconden laten staan en dan laten wegfaden
        var pageOverview:PageOverview = new PageOverview();

        addChild(page);
        addChild(pageInfo);
        addChild(readingControls);
        addChild(pageOverview);

    }

}
}
