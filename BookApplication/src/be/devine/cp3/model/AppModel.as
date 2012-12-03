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

    private var _currentPage:Object;
    private var _currentThumbnail:uint;             //misschien niet nodig
    private var _showPageInfo:Boolean;
    private var _showPageOverview:Boolean;
    private var _pages:Array;

    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const OVERVIEW_CHANGED:String = "overviewChanged";
    public static const PAGEINFO_CHANGED:String = "pageInfoChanged";

    public function AppModel(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("AppModel is a Singleton.");
        }
        _pages = [];
        showPageOverview = false;

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

    public function next():void
    {

        trace('next');

        var index:int = _pages.indexOf(_currentPage);
        if(index > -1)
        {
            index++;
            if(index < _pages.length) currentPage = _pages[index];
            else currentPage = _pages[0];
        }

    }

    public function previous():void
    {

        trace('previous');

        var index:int = _pages.indexOf(_currentPage);
        if(index > -1)
        {
            index--;
            if(index > -1) currentPage = _pages[index];
            else currentPage = _pages[_pages.length - 1];

        }
    }

    /**
     * GETTERS/SETTERS
     */

    public function get currentPage():Object {

        return _currentPage;

    }

    public function set currentPage(value:Object):void
    {

        if(value != _currentPage)
        {
            _currentPage = value;
            /*TODO: Applicatie loopt hier vast. Ik vermoed doordat de views geen dispatchEvents aanneemt flash.events */
            dispatchEvent(new flash.events.Event(CURRENT_PAGE_CHANGED, true));
        }

    }


    public function get pages():Array {
        return _pages;
    }

    public function set pages(value:Array):void {
        _pages = value;
    }

    public function get showPageInfo():Boolean {
        return _showPageInfo;
    }

    public function set showPageInfo(value:Boolean):void {
        _showPageInfo = value;
        dispatchEvent(new flash.events.Event(PAGEINFO_CHANGED, true));
    }

    public function get showPageOverview():Boolean {
        return _showPageOverview;
    }

    public function set showPageOverview(value:Boolean):void {
        _showPageOverview = value;
        dispatchEvent(new flash.events.Event(OVERVIEW_CHANGED, true));
    }

    public function get currentThumbnail():uint {
        return _currentThumbnail;
    }

    public function set currentThumbnail(value:uint):void {
        _currentThumbnail = value;
    }
}
}
internal class Enforcer{}