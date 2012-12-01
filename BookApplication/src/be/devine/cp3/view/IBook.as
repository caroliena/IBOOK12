/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.queue.ImageTask;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.XmlTask;
import be.devine.cp3.utils.Misc;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
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
    private var preloadBalk:Sprite;

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

        var imageQueue:Queue = new Queue();
        var pageObj:Object;
        var pageObjArr:Array = [];

        for each(var page:Object in rawXML.children())
        {
            if(page.image != undefined) pageObj = { title: page.title, paragraph: page.paragraph, image: page.image};
            else pageObj = { title: page.title, paragraph: page.paragraph};

            if(page.image != undefined) imageQueue.add( new ImageTask( page.image ));
            pageObjArr.push(pageObj);

        }
        imageQueue.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        imageQueue.addEventListener(ProgressEvent.PROGRESS, imageProgressHandler);
        imageQueue.addEventListener(Event.COMPLETE, misc.addArguments(loadImagesComplete, [pageObjArr]));
        imageQueue.start();

    }

    private function errorHandler(event:IOErrorEvent):void {
        trace("error in: "+event.currentTarget);
    }

    private function imageProgressHandler(event:ProgressEvent):void {

        /* preloadbar */
        if(preloadBalk == null)
        {
            preloadBalk = new Sprite();
            preloadBalk.graphics.beginFill(0x000000);
            preloadBalk.graphics.drawRect(0,0, stage.stageWidth, 10);
            addChild(preloadBalk);
        }

        var scale:Number = event.bytesLoaded / event.bytesTotal;

        preloadBalk.y = (stage.stageHeight - preloadBalk.height) >> 1;
        preloadBalk.scaleX = scale;
    }

    private function loadImagesComplete(event:Event, pageObjArr:Array):void
    {
        var allPagesArray:Array = pageObjArr;
        var queuedImages:Array = (event.currentTarget as Queue).completedTasks;

        for (var i:int = 0; i < allPagesArray.length; i++)
        {
            var index:int = misc.indexOf(queuedImages, function (val:*,...rest):Boolean { return val.imageUrl == allPagesArray[i].image });
            if(index != -1)
            {
                misc.setSize(queuedImages[index], Main.w - 50);
                queuedImages[index].x = (page.width - queuedImages[index].width) >> 1;
                queuedImages[index].y = (page.height - queuedImages[index].height) >> 1;
                allPagesArray[i].image = queuedImages[index];
            }
        }

        if(preloadBalk) removeChild(preloadBalk);

        appModel.pageArray = allPagesArray;
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

        trace(pageDetails.image);
        misc.removeChildrenOf(page);
        page.setPage(pageDetails);
        layout();


    }

    private function layout(event:Event = null):void {

        trace("zou moetn verandern.");

        if(pageContainer)
        {
            pageContainer.x = (stage.stageWidth - pageContainer.width) >> 1;
            pageContainer.y = 0;
            //pageContainer.y = (stage.stageHeight - pageContainer.height) >> 1;
        }

    }

    //getters/setters


}
}
