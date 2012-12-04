/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 1/12/12
 * Time: 11:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;


import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import starling.display.Quad;

import starling.display.Sprite;
import starling.text.TextField;


public class PageInfo extends starling.display.Sprite{

    private var appModel:AppModel;

    private var background:Quad;
    private var pageNumberField:TextField;

    public function PageInfo() {

        this.appModel = AppModel.getInstance();

        background = new Quad(768,30,0x333333);
        addChild(background);

        pageNumberField = new TextField(768,30,'test','EdmondSans',11,0xffffff);
        pageNumberField.autoScale = false;
        addChild(pageNumberField);

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);


    }

    private function currentPageChangedHandler(event:AppModel):void {

        trace('hier moet de pagina ook aanpassen');

    }
}
}
