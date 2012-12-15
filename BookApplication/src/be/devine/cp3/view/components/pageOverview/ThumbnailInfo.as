/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {
import be.devine.cp3.model.AppModel;

import flash.events.Event;

import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;

public class ThumbnailInfo extends Sprite {

    private var appModel:AppModel;

    private var background:Quad;
    private var pageNumberField:starling.text.TextField;
    private var titleField:starling.text.TextField;

    public function ThumbnailInfo() {
        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.addEventListener(AppModel.CURRENT_THUMBNAIL_CHANGED, currentThumbnailChangedHandler);
        background = new Quad(768,50,appModel.currentPage.themecolor);
        addChild(background);
    }

    private function currentThumbnailChangedHandler(event:Event):void {
        display();
    }

    private function display():void {
        var pageNumberText:String = "Pagina " + (appModel.currentThumbnailIndex + 1);

        if( this.contains(pageNumberField) ){
            this.removeChild(pageNumberField);
        }
        if( this.contains(titleField) ){
            this.removeChild(titleField);
        }

        pageNumberField = new starling.text.TextField(100,30,pageNumberText.toUpperCase(),"Arial",11,0xffffff);
        pageNumberField.autoScale = false;
        pageNumberField.x = 35;
        pageNumberField.y = 10;
        pageNumberField.hAlign = HAlign.LEFT;
        addChild(pageNumberField);

        if(appModel.pages[appModel.currentThumbnailIndex].title != null){

            var titleText:String = appModel.pages[appModel.currentThumbnailIndex].title;
            titleField = new starling.text.TextField(600,30,titleText.toUpperCase(),"Arial",11,0xffffff);
            titleField.autoScale = false;
            titleField.x = 135;
            titleField.y = 10;
            titleField.hAlign = HAlign.LEFT;
            addChild(titleField);

        }


    }

    private function currentPageChangedHandler(event:Event):void {
        background.color = appModel.currentPage.themecolor;
        display();

    }
}
}
