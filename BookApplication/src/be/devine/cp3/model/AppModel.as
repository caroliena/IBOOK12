/**
 * Created by Nicholas Olivier on 25/11/12 at 10:48
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.model {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Point;

public class AppModel extends EventDispatcher {

    private static var instance:AppModel;

    private var _currentPage:Object;
    private var _pages:Array;
    private var _thumbnails:Array;
    private var _currentThumbnailIndex:int;
    private var _theme:String;
    private var _mouseCoords:Point;
    private var _overviewFlag:Boolean;
    private var _direction:String;
    private var _animating:Boolean;
    public var themeColor:Number;

    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const CURRENT_THUMBNAIL_CHANGED:String = "currentThumbnailChanged";
    public static const THEMECOLOR_CHANGED:String = "themeColorChanged";
    public static const MOUSE_POSITION_CHANGED:String = "mousePositionChanged";
    public static const OVERVIEW_CLICKED:String = "overviewClicked";

    public function AppModel(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("AppModel is a Singleton.");
        }
        _pages = [];
        _thumbnails = [];
        _overviewFlag = false;
        _direction = 'left';
        _animating = false;
        _mouseCoords = new Point();
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
        var index:int = _pages.indexOf(_currentPage);
        if(index < _pages.length - 1)
        {
            index++;
            direction = "left";
            currentPage = _pages[index];
        }
    }

    public function previous():void
    {
        var index:int = _pages.indexOf(_currentPage);
        if(index > 0)
        {
            index--;
            direction = "right";
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
        if(value != _currentPage && !animating)
        {
            _currentPage = value;
            theme = currentPage.theme;
            dispatchEvent(new Event(CURRENT_PAGE_CHANGED, true));
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
            dispatchEvent(new Event(CURRENT_THUMBNAIL_CHANGED, true));
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
                case 'adventure travel': themeColor=0x6ba53a; break;
                case 'budget travel': themeColor=0xe74c39; break;
                case 'road trips': themeColor=0x67c9bb; break;
                case 'world food': themeColor=0xfde300; break;
            }
            dispatchEvent(new Event(THEMECOLOR_CHANGED, true));
        }
    }


    public function get mouseCoords():Point {
        return _mouseCoords;
    }

    public function set mouseCoords(value:Point):void {
        if(value != mouseCoords)
        {
            _mouseCoords = value;
            dispatchEvent(new Event(MOUSE_POSITION_CHANGED, true));
        }
    }

    public function get overviewFlag():Boolean {
        return _overviewFlag;
    }

    public function set overviewFlag(value:Boolean):void {

        if(value != overviewFlag)
        {
            _overviewFlag = value;
            dispatchEvent(new Event(OVERVIEW_CLICKED, true));
        }
    }

    public function get direction():String {
        return _direction;
    }

    public function set direction(value:String):void {
        if(value != overviewFlag)
        {
            _direction = value;
        }
    }

    public function get animating():Boolean {
        return _animating;
    }

    public function set animating(value:Boolean):void {
        if(value != _animating)
        {
            _animating = value;
        }
    }
}
}
internal class Enforcer{}