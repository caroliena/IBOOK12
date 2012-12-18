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

import starling.display.DisplayObject;

import starling.display.Sprite;
import starling.events.Event;

public class Page extends Sprite{

    private var appModel:AppModel;

    public function Page()
    {
        this.appModel = AppModel.getInstance();
        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);

        display();
    }

    private function display(event:flash.events.Event = null):void
    {
        while(numChildren > 0)
        {
            removeChildAt(0);
        }

        for each(var elementVO:ElementVO in appModel.currentPage.elements) {
            var element:Element;
            switch(elementVO.type){
                case 'link':
                    element = createLink(elementVO as LinkElementVO);
                    element.addEventListener(starling.events.Event.TRIGGERED, clickHandler);
                    break;
                case 'text':
                    element = createText(elementVO as TextElementVO);
                    break;
                case 'image':
                    element = createImage(elementVO as ImageElementVO);
                    break;
            }
            addChildAt(element,0);
        }
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

    private function clickHandler(event:starling.events.Event):void {
        //TODO Linkelement is nog klikbaar als thumbnailGallery openstaat
        var linkElement:LinkElement = event.currentTarget as LinkElement;
        var pageNumber:uint = (linkElement.pageNumber - 1);
        appModel.currentPage = appModel.currentThumbnailIndex = appModel.pages[pageNumber];
    }

    private function currentPageChangedHandler(event:flash.events.Event):void
    {
        display();
    }
}
}
