/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 1/12/12
 * Time: 11:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;

import flash.events.Event;


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


        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);

        display();


    }

    private function display():void {

        if( this.contains(pageNumberField) ){

            this.removeChild(pageNumberField);

        }

        var textLeft:String = "iTravel I " + appModel.currentPage.theme;

        pageNumberField = new TextField(768,30,textLeft,'EdmondSans',11,0x000000);
        pageNumberField.autoScale = false;
        addChild(pageNumberField);

    }

    /*
     * van Nicholas: Crash bug gefixed. binnenkomend argument in currentPageChangeHandler moet event.flash.Events zijn en niet AppModel.
     * (AppModel word standaard als argument meegegeven als je deze functie auto genereerd. let hierop ^^)
     */
    private function currentPageChangedHandler(event:flash.events.Event):void {

        display();

    }
}
}
