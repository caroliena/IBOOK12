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

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;

public class ReadingControls extends Sprite{

    private var appModel:AppModel;

    private var previousButton:PreviousButton;
    private var nextButton:NextButton;
    private var pageOverview:PageOverview;
    private var overviewFlag:Boolean = false;

    public function ReadingControls() {
        this.appModel = AppModel.getInstance();

        previousButton = new PreviousButton();
        previousButton.x = 0;
        addChild(previousButton);

        nextButton = new NextButton();
        nextButton.x = (Starling.current.stage.stageWidth - nextButton.width);
        addChild(nextButton);

        //pageOverview = new PageOverview();
        //pageOverview.addEventListener(pageOverview.OVERVIEW_CLICKED,overviewClickHandler);
        //addChild(pageOverview);

        previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
        nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        Starling.current.stage.addEventListener(TouchEvent.TOUCH, mouseMoveHandler);
    }

    private function overviewClickHandler(event:starling.events.Event):void {

        if(overviewFlag){
            overviewFlag=false;

            previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
            nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        }else{
            overviewFlag=true;

            previousButton.removeEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
            nextButton.removeEventListener(starling.events.Event.TRIGGERED, nextClickHandler);

            previousButton.alpha = nextButton.alpha = 0;
            pageOverview.alpha = 1;
        }
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
                //pageOverview.alpha = touch.globalY <= 150 ? (1 - ( int( ((touch.globalY) / 150) *100) / 100)) : 0;
                previousButton.alpha = touch.globalX <= 200 ? (1 - ( int( ((touch.globalX) / 200) *100) / 100)) : 0;
                nextButton.alpha = touch.globalX >= Starling.current.stage.stageWidth - 200 ? (1 - (Starling.current.stage.stageWidth - touch.globalX) / 200) : 0;
            }
        }
    }
}
}
