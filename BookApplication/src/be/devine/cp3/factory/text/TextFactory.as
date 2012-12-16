/**
 * Created by Nicholas Olivier on 14/12/12 at 17:24
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.factory.text
{
import be.devine.cp3.model.AppModel;

import flash.display.Sprite;

import flashx.textLayout.elements.ParagraphElement;

import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;

import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.TextLayoutFormat;

import starling.display.Sprite;

import starling.text.TextField;
import starling.utils.HAlign;

public class TextFactory
{
    var config:Object = {};

    [Embed(source='/assets/fonts/steelfishrg.otf', embedAsCFF='false', fontName='Steelfish')]
    public static var Steelfish:Class;

    [Embed(source='/assets/fonts/Edmondsans-Regular.otf', embedAsCFF='false', fontName='EdmondSansRegular')]
    public static var EdmondSansRegular:Class;

    [Embed(source='/assets/fonts/Georgia.ttf', embedAsCFF='false', fontName='Georgia')]
    public static var Georgia:Class;

    [Embed(source='/assets/fonts/Georgia Bold.ttf', embedAsCFF='false', fontName='GeorgiaBold')]
    public static var GeorgiaBold:Class;

    public function TextFactory()
    {

    }

    //Functions
    public static function addParagraph(config:Object):ParagraphElement
    {

        var format:TextLayoutFormat = new TextLayoutFormat();
        var flow:TextFlow = new TextFlow();
        var paragraphElement:ParagraphElement = new ParagraphElement();
        var span:SpanElement = new SpanElement();

        //format parameters
        format.color = 0x000000;
        format.fontFamily = 'Georgia';
        format.fontSize = 12;

        //flow parameters
        flow.columnCount = 2;
        flow.columnGap = 35;
        flow.hostFormat = format;

        //span parameters
        span.text = config.text;

        //paragraph parameters
        paragraphElement.addChild(span);
        paragraphElement.format = format;

        return paragraphElement;

    }

    public static function createTextField(config:Object):starling.display.Sprite {
        var textContainer:starling.display.Sprite = new starling.display.Sprite();
        var textField:TextField;
        switch (config.textLayout){
            case 'title':
                var text:String = config.text;
                    text = text.toUpperCase();
                textField = new TextField(698,200,text, "Steelfish", 70, 0x000000,false);
                break;
            case 'author':
                textField = new TextField(698,50,config.text, "Georgia", 12, 0x000000,false);
                break;
            case 'paragraph':
                textField = new TextField(698,650,config.text, "Georgia", 12, 0x000000,false);
                //textContainer.addChild(addParagraph(config));
                break;
            case 'linkTitle':
                var text:String = config.text;
                text = text.toUpperCase();
                textField = new TextField(698,650,config.text, "EdmondSansRegular", 17, 0x000000,false);
                break;
            case 'linkDescription':
                textField = new TextField(698,650,config.text, "Georgia", 14, 0x000000,false);
                break;
            case 'linkPage':
                textField = new TextField(698,650,config.text, "GeorgiaBold", 14, 0x000000,false);
                break;
        }
        textField.hAlign = HAlign.LEFT;
        textContainer.addChild(textField);
        return textContainer;
    }
}
}
