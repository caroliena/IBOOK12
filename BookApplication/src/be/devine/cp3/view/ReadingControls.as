/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 15/12/12
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.buttons.NextButton;
import be.devine.cp3.view.components.buttons.PreviousButton;
import flash.events.Event;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Touch;

public class ReadingControls extends Sprite{

    private var appModel:AppModel;

    private var previousButton:PreviousButton;
    private var nextButton:NextButton;

    public function ReadingControls() {
        this.appModel = AppModel.getInstance();

        previousButton = new PreviousButton();
        previousButton.x = 0;
        addChild(previousButton);

        nextButton = new NextButton();
        nextButton.x = (Starling.current.stage.stageWidth - nextButton.width);
        addChild(nextButton);

        previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
        nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED,mouseMoveHandler);
        appModel.addEventListener(AppModel.OVERVIEW_CLICKED,overviewClickHandler);
    }
    //event:starling.events.Event
    private function overviewClickHandler(event:flash.events.Event):void {

        if(appModel.overviewFlag){

            previousButton.removeEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
            nextButton.removeEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
            appModel.removeEventListener(AppModel.MOUSE_POSITION_CHANGED,mouseMoveHandler);
            previousButton.alpha = nextButton.alpha = 0;
            previousButton.useHandCursor = nextButton.useHandCursor = false;

        }else{

            previousButton.useHandCursor = nextButton.useHandCursor = true;
            previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
            nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
            appModel.addEventListener(AppModel.MOUSE_POSITION_CHANGED,mouseMoveHandler);
        }


    }

    private function previousClickHandler(event:starling.events.Event):void {
        appModel.previous();
    }

    private function nextClickHandler(event:starling.events.Event):void {
        appModel.next();
    }

    private function mouseMoveHandler(event:Event):void
    {
        previousButton.alpha = appModel.mouseCoords.x <= 200 ? (1 - ( int( ((appModel.mouseCoords.x) / 200) *100) / 100)) : 0;
        nextButton.alpha = appModel.mouseCoords.x >= Starling.current.stage.stageWidth - 200 ? (1 - (Starling.current.stage.stageWidth - appModel.mouseCoords.x) / 200) : 0;
    }
}
}
