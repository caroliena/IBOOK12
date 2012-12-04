/**
 * Created by Nicholas Olivier on 25/11/12 at 10:48
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.model {
import be.devine.cp3.queue.Queue;
import be.devine.cp3.queue.XmlTask;
import be.devine.cp3.utils.Misc;
import be.devine.cp3.view.PageDetail;
import be.devine.cp3.vo.PageVO;

import flash.display.Sprite;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class AppModel extends EventDispatcher {

    private static var instance:AppModel;

    private var queue:Queue;
    private var misc:Misc;

    private var _currentPage:int;
    private var _xmlUrl:String;
    private var _pageArray:Array;

    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const XML_URL_CHANGED:String = "xmlUrlChanged";

    public function AppModel(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("AppModel is a Singleton.");
        }
        _xmlUrl = "";
        _currentPage = -1;
        _pageArray = [];

    }

    public static function getInstance():AppModel
    {
        if(instance == null)
        {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    /**
     * METHODS
     */

    public function goToNextPage():void
    {
        currentPage++;
    }

    public function goToPrevPage():void
    {
        currentPage--;
    }

    //inladen van de XML
    public function loadXML():void
    {
        var xmlUrl:String = "assets/xml/pages.xml";

        trace(xmlUrl);
        queue = new Queue();
        queue.add(new XmlTask(xmlUrl));
        queue.start();
        //queue.addEventListener(ProgressEvent.PROGRESS, progressHandler);
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
        var pagesXML:XML = new XML(loadXML.data);
        var pages:Array = [];

        for each(var page:Object in pagesXML.page)
        {
            trace(page.title);

            var pageVO:PageVO = new PageVO();
            pageVO.thumb = "assets/thumbs/" + page.thumb;
            pageVO.title = page.title;
            pageVO.author = page.author;
            pageVO.image = "assets/images/" + page.image;
            pageVO.paragraph = page.paragraph;
            pageVO.linktitle  =  page.link.linktitle;
            pageVO.description = page.link.description;
            pageVO.pageId = page.link.pageid;
            pageVO.theme = page.theme;
            pageVO.pageInfo = page.pageinfo;

            pages.push(pageVO);

        }
        //this.pages = pages;
        //this.currentPage = pages[0];
    }






    /**
     * GETTERS/SETTERS
     */

    public function get currentPage():int {
        return _currentPage;
    }

    public function set currentPage(value:int):void
    {
        value = Math.min(pageArray.length -1, Math.max(0, value));

        if(value != _currentPage)
        {
            _currentPage = value;
            dispatchEvent(new Event(CURRENT_PAGE_CHANGED, true));
        }
    }

    public function get xmlUrl():String {
        return _xmlUrl;
    }

    public function set xmlUrl(value:String):void
    {
        if(value != _xmlUrl)
        {
            _xmlUrl = value;
            trace("@AppModel: trace in xmlUrl setter.");
            dispatchEvent(new Event(XML_URL_CHANGED, true));
        }

    }

    public function get pageArray():Array {
        return _pageArray;
    }

    public function set pageArray(value:Array):void {
        _pageArray = value;
    }
}
}
internal class Enforcer{}