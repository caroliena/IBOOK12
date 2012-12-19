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

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class PageOverview extends Sprite {

    private var appModel:AppModel;
    private var pageOverviewContainer:Sprite;
    private var thumbnailGallery:ThumbnailGallery;
    private var thumbnailInfo:ThumbnailInfo;

    [Embed(source = "/assets/ui/button_overview.png")]
    //[Embed(source = "/assets/ui/button_overviewdown.png")]
    private static const Sausage:Class;

    public function PageOverview()
    {
        this.appModel = AppModel.getInstance();

        var sausageBitmap:Bitmap = new Sausage();
        var upstate:Texture = Texture.fromBitmap(sausageBitmap);

        //var thumbnailBitmap:Bitmap = task.content as Bitmap;
        //var thumbnail:Image = new Image(Texture.fromBitmap(thumbnailBitmap));
        //var bmpData:BitmapData = new BitmapData(768, 50, false, 0xFF0000);
        //var texture:Texture = Texture.fromBitmapData(bmpData);

        //var upstate:Texture = Texture.fromBitmap ( new embeddedBitmap() );

        thumbnailGallery = new ThumbnailGallery();
        thumbnailGallery.height = 200;

        thumbnailInfo = new ThumbnailInfo(upstate,'',upstate); //downstate toevoegen zorgt dat de button ni verkleint
        thumbnailInfo.height = 50;
        thumbnailInfo.y = 200;

        pageOverviewContainer = new Sprite();
        pageOverviewContainer.y = -200;

        pageOverviewContainer.addChild(thumbnailGallery);
        pageOverviewContainer.addChild(thumbnailInfo);
        addChild(pageOverviewContainer);

        thumbnailInfo.addEventListener(starling.events.Event.TRIGGERED, overviewClickHandler);
        appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler);
    }

    private function mouseMoveHandler(event:flash.events.Event):void {
        thumbnailInfo.alpha = appModel.mouseCoords.y <= 150 ? (1 - ((appModel.mouseCoords.y - 50)/150)) : 0;
    }

    private function overviewClickHandler(event:starling.events.Event):void {

        appModel.overviewFlag = !appModel.overviewFlag; //inverteren van boolean waarde.

        var alphaTween:Tween = new Tween(thumbnailInfo,1.0,Transitions.EASE_IN_OUT);
        alphaTween.animate('alpha',(appModel.overviewFlag ? 1 : 0));
        alphaTween.onComplete = function():void{
            appModel.overviewFlag ? appModel.removeEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler):appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED, mouseMoveHandler);
            var tweenOpen:Tween = new Tween(pageOverviewContainer, 1.0, Transitions.EASE_IN_OUT);
            tweenOpen.animate("y", (appModel.overviewFlag ? +0 : -200));
            Starling.juggler.add(tweenOpen);
        }
        Starling.juggler.add(alphaTween);

    }


}
}
