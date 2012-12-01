/**
 * Created by Nicholas Olivier on 28/11/12 at 15:46
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.queue.ImageTask;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.utils.Misc;

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class PageDetail extends Sprite{

    private var appModel:AppModel;
    private var misc:Misc;
    private var details:Object;
    private var queue:Queue;
    /* dimensions */
    private var w:Number = 420;
    private var h:Number = 594;
    /* static const */
    public static const SHOW_PAGE:String = "showPage";

    public function PageDetail()
    {
        this.appModel = AppModel.getInstance();
        this.misc = Misc.getInstance();

        this.graphics.clear();
        this.graphics.beginFill(0x2C2CC2);
        this.graphics.drawRect(0,0,w,h);
        this.graphics.endFill();
    }

    public function setPage(details:Object):void
    {
        //check if details is null, if so throw an error.
        if(details == null)
            throw new Error("details cannot be null.");

        this.details = details;
        this.queue = new Queue();


        if(details.image != undefined) loadImage(details.image);
        else showPage();

    }

    private function loadImage(image:String):void
    {
        //queue.add( new ImageTask(image) );
        //queue.addEventListener(Event.COMPLETE, imageLoadedHandler);
        //queue.start();
    }

    private function imageLoadedHandler(event:Event):void
    {
        showPage();
        for each(var img:DisplayObject in queue.completedTasks)
        {
            misc.setSize(img, w / (queue.completedTasks.length + 1));
            addChild(img);
        }
    }

    private function showPage():void
    {
        misc.debug(getPageNumber()+" // "+details.title+" // "+details.paragraph+" // "+details.image);

        dispatchEvent(new Event(SHOW_PAGE, true));
    }

    private function getPageNumber():String
    {
        return "Page "+(appModel.currentPage + 1)+" / "+appModel.pageArray.length;
    }
}
}
