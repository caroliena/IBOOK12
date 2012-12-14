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
import flash.text.Font;


import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import starling.core.Starling;

import starling.display.Quad;

import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;


public class PageInfo extends starling.display.Sprite{

    private var appModel:AppModel;
    private var background:Quad;
    private var pageNumberField:TextField;
    private var pageThemeField:TextField;

    [Embed(source='/assets/fonts/Georgia.ttf', embedAsCFF='false', fontName='Georgia')]
    public static var Georgia:Class;

    public function PageInfo() {

        this.appModel = AppModel.getInstance();

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);

        display();


    }

    private function display():void {

        if( this.contains(pageNumberField) ){

            this.removeChild(pageNumberField);

        }
        if( this.contains(pageThemeField) ){

            this.removeChild(pageThemeField);

        }

        var font:Font = new Georgia();

        var textLeft:String = "iTravel I " + appModel.currentPage.theme;
        var textRight:String = String( appModel.pages.indexOf(appModel.currentPage) );

        pageThemeField = new TextField(768,30,textLeft,font.fontName,11,0x000000);
        pageThemeField.autoScale = false;
        pageThemeField.x = 35;
        pageThemeField.hAlign = HAlign.LEFT;
        addChild(pageThemeField);

        pageNumberField = new TextField(15,30,textRight,font.fontName,11,0x000000);
        pageNumberField.autoScale = false;
        pageNumberField.x = 768-50;
        pageNumberField.hAlign = HAlign.RIGHT;
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
