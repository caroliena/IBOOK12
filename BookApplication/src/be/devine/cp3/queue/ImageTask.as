/**
 * Created with IntelliJ IDEA.
 * User: nicholasolivier
 * Date: 28/09/12
 * Time: 09:19
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue
{
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

public class ImageTask extends Loader implements ITask
{
    public var imageUrl:String;

    /**
     * Save the url of an image in the ImageTask object.
     * @param imageUrl an url to an image (String-value).
     */
    public function ImageTask(imageUrl:String)
    {
        this.imageUrl = imageUrl;
    }

    public function start():void
    {
        this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        this.load(new URLRequest(imageUrl));
    }

    private function errorHandler(e:IOErrorEvent):void
    {
        this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,true,false, e.text));
    }


    private function completeHandler(e:Event):void
    {
        this.dispatchEvent(new Event(Event.COMPLETE,true));
    }
}
}
