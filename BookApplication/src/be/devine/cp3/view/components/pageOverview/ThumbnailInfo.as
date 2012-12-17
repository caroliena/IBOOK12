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

import flash.display.BitmapData;

import flash.events.Event;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;

public class ThumbnailInfo extends starling.display.Button{

    private var appModel:AppModel;

    private var background:Quad;

    public function ThumbnailInfo(upState:Texture, text:String="", downState:Texture=null) {
        this.appModel = AppModel.getInstance();

        super(upState, text, downState);

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.addEventListener(AppModel.CURRENT_THUMBNAIL_CHANGED, currentThumbnailChangedHandler);

        //TODO Afstemmen op themekleur appModel.currentPage.themecolor
        //background = new Quad(768,50,0x000000);
        //addChild(background);
    }


    private function currentThumbnailChangedHandler(event:flash.events.Event):void {
        display();
    }

    private function display():void {

        if(contains(pageTitleField)){
            removeChild(pageTitleField);
        }
        if(contains(pageNumberField)){
            removeChild(pageNumberField);
        }
        var pageTitleField:Sprite = TextFactory.createTextField({
            text:'appModel.currentPage.elements',
            textLayout:'pageInfo'
        });

        var pageNumberField:Sprite = TextFactory.createTextField({
            text:"Pagina " + (appModel.currentThumbnailIndex + 1),
            textLayout:'pageInfo'
        });

        pageTitleField.x = 100;
        pageTitleField.y = -300;
        addChild(pageTitleField);

        pageNumberField.x = 35;
        pageNumberField.y = -300;
        addChild(pageNumberField);
    }

    private function currentPageChangedHandler(event:flash.events.Event):void {
        //TODO: Aanpassen aan de kleur;
        //background.color = appModel.currentPage.themecolor;
        display();

    }
}
}
