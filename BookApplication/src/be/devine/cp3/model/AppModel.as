/**
 * Created by Nicholas Olivier on 25/11/12 at 10:48
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.model {
import be.devine.cp3.utils.Misc;

import flash.events.Event;
import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher {

    private static var instance:AppModel;

    private var _currentPage:Object;
    private var _pages:Array;
    private var _thumbnails:Array;
    private var _currentThumbnailIndex:int;
    private var _theme:String;
    public var themeColor:Number;

    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const CURRENT_THUMBNAIL_CHANGED:String = "currentThumbnailChanged";
    public static const THEMECOLOR_CHANGED:String = "themeColorChanged";

    public function AppModel(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("AppModel is a Singleton.");
        }
        _pages = [];
        _thumbnails = [];

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
        //currentPageIndex++;
        //Misc.getInstance().debug("@AppModel: currentPageIndex increased. // next()");


        var index:int = _pages.indexOf(_currentPage);
        if(index < _pages.length - 1)
        {
            index++;
            currentPage = _pages[index];
        }
    }

    public function previous():void
    {
        //currentPageIndex--;
        //Misc.getInstance().debug("@AppModel: currentPageIndex decreased. // previous()");


        var index:int = _pages.indexOf(_currentPage);
        if(index > 0)
        {
            index--;
            currentPage = _pages[index];

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
            theme = currentPage.theme;
            dispatchEvent(new flash.events.Event(CURRENT_PAGE_CHANGED, true));
        }
    }

    public function get pages():Array {
        return _pages;
    }

    public function set pages(value:Array):void {
        _pages = value;
    }

    public function get thumbnails():Array {
        return _thumbnails;
    }

    public function set thumbnails(value:Array):void {
        _thumbnails = value;
    }

    public function get currentThumbnailIndex():int {
        return _currentThumbnailIndex;
    }

    public function set currentThumbnailIndex(value:int):void {

        if(value != _currentThumbnailIndex)
        {
            _currentThumbnailIndex = value;
            dispatchEvent(new flash.events.Event(CURRENT_THUMBNAIL_CHANGED, true));
        }
    }

    public function get theme():String {
        return _theme;
    }

    public function set theme(value:String):void {

        if(value != theme)
        {
            _theme = value;
            switch(theme){
                case 'travel gadgets': themeColor=0x36a845; break;
                case 'hotels': themeColor=0x84bdc6; break;
                case 'inspiration': themeColor=0xfdf74a; break;
            }
            dispatchEvent(new flash.events.Event(THEMECOLOR_CHANGED, true));
        }
    }
}
}
internal class Enforcer{}