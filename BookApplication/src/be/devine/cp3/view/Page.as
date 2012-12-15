/**
 * Created by Nicholas Olivier on 28/11/12 at 15:46
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.factory.text.TextFactory;
import be.devine.cp3.model.AppModel;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.Font;

import flashx.textLayout.container.ContainerController;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

[SWF(backgroundColor="0xec9900")]

public class Page extends Sprite{

    private var appModel:AppModel;

    private var pageContainer:Sprite;
    private var pageDetail:Sprite;
    private var paragraphContainer:TextFactory;

    [Embed(source='/assets/fonts/steelfishrg.otf', embedAsCFF='false', fontName='Steelfish')]
    public static var Steelfish:Class;

    [Embed(source='/assets/fonts/Edmondsans-Regular.otf', embedAsCFF='false', fontName='EdmondSansRegular')]
    public static var EdmondSansRegular:Class;

    [Embed(source='/assets/fonts/Georgia.ttf', embedAsCFF='false', fontName='Georgia')]
    public static var Georgia:Class;

    [Embed(source='/assets/fonts/Georgia Bold.ttf', embedAsCFF='false', fontName='GeorgiaBold')]
    public static var GeorgiaBold:Class;


    public function Page()
    {
        this.appModel = AppModel.getInstance();

        pageContainer = new Sprite();
        addChild(pageContainer);

        // var text:String = appModel.pages[appModel.currentPageIndex].image;

        if(appModel.currentPage.image != null)
        {
            trace('image niet null');
            var image:Loader = new Loader();
            image.load ( new URLRequest(appModel.currentPage.image));
            image.contentLoaderInfo.addEventListener ( Event.COMPLETE, display );
        } else {
            trace('image null');
            display();
        }

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
    }


    private function display(event:Event = null):void
    {
        trace(pageContainer.contains(pageDetail)+" : contains?");
        /*while(pageContainer.numChildren > 0)
        {
            pageContainer.removeChildAt(0);
        }
        */

        if( pageContainer.contains(pageDetail))
            pageContainer.removeChild(pageDetail);

        pageDetail = new Sprite();
        //TODO: Verschillende items opslitsen in verschillende klasses
        if(appModel.currentPage.image != null)
        {
            var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
            var texture:Texture = Texture.fromBitmap ( loadedBitmap );
            var image:Image = new Image(texture);
            pageDetail.addChild(image);
        }

        if(appModel.currentPage.title != null)
        {
            var font:Font = new Steelfish();
            var titleField:TextField = new TextField(768,70,appModel.currentPage.title, font.fontName,58,0xFFFFFF,false);
            titleField.hAlign = HAlign.LEFT;
            titleField.vAlign = VAlign.TOP;
            pageDetail.addChild(titleField);
        }

        if(appModel.currentPage.paragraph != null)
        {

                if(paragraphContainer == null)
                {
                    paragraphContainer = new TextFactory();
                    paragraphContainer.x = 35;
                    paragraphContainer.y = 500;
                    Starling.current.nativeStage.addChild(paragraphContainer);
                    paragraphContainer.addParagraph();
                    paragraphContainer.flow.addChild(paragraphContainer.paragraphElement);

                }
                paragraphContainer.span.text = appModel.currentPage.paragraph;
                paragraphContainer.flow.flowComposer.addController(new ContainerController(paragraphContainer, 570, 340));
                paragraphContainer.flow.flowComposer.updateAllControllers();

        }
        if(appModel.currentPage.linktitle != null){


        }
        if(appModel.currentPage.author != null){

            var font2:Font = new Georgia();

            var authorText:String = "Geschreven door " + appModel.currentPage.author;
            var authorField:TextField = new TextField(768,30,authorText, font2.fontName,12,0x000000,false);
            authorField.hAlign = HAlign.LEFT;
            authorField.x = 35;
            pageDetail.addChild(authorField);

        }


        var type:uint = appModel.currentPage.type;
        pageContainer.addChildAt(pageDetail,0);

        switch (type)
        {
            case 1: image.x = image.y = 0; break;

            case 2:

                image.x = image.y = 35;

                titleField.y = image.y + image.height + 35;
                titleField.x = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
            break;

            case 3:

                titleField.color = 0x000000;

                image.x = image.y = 35;

                titleField.y = image.y + image.height + 35;
                titleField.x = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
                //container.y = 500;

            break;

            case 4:
                image.x = image.y = 0;
                titleField.skewY = -0.25;
                titleField.x = 45;
                titleField.y = 200;
                titleField.fontSize = 80;
                titleField.height = 100;
                titleField.color = 0xFFFFFF;

                break;

            case 5:
                titleField.x = titleField.y = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
                //container.y = 500;
                break;

            case 'default': break;
        }
    }

    private function currentPageChangedHandler(event:Event):void
    {
        if( appModel.currentPage.image != null )
        {
            var image:Loader = new Loader();
            image.load ( new URLRequest(appModel.currentPage.image));
            image.contentLoaderInfo.addEventListener ( Event.COMPLETE, display );
        } else {
            trace('image null');
            display();
        }
    }
}
}
