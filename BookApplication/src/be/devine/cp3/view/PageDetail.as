/**
 * Created by Nicholas Olivier on 28/11/12 at 15:46
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.Font;

import flashx.textLayout.container.ContainerController;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.TextLayoutFormat;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

[SWF(backgroundColor="0xec9900")]

public class PageDetail extends Sprite{

    private var appModel:AppModel;

    private var pageContainer:Sprite;
    private var pageDetail:Sprite;
    private var previousButton:Button;
    private var nextButton:Button;

    [Embed(source='/assets/fonts/steelfishrg.otf', embedAsCFF='false', fontName='Steelfish')]
    public static var Steelfish:Class;

    [Embed(source='/assets/fonts/Edmondsans-Regular.otf', embedAsCFF='false', fontName='EdmondSansRegular')]
    public static var EdmondSansRegular:Class;

    [Embed(source='/assets/fonts/Georgia.ttf', embedAsCFF='false', fontName='Georgia')]
    public static var Georgia:Class;

    [Embed(source='/assets/fonts/Georgia Bold.ttf', embedAsCFF='false', fontName='GeorgiaBold')]
    public static var GeorgiaBold:Class;


    public function PageDetail()
    {
        this.appModel = AppModel.getInstance();

        pageContainer = new Sprite();

        var bmpData:BitmapData = new BitmapData(25, 1024, false, appModel.currentPage.themecolor);
        addChild(pageContainer);

        previousButton = new Button(Texture.fromBitmapData(bmpData,'<'));
        previousButton.alpha = 0;
        previousButton.x = 0;
        previousButton.addEventListener(starling.events.Event.TRIGGERED, previousClickHandler);
        pageContainer.addChild(previousButton);

        nextButton = new Button(Texture.fromBitmapData(bmpData,'>'));
        nextButton.alpha = 0;
        nextButton.x = Starling.current.stage.stageWidth - nextButton.width; //van Nicholas: non-hardcoded positioning added
        nextButton.addEventListener(starling.events.Event.TRIGGERED, nextClickHandler);
        pageContainer.addChild(nextButton);

        Starling.current.stage.addEventListener(TouchEvent.TOUCH, mouseMoveHandler);


       // var text:String = appModel.pages[appModel.currentPageIndex].image;

        if( appModel.currentPage.image != null ){

            trace('image niet null');
            var image:Loader = new Loader();
            image.load ( new URLRequest(appModel.currentPage.image));
            image.contentLoaderInfo.addEventListener ( Event.COMPLETE, display );


        }else{

            trace('image null');
            display();

        }

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
    }

    private function mouseMoveHandler(event:TouchEvent):void {


        var touch:Touch = event.getTouch(Starling.current.stage);
        if( touch != null ){

            if( touch.phase == "hover" ){

                if( touch.globalX <=200 ){

                    if( touch.globalX <= 25 ) previousButton.alpha = 1;
                    //TODO: Regel van drie toepassen
                    else previousButton.alpha = touch.globalX / 200 ;

                }else{
                    previousButton.alpha = 0;
                }
                if( touch.globalX >= Starling.current.stage.stageWidth - 200 ){


                    if( touch.globalX >= Starling.current.stage.stageWidth - 25 ) nextButton.alpha = 1;
                    //else nextButton.alpha = (touch.globalX) / (Starling.current.stage.stageWidth - 25);

                }else{
                    nextButton.alpha = 0;
                }


            }

        }

    }



    private function display(event:Event = null):void
    {


        if( pageContainer.contains(pageDetail)){

            trace('bevat een pagina');
            pageContainer.removeChild(pageDetail);

        }

        trace(pageContainer.numChildren);

        pageDetail = new Sprite();
        trace(pageDetail);

        if(appModel.currentPage.image != null){

            var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
            var texture:Texture = Texture.fromBitmap ( loadedBitmap );
            var image:Image = new Image(texture);

            pageDetail.addChild(image);

        }
        if(appModel.currentPage.title != null){

            var font:Font = new Steelfish();
            var titleField:TextField = new TextField(768,70,appModel.currentPage.title, font.fontName,58,0xFFFFFF,false);
            titleField.hAlign = HAlign.LEFT;
            titleField.vAlign = VAlign.TOP;
            pageDetail.addChild(titleField);

        }
        if(appModel.currentPage.paragraph != null){

            /*
            var bodyField:flash.text.TextField = new flash.text.TextField();
            bodyField.width = 698;
            bodyField.wordWrap = true;
            bodyField.multiline = true;
            bodyField.autoSize = TextFieldAutoSize.LEFT;
            bodyField.htmlText = appModel.currentPage.paragraph;
            bodyField.x = 35;
            Starling.current.nativeOverlay.addChild(bodyField);
            */

            //TODO Kleuren constant maken
            //TODO Buttons uit PageDetail halen
            //TODO Transities
            //TODO Pages opsplitsen in verschillende klasses

            var textFormatLayout:TextLayoutFormat = new TextLayoutFormat();
            textFormatLayout.color = 0x000000;
            textFormatLayout.fontFamily = "Arial";
            textFormatLayout.fontSize = 12;

            var flow:TextFlow = new TextFlow();
            flow.columnCount = 2;
            flow.columnGap = 35;
            flow.columnWidth = 300;
            flow.hostFormat = textFormatLayout;

            var paragraaf:ParagraphElement = new ParagraphElement();
            var span:SpanElement = new SpanElement();
            span.text = appModel.currentPage.paragraph;
            paragraaf.addChild(span);
            paragraaf.format=textFormatLayout;
            flow.addChild(paragraaf);

            var container:flash.display.Sprite=new flash.display.Sprite();
            container.x = 35;
            container.y = 400;
            Starling.current.nativeStage.addChild(container);

            flow.flowComposer.addController(new ContainerController(container, 698, 900));



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

        makeLayout();

        switch (type){

            case 1:{

                image.x = image.y = 0;

                break;
            }
            case 2:{

                image.x = image.y = 35;

                titleField.y = image.y + image.height + 35;
                titleField.x = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
                container.y = 500;

                break;
            }
            case 3:{

                titleField.color = 0x000000;

                image.x = image.y = 35;

                titleField.y = image.y + image.height + 35;
                titleField.x = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
                container.y = 500;

                break;
            }
            case 4:{

                image.x = image.y = 0;
                titleField.skewY = -0.25;
                titleField.x = 45;
                titleField.y = 200;
                titleField.fontSize = 80;
                titleField.height = 100;
                titleField.color = 0xFFFFFF;

                break;
            }
            case 5:{

                titleField.x = titleField.y = 35;
                titleField.color = 0x000000;

                authorField.y = titleField.y + titleField.height + 10;
                container.y = 500;
                break;
            }
            case 'default':{

                break;
            }

            trace(pageContainer.numChildren);


        }


    }

    private function makeLayout():void {

    }

    private function previousClickHandler(event:starling.events.Event):void {
        appModel.previous();
    }

    private function nextClickHandler(event:starling.events.Event):void {
          appModel.next();
    }

    private function currentPageChangedHandler(event:Event):void {

        if( appModel.currentPage.image != null ){

            var image:Loader = new Loader();
            image.load ( new URLRequest(appModel.currentPage.image));
            image.contentLoaderInfo.addEventListener ( Event.COMPLETE, display );

        }else{

            trace('image null');
            display();

        }

    }



}
}
