/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {
import be.devine.cp3.model.AppModel;

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

    public function ThumbnailGallery() {

        this.appModel = AppModel.getInstance();

        background = new Quad(768,210,0x000000);
        background.alpha = 0.9;
        addChild(background);

        thumbnailContainer = new Sprite();
        addChild(thumbnailContainer);
        var i:uint = 0;
        for each( var thumbnail:Image in appModel.thumbnails ){
            thumbnail.x = i * (thumbnail.width + 20);
            thumbnail.y = 35;
            thumbnail.addEventListener(TouchEvent.TOUCH, mouseThumbnailHandler);
            thumbnailContainer.addChild(thumbnail);
            i++
        }

        addEventListener(TouchEvent.TOUCH, scrollHandler);

    }

    private function scrollHandler(event:TouchEvent):void {

        var touch:Touch = event.getTouch(this);
        var scrollSpeed:int = 15;

        if( touch!= null && touch.phase == "hover"){
            if( touch.globalX <=150 && thumbnailContainer.x < 768/2) thumbnailContainer.x += scrollSpeed;
            if( touch.globalX >=618 && thumbnailContainer.x > (768/2 - thumbnailContainer.width )) thumbnailContainer.x -= scrollSpeed;
        }

    }

    private function mouseThumbnailHandler(event:TouchEvent):void {
        var touch:Touch = event.getTouch(this);
        trace('touch: ' + touch);
        if( touch!= null && touch.phase == "hover" ){
            appModel.currentThumbnailIndex = appModel.thumbnails.indexOf(event.target);
        }

        if( touch!= null && touch.phase == "ended" ) appModel.currentPage = appModel.pages[appModel.currentThumbnailIndex];

    }
}
}
