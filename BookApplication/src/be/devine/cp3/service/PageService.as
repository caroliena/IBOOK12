/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.service {
import be.devine.cp3.factory.vo.PageVOFactory;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.XmlTask;
import be.devine.cp3.utils.Misc;

import flash.events.Event;
import flash.events.EventDispatcher;

public class PageService extends EventDispatcher{

    private var appModel:AppModel;
    private var queue:Queue;
    public var pages:Array;

    public function PageService() {
        this.appModel = AppModel.getInstance();
    }

    public function load():void
    {
        var xmlUrl:String = "assets/xml/pages.xml";
        queue = new Queue();
        queue.add(new XmlTask(xmlUrl));
        queue.start();
        queue.addEventListener(Event.COMPLETE, xmlCompleteHandler);
    }

    private function xmlCompleteHandler(event:Event):void
    {
        var loadXML:XmlTask = queue.completedTasks[0];
        var pagesXML:XML = new XML(loadXML.data);

        for each(var page:XML in pagesXML.page)
        {
            appModel.pages.push( PageVOFactory.createPageVOFromXML(page) );
        }
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
