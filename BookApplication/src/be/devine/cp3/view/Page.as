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

public class Page extends Sprite{

    private var appModel:AppModel;
    private var misc:Misc;
    private var details:Object;
    /* static const */
    public static const SHOW_PAGE:String = "showPage";

    public function Page()
    {
        this.appModel = AppModel.getInstance();
        this.misc = Misc.getInstance();

        this.graphics.clear();
        this.graphics.beginFill(0x2C2CC2);
        this.graphics.drawRect(0,0,Main.w,Main.h);
        this.graphics.endFill();
    }

    public function setPage(details:Object):void
    {
        if(details == null)
            throw new Error("details cannot be null.");

        this.details = details;
        trace(this.details);
        showPage();
    }

    private function showPage():void
    {
        misc.debug(getPageNumber()+" // "+details.title+" // "+details.paragraph+" // "+details.image);

        if(details.image != undefined)
        {
            if(details.image instanceof DisplayObject)
            {
                addChild(details.image);
            }
        }

        dispatchEvent(new Event(SHOW_PAGE, true));
    }

    private function getPageNumber():String
    {
        return "Page "+(appModel.currentPage + 1)+" / "+appModel.pageArray.length;
    }
}
}
