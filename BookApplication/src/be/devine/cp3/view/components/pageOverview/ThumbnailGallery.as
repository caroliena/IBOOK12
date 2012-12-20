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

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.Polygon;

public class ThumbnailGallery extends Sprite{

    private var appModel:AppModel;
    private var thumbnailContainer:Sprite;
    private var background:Quad;
    private var pointer:Polygon;

    public function ThumbnailGallery() {

        this.appModel = AppModel.getInstance();

        background = new Quad(768,210,0x000000);
        background.alpha = 0.75;
        addChild(background);

        thumbnailContainer = new Sprite();
        addChild(thumbnailContainer);

        var i:uint = 0;
        for each( var thumbnail:Image in appModel.thumbnails ){
            thumbnail.x = i * (thumbnail.width + 20);
            thumbnail.y = 35;
            thumbnail.alpha = 0.9;
            thumbnail.addEventListener(TouchEvent.TOUCH, mouseThumbnailHandler);
            thumbnail.useHandCursor = true;
            thumbnailContainer.addChild(thumbnail);
            i++
        }
        pointer = new Polygon(14,3,0x000000);
        pointer.x = appModel.thumbnails[appModel.currentThumbnailIndex].x + (thumbnail.width/2);
        pointer.y = 8;
        pointer.rotation = 1.57079633;     //rotatie gebeurd in radialen in starling

        thumbnailContainer.x = ((768/2) - (thumbnail.width/2) - appModel.thumbnails[0].x);
        thumbnailContainer.addChildAt(pointer,0);

        appModel.addEventListener(AppModel.OVERVIEW_CLICKED,overviewClickHandler);
    }

    private function overviewClickHandler(event:flash.events.Event):void {
        if(appModel.overviewFlag) this.addEventListener(starling.events.Event.ENTER_FRAME, scrollHandler);
        else this.removeEventListener(starling.events.Event.ENTER_FRAME, scrollHandler);
    }

    private function scrollHandler(event:starling.events.Event):void {
        var scrollSpeed:int = 10;
        if( appModel.mouseCoords.x <=150 && thumbnailContainer.x < 768/2) thumbnailContainer.x += scrollSpeed;
        if( appModel.mouseCoords.x >=618 && thumbnailContainer.x > (768/2 - thumbnailContainer.width )) thumbnailContainer.x -= scrollSpeed;
    }

    private function mouseThumbnailHandler(event:TouchEvent):void {
        var thumbnail:DisplayObject = event.target as DisplayObject;
        var touch:Touch = event.getTouch(thumbnail);

            var tweenAlpha:Tween = new Tween(thumbnail, 0.2, Transitions.EASE_IN);
            if(event.getTouch(thumbnail, TouchPhase.HOVER)){
                tweenAlpha.animate("alpha", 1);
                appModel.currentThumbnailIndex = appModel.thumbnails.indexOf(thumbnail);
            }else{ tweenAlpha.animate("alpha", 0.9); }
            Starling.juggler.add(tweenAlpha);

            if(event.getTouch(thumbnail, TouchPhase.ENDED)){

                if(!appModel.animating){
                    appModel.direction = appModel.thumbnails.indexOf(thumbnail) < appModel.pages.indexOf(appModel.currentPage) ? 'right':'left';
                    appModel.currentPage = appModel.pages[appModel.currentThumbnailIndex];

                    var tweenMoveContainer:Tween = new Tween( thumbnailContainer, 0.5, Transitions.EASE_IN);
                    tweenMoveContainer.animate("x", ((768/2) - (thumbnail.width/2) - thumbnail.x));
                    Starling.juggler.add(tweenMoveContainer);

                    var tweenMoveArrow:Tween = new Tween( pointer, 0.5, Transitions.EASE_IN);
                    tweenMoveArrow.animate("x", appModel.thumbnails[appModel.currentThumbnailIndex].x + (thumbnail.width/2));
                    Starling.juggler.add(tweenMoveArrow);
                }
            }

    }
}
}
