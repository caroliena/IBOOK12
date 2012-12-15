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

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;

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
        Starling.current.stage.addEventListener(TouchEvent.TOUCH, mouseMoveHandler);
    }

    private function previousClickHandler(event:starling.events.Event):void {
        appModel.previous();
    }

    private function nextClickHandler(event:starling.events.Event):void {
        appModel.next();
    }

    private function mouseMoveHandler(event:TouchEvent):void
    {
        var touch:Touch = event.getTouch(Starling.current.stage);

        if( touch != null )
        {
            if( touch.phase == "hover" )
            {
                previousButton.alpha = touch.globalX <= 200 ? (1 - ( int( ((touch.globalX) / 200) *100) / 100)) : 0;
                nextButton.alpha = touch.globalX >= Starling.current.stage.stageWidth - 200 ? (1 - (Starling.current.stage.stageWidth - touch.globalX) / 200) : 0;
            }
        }
    }
}
}
