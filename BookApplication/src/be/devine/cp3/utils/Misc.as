/**
 * Created by Nicholas Olivier on 28/11/12 at 14:45
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.utils {
import be.devine.cp3.model.AppModel;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

public class Misc
{
    private var dateText:String = "";
    private static var instance:Misc;
    private var appModel:AppModel;

    public function Misc(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("Misc is a Singleton.");
        }
        this.appModel = AppModel.getInstance();
    }

    /**
     * getInstance method
     * @return <b>returns an instance of the Misc class.</b>
     */
    public static function getInstance():Misc
    {
        if(instance == null)
        {
            instance = new Misc(new Enforcer());
        }
        return instance;
    }

    /**
     * @param Page the page you need the id of
     * @return index of the page in the array
     */
    public function getIdForPage(page:*):int
    {
        var index:int = appModel.pageArray.indexOf(page);

        if(page == null) throw new Error("Object 'page' cannot be null.");
        if(index <= -1) throw new Error("Parameter 'page' is not a page!");

        return index;
    }

    public function setSize(image:DisplayObject, maxSize:Number = 50):void
    {
        var scaleWidth:Number = maxSize / image.width;
        var scaleHeight:Number = maxSize / image.height;

        if (scaleWidth < scaleHeight) image.scaleX = image.scaleY = scaleWidth;
        else image.scaleX = image.scaleY = scaleHeight;
    }
    /* logger */
    public function log(debugLevel:String, message:String):void
    {
        if (debugLevel == null)
            return;
        trace("["+debugLevel+"] // "+formatMessage(message));
    }

    private function formatMessage(message:String)
    {
        if (message == null) {
            message = "";
        }

        dateText = GetTime.getTime();

        message = message.replace("\t", "    ");
        return "[" + dateText + "] : " + message;
    }

        public function info(message:String):void
        {
            log("INFO", message);
        }

        public function debug(message:String):void
        {
            log("DEBUG", message);
        }

        public function warning(message:String):void
        {
            log("WARNING", message);
        }

        public function addArguments(method:Function, additionalArguments:Array):Function
        {
            return function(event:Event):void {method.apply(null, [event].concat(additionalArguments));}
        }

        public function removeChildrenOf(mc:DisplayObjectContainer):void
        {
            if(mc == null)
            throw new Error("Object to clear cannot be null.");

            while(mc.numChildren){
                mc.removeChildAt(0);
            }
        }
    }
}
internal class Enforcer{}