/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.XmlTask;
import be.devine.cp3.utils.Misc;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.ProgressEvent;
import flash.ui.Keyboard;

public class IBook extends Sprite{

    //Constructor
    private var appModel:AppModel;
    private var queue:Queue;
    private var misc:Misc;
    private var pageContainer:Sprite;
    private var page:Page;

    public function IBook()
    {
        appModel = AppModel.getInstance();
        misc = Misc.getInstance();
        pageContainer = new Sprite();
        page = new Page();
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void
    {
        this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        appModel.addEventListener(AppModel.XML_URL_CHANGED, xmlUrlChangedHandler);
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.loadXML();
    }


    private function xmlUrlChangedHandler(event:Event):void
    {
        queue = new Queue();
        queue.add(new XmlTask(appModel.xmlUrl));
        queue.start();
        queue.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        queue.addEventListener(Event.COMPLETE, xmlCompleteHandler);
    }

    private function progressHandler(event:ProgressEvent):void
    {
        misc.debug(event.bytesLoaded+" = event.bytesLoaded");
        misc.debug(event.bytesTotal+" = event.bytesTotal");
    }

    private function xmlCompleteHandler(event:Event):void
    {
        var loadXML:XmlTask = queue.completedTasks[0];
        var rawXML:XML = new XML(loadXML.data);

        for each(var page:Object in rawXML.children())
        {
            appModel.pageArray.push
            ({
                title: page.title,
                paragraph: page.paragraph,
                image: page.image
            });

        }
        appModel.currentPage = 0;
        addChild(pageContainer);
        pageContainer.addChild(this.page);

        layout();
        stage.addEventListener(Event.RESIZE, layout);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardHandler);
    }

    private function keyBoardHandler(event:KeyboardEvent):void
    {
        var key:uint = event.keyCode;
        switch(key)
        {
            case Keyboard.LEFT: appModel.goToPrevPage();
            break;

            case Keyboard.RIGHT: appModel.goToNextPage();
            break;
        }
    }

    private function currentPageChangedHandler(event:Event):void {

        var pageDetails:Object = appModel.pageArray[appModel.currentPage];
        misc.removeChildrenOf(page);
        page.setPage(pageDetails);
        layout();
    }

    private function layout(event:Event = null):void {

        trace("zou moetn verandern.");
        if(pageContainer)
        {
            pageContainer.x = (stage.stageWidth - pageContainer.width) >> 1;
            pageContainer.y = (stage.stageHeight - pageContainer.height) >> 1;
        }

    }

    //getters/setters


}
}
