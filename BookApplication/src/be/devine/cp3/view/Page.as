/**
 * Created by Nicholas Olivier on 28/11/12 at 15:46
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.factory.text.TextFactory;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.elements.Element;
import be.devine.cp3.view.components.elements.ImageElement;
import be.devine.cp3.view.components.elements.LinkElement;
import be.devine.cp3.view.components.elements.TextElement;
import be.devine.cp3.vo.ElementVO;
import be.devine.cp3.vo.ImageElementVO;
import be.devine.cp3.vo.LinkElementVO;
import be.devine.cp3.vo.TextElementVO;

import flash.events.Event;

import flash.events.Event;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;

import starling.display.DisplayObject;

import starling.display.Sprite;
import starling.events.Event;

public class Page extends Sprite{

    private var appModel:AppModel;
    private var element:Element;
    private var pagesArray:Array = new Array();

    public function Page()
    {
        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
        appModel.addEventListener(AppModel.OVERVIEW_CLICKED, overviewClickedHandler);

        display();
    }

    private function createText(textElementVO:TextElementVO):Element {
        var textElement:TextElement = new TextElement(textElementVO,appModel.currentPage.type);
        return textElement;
    }

    private function createImage(imageElementVO:ImageElementVO):Element {
        var imageElement:ImageElement = new ImageElement(imageElementVO,appModel.currentPage.type);
        return imageElement;
    }

    private function createLink(linkElementVO:LinkElementVO):Element {
        var linkElement:LinkElement = new LinkElement(linkElementVO,appModel.currentPage.type);
        return linkElement;
    }

    private function overviewClickedHandler(event:flash.events.Event=null):void {
        //TODO UseHandCursor werkt ni
        if(appModel.overviewFlag){
            element.useHandCursor = false;
            element.removeEventListener(starling.events.Event.TRIGGERED, clickHandler);
        }else{
            element.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
            element.useHandCursor = true;
        }
    }

    private function clickHandler(event:starling.events.Event):void {
        var linkElement:LinkElement = event.currentTarget as LinkElement;
        var pageNumber:uint = (linkElement.pageNumber - 1);
        appModel.currentPage = appModel.currentThumbnailIndex = appModel.pages[pageNumber];
    }

    private function currentPageChangedHandler(event:flash.events.Event):void
    {
        display();
    }

    private function display():void {

        var pageContainer:Sprite = new Sprite();
        pageContainer.x = appModel.direction == 'left' ? 768:-768;
        addChild(pageContainer);

        pagesArray.push(pageContainer);

        for each(var elementVO:ElementVO in appModel.currentPage.elements) {
            switch(elementVO.type){
                case 'link':
                    element = createLink(elementVO as LinkElementVO);
                    overviewClickedHandler();
                    break;
                case 'text':
                    element = createText(elementVO as TextElementVO);
                    break;
                case 'image':
                    element = createImage(elementVO as ImageElementVO);
                    break;
            }
            pageContainer.addChildAt(element,0);
        }

        for(var i:uint = pagesArray.length; i > 0; i--){
            appModel.animating = true;
            var transitionPage:Tween = new Tween(pagesArray[i-1],1.0,Transitions.EASE_IN_OUT);
            transitionPage.animate("x", (appModel.direction == 'left' ? pagesArray[i-1].x - 768 : pagesArray[i-1].x + 768));
            transitionPage.onComplete = function():void{
                if( (i) == 0 && pagesArray.length >= 2 ){
                    removeChildAt(0);
                    pagesArray.shift();
                }
                appModel.animating = false;
            }
            Starling.juggler.add(transitionPage);

        }

    }


}
}
