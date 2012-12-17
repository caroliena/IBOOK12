/**
 * Created by Nicholas Olivier on 25/11/12 at 10:54
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.pageOverview.ThumbnailGallery;
import be.devine.cp3.view.components.pageOverview.ThumbnailInfo;

import flash.display.BitmapData;
import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.textures.Texture;

public class PageOverview extends starling.display.Sprite {

    private var appModel:AppModel;
    private var pageOverviewContainer:starling.display.Sprite;
    private var thumbnailGallery:ThumbnailGallery;
    private var thumbnailInfo:ThumbnailInfo;

    public function PageOverview()
    {
        this.appModel = AppModel.getInstance();

        var bmpData:BitmapData = new BitmapData(768, 50, false, 0xFF0000);
        var texture:Texture = Texture.fromBitmapData(bmpData);

        thumbnailGallery = new ThumbnailGallery();
        thumbnailGallery.height = 200;
        thumbnailInfo = new ThumbnailInfo(texture,'',texture); //downstate toevoegen zorgt dat de button ni verkleint
        thumbnailInfo.height = 50;
        thumbnailInfo.y = 200;

        pageOverviewContainer = new Sprite();
        pageOverviewContainer.y = -200;

        pageOverviewContainer.addChild(thumbnailGallery);
        pageOverviewContainer.addChild(thumbnailInfo);
        addChild(pageOverviewContainer);

        thumbnailInfo.addEventListener(starling.events.Event.TRIGGERED, overviewClickHandler);
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler);
    }

    private function mouseMoveHandler(event:flash.events.Event):void {
        thumbnailInfo.alpha = appModel.mouseCoords.y <= 150 ? (1 - ( int( ((appModel.mouseCoords.y) / 150) *100) / 100)) : 0;
    }

    private function overviewClickHandler(event:starling.events.Event):void {

        if(!appModel.overviewFlag){
            //appModel.overviewFlag=true;
            appModel.removeEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler);
            thumbnailInfo.alpha = 1;

            var tweenOpen:Tween = new Tween(pageOverviewContainer, 1.0, Transitions.EASE_IN_OUT);
            tweenOpen.animate("y", pageOverviewContainer.y + 200);
            Starling.juggler.add(tweenOpen);

        }else{
            //appModel.overviewFlag=false; //TODO Flipt hierop flash event naar starling event
            appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler);

            var tweenClose:Tween = new Tween(pageOverviewContainer, 1.0, Transitions.EASE_IN_OUT);
            tweenClose.animate("y", pageOverviewContainer.y - 200);
            Starling.juggler.add(tweenClose);
        }
    }

    private function currentPageChangedHandler(event:flash.events.Event):void {

    }

}
}
