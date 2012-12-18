/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {
import be.devine.cp3.factory.text.TextFactory;
import be.devine.cp3.model.AppModel;

import flash.events.Event;

import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.textures.Texture;

public class ThumbnailInfo extends Button{

    private var appModel:AppModel;

    private var background:Quad;
    private var pageTitleField:Sprite;
    private var pageNumberField:Sprite;

    public function ThumbnailInfo(upState:Texture, text:String="", downState:Texture=null) {
        this.appModel = AppModel.getInstance();
        //TODO: Duidelijk maken dat deze knop is om overview te openen
        super(upState, text, downState);

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.addEventListener(AppModel.CURRENT_THUMBNAIL_CHANGED, currentThumbnailChangedHandler);

        background = new Quad(768,50,appModel.themeColor);
        addChild(background);

        display();
    }


    private function currentThumbnailChangedHandler(event:Event):void {
        display();
    }

    private function display():void {

        background.color = appModel.themeColor;

        if(contains(pageTitleField)){
            removeChild(pageTitleField);
        }
        if(contains(pageNumberField)){
            removeChild(pageNumberField);
        }
        pageTitleField = TextFactory.createTextField({
            text:appModel.pages[appModel.currentThumbnailIndex].title,
            textLayout:'thmbPageTitle'
        });

        pageNumberField = TextFactory.createTextField({
            text:"Page " + (appModel.currentThumbnailIndex + 1)+" of " + appModel.pages.length,
            textLayout:'thmbPageNumber'
        });

        pageTitleField.x = 110;
        pageTitleField.y = 11;
        addChild(pageTitleField);

        pageNumberField.x = 15;
        pageNumberField.y = 15;
        pageNumberField.alpha = 0.7;
        addChild(pageNumberField);
    }

    private function currentPageChangedHandler(event:Event):void {
        display();
    }
}
}
