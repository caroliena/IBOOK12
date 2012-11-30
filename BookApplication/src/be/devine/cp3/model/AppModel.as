/**
 * Created by Nicholas Olivier on 25/11/12 at 10:48
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.model {
import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher {

    private static var instance:AppModel;
    private var _currentPage:int;
    private var _xmlUrl:String;
    private var _pageArray:Array;
    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const XML_URL_CHANGED:String = "xmlUrlChanged";

    /**
     * AppModel
     * @param e <b>The enforcer we will be using so you can only make one instance of the AppModel.</b>
     */
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

    /**
     * getInstance method
     * @return <b>returns an instance of the AppModel class.</b>
     */
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

    public function loadXML():void
    {
        var url:String = "be/devine/cp3/assets/xml/pages.xml";
        this.xmlUrl = url;
        //trace("@AppModel: trace in loadXML method.");
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