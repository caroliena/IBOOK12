/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {
import be.devine.cp3.model.AppModel;

import flash.events.Event;

import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;


public class ThumbnailGallery extends Sprite{

    private var appModel:AppModel;
    private var thumbnailContainer:Sprite;

    private var background:Quad;
    //private var pointer:Polygon;

    public function ThumbnailGallery() {

        this.appModel = AppModel.getInstance();

        background = new Quad(768,210,0x000000);
        background.alpha = 0.8;
        addChild(background);

        //TODO Pointer toe te voegen voor actieve pagina
        //pointer = new Polygon(0,3,appModel.currentPage.themeColor);
        //thumbnailContainer.addChild(pointer);

        thumbnailContainer = new Sprite();
        addChild(thumbnailContainer);
        var i:uint = 0;
        for each( var thumbnail:Image in appModel.thumbnails ){
            thumbnail.x = i * (thumbnail.width + 20);
            thumbnail.y = 35;
            thumbnail.alpha = 0.8;
            thumbnail.addEventListener(TouchEvent.TOUCH, mouseThumbnailHandler);
            thumbnailContainer.addChild(thumbnail);
            i++
        }
        appModel.thumbnails[appModel.currentThumbnailIndex].alpha = 1;
        appModel.addEventListener(AppModel.OVERVIEW_CLICKED,overviewClickHandler);
    }

    private function overviewClickHandler(event:flash.events.Event):void {

        if(appModel.overviewFlag){
            appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, scrollHandler);
        }else{
            appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, scrollHandler);
        }
    }

    private function scrollHandler(event:flash.events.Event):void {

        var scrollSpeed:int = 15;
        if( appModel.mouseCoords.x <=150 && thumbnailContainer.x < 768/2) thumbnailContainer.x += scrollSpeed;
        if( appModel.mouseCoords.x >=618 && thumbnailContainer.x > (768/2 - thumbnailContainer.width )) thumbnailContainer.x -= scrollSpeed;

    }

    private function mouseThumbnailHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this);

        //TODO Alpha waarden van alle andere thumbnails aanpassen
        var tweenAlpha:Tween = new Tween( appModel.thumbnails[appModel.currentThumbnailIndex], 0.5, Transitions.EASE_IN);
        tweenAlpha.animate("alpha", 1);
        Starling.juggler.add(tweenAlpha);

        if( touch!= null && touch.phase == "hover" ){
            appModel.currentThumbnailIndex = appModel.thumbnails.indexOf(event.target);
        }

        if( touch!= null && touch.phase == "ended" ){
            appModel.currentPage = appModel.pages[appModel.currentThumbnailIndex];
        }

    }
}
}
