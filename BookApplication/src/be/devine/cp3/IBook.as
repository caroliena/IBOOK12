/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.service.PageService;
import be.devine.cp3.view.*;

import flash.events.Event;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;

import starling.display.Sprite;


public class IBook extends starling.display.Sprite{

    private var fontContainer:FontContainer = new FontContainer();

    //aanmaken views
    private var pageInfo:PageInfo;
    private var pageDetail:PageDetail;
    private var pageOverview:PageOverview;

    //aanmaken appModel
    private var appModel:AppModel;
    private var pageService:PageService;

    //Constructor
    public function IBook()
    {
        appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.OVERVIEW_CHANGED, overviewChanged);
        appModel.addEventListener(AppModel.PAGEINFO_CHANGED, pageInfoChanged);

        pageService = new PageService();
        pageService.addEventListener(Event.COMPLETE, pagesCompleteHandler);
        pageService.load();

        /* TODO: luistert nog niet naar keyboard event*/
        this.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);




        }

    private function pageInfoChanged(event:Event):void {

        //zichtbaar zetten pageInfo
    }

    private function overviewChanged(event:Event):void {

        //zichtbaar zetten overview

    }

    private function keyDownHandler(event:starling.events.KeyboardEvent):void {

        trace('hi');
        var key:uint = event.keyCode;
        switch(key)
        {
            case Keyboard.LEFT: appModel.previous();
                break;

            case Keyboard.RIGHT: appModel.next();
                break;
        }

    }

    private function pagesCompleteHandler(evt:Event):void{

        appModel.pages = pageService.pages;
        appModel.currentPage = appModel.pages[0];
        appModel.showPageInfo = appModel.pages[0].pageInfo;


        //pagina's moeten eerst ingeladen zijn voordat ze getoond kunnen worden

        //pagina zelf: titel, tekst, foto, links
        pageDetail = new PageDetail();
        addChild(pageDetail);

        //paginanummer, thema,...
        pageInfo = new PageInfo();
        addChild(pageInfo);

        //het overzicht met de thumbnails
        pageOverview = new PageOverview();
        addChild(pageOverview);

        pageInfo.visible = appModel.showPageInfo;
        pageOverview.visible = appModel.showPageOverview;

    }

    //getters/setters


}
}
