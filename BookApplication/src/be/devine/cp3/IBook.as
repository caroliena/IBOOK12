/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.service.PageService;
import be.devine.cp3.utils.Misc;
import be.devine.cp3.view.*;

import flash.events.Event;

import starling.core.Starling;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;

import starling.display.Sprite;


public class IBook extends starling.display.Sprite{

    //private var fontContainer:FontContainer = new FontContainer();

    //aanmaken views

    //aanmaken appModel
    private var appModel:AppModel;
    private var pageService:PageService;
    private var misc:Misc;

    //Constructor
    public function IBook()
    {
        appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.OVERVIEW_CHANGED, overviewChanged);
        appModel.addEventListener(AppModel.PAGEINFO_CHANGED, pageInfoChanged);

        misc = Misc.getInstance();

        pageService = new PageService();
        pageService.addEventListener(Event.COMPLETE, pagesCompleteHandler);
        pageService.load();

        /* van Nicholas: Starling stage aanspreken doe je zo ^^*/
        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

    }



    private function pageInfoChanged(event:Event):void {

        //zichtbaar zetten pageInfo
    }

    private function overviewChanged(event:Event):void {

        //zichtbaar zetten overview

    }

    private function keyDownHandler(event:starling.events.KeyboardEvent):void
    {
        var key:uint = event.keyCode;
        switch(key)
        {
            case Keyboard.LEFT: appModel.previous(); break;
            case Keyboard.RIGHT: appModel.next(); break;
        }
    }

    private function pagesCompleteHandler(evt:Event):void
    {
        appModel.currentPage = appModel.pages[ 0 ];
        display();
    }

    private function display():void
    {
        appModel.showPageInfo = appModel.currentPage.pageInfo;
        //pagina's moeten eerst ingeladen zijn voordat ze getoond kunnen worden
        var pageDetail:PageDetail = new PageDetail();
        var pageInfo:PageInfo = new PageInfo();
        var pageOverview:PageOverview = new PageOverview();

        addChild(pageDetail); //pagina zelf: titel, tekst, foto, links
        addChild(pageInfo); //paginanummer, thema,...
        addChild(pageOverview); //het overzicht met de thumbnails

        //TODO: best niet werken met .visible voor die pageInfo. removed ze gewoon vraagt normaal gezien minder geheugen.
        pageInfo.visible = appModel.showPageInfo;
        pageOverview.visible = appModel.showPageOverview;
    }
}
}
