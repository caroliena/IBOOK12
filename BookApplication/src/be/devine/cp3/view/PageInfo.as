/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 1/12/12
 * Time: 11:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view {
import be.devine.cp3.factory.text.TextFactory;
import be.devine.cp3.model.AppModel;

import flash.events.Event;

import starling.display.Sprite;

[SWF(backgroundColor="#000000")]
public class PageInfo extends Sprite{

    private var appModel:AppModel;

    public function PageInfo() {

        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        currentPageChangedHandler();
    }

    private function display():void
    {
        var pageThemeField:Sprite = TextFactory.createTextField({
            text:"iTRAVEL | " + appModel.currentPage.theme,
            textLayout:'pageInfo'
        });

        var pageNumberField:Sprite = TextFactory.createTextField({
            text:'P' +  (appModel.pages.indexOf(appModel.currentPage) + 1) ,
            textLayout:'pageInfo'
        });

        pageThemeField.x = 35;
        pageThemeField.y = 10;
        addChild(pageThemeField);

        pageNumberField.x = 710;
        pageNumberField.y = 10;
        addChild(pageNumberField);
    }

    /*
     * van Nicholas: Crash bug gefixed. binnenkomend argument in currentPageChangeHandler moet event.flash.Events zijn en niet AppModel.
     * (AppModel word standaard als argument meegegeven als je deze functie auto genereerd. let hierop ^^)
     */
    private function currentPageChangedHandler(event:Event=null):void {
        while(numChildren){removeChildAt(0);}

        switch (appModel.currentPage.type){
            case 2:
            case 3:
            case 5:
                display();
                break;
            case 1:
            case 4:
                //no go, no show
                break;
        }

    }
}
}
