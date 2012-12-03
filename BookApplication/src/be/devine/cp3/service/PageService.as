/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.service {
import be.devine.cp3.factory.vo.PageVOFactory;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.XmlTask;
import be.devine.cp3.utils.Misc;

import flash.events.Event;
import flash.events.EventDispatcher;

public class PageService extends EventDispatcher{


    public function PageService() {
    }

    private var queue:Queue;
    public var pages:Array;

    private var misc:Misc;

    //inladen van de XML
    public function load():void
    {
        var xmlUrl:String = "assets/xml/pages.xml";

        trace(xmlUrl);
        queue = new Queue();
        queue.add(new XmlTask(xmlUrl));
        queue.start();
        queue.addEventListener(Event.COMPLETE, xmlCompleteHandler);

    }

    private function xmlCompleteHandler(event:Event):void
    {

        var loadXML:XmlTask = queue.completedTasks[0];
        var pagesXML:XML = new XML(loadXML.data);

        var pages:Array = [];

        for each(var page:XML in pagesXML.page)
        {

            pages.push(PageVOFactory.createPageVOFromXML(page));

        }
        this.pages = pages;
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
