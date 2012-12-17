/**
 * Created by Nicholas Olivier on 14/12/12 at 17:24
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.factory.text
{
import flash.display.BitmapData;
import flash.display.Sprite;

import flashx.textLayout.container.ContainerController;
import flashx.textLayout.elements.ParagraphElement;
import flashx.textLayout.elements.SpanElement;
import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.TextLayoutFormat;

import starling.display.Image;

import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextFactory extends flash.display.Sprite
{
    var config:Object = {};

    [Embed(source='/assets/fonts/steelfishrg.otf', embedAsCFF='false', fontName='Steelfish')]
    public static var Steelfish:Class;

    [Embed(source='/assets/fonts/Edmondsans-Medium.otf', embedAsCFF='false', fontName='EdmondSansMedium')]
    public static var EdmondSansMedium:Class;

    [Embed(source='/assets/fonts/Georgia.ttf', embedAsCFF='false', fontName='Georgia')]
    public static var Georgia:Class;

    [Embed(source='/assets/fonts/Georgia Bold.ttf', embedAsCFF='false', fontName='GeorgiaBold')]
    public static var GeorgiaBold:Class;

    public function TextFactory()
    {
    }

    //Functions
    public static function addParagraph(text:String):flashx.textLayout.elements.TextFlow
    {
        var container:flash.display.Sprite = new flash.display.Sprite();
        container.width = 768;
        container.height = 600;

        //format parameters
        var format:TextLayoutFormat = new TextLayoutFormat();
        format.color = 0x000000;
        format.fontFamily = 'Georgia';
        format.fontSize = 12;

        //flow parameters
        var flow:TextFlow = new TextFlow();
        flow.columnCount = 2;
        flow.columnGap = 35;
        flow.hostFormat = format;

        //span parameters
        var spanElement:SpanElement= new SpanElement();
        spanElement.text = text;

        //paragraph parameters
        var paragraphElement:ParagraphElement= new ParagraphElement();
        paragraphElement.addChild(spanElement);
        paragraphElement.format = format;

        flow.addChild(paragraphElement);
        flow.flowComposer.addController(new ContainerController(container, 570, 340));
        flow.flowComposer.updateAllControllers();

        return flow;

    }

    public static function createTextField(config:Object):starling.display.Sprite {
        var textContainer:starling.display.Sprite = new starling.display.Sprite();
        var textField:TextField;
        var color:Number;
        switch (config.textLayout){
            case 'title':
                var text:String = config.text;
                    text = text.toUpperCase();
                textField = new TextField(698,200,text, "Steelfish", 70, 0x000000,false);
                break;
            case 'author':
                var text:String = 'Written by ' + config.text;
                textField = new TextField(698,50,text, "GeorgiaBold", 12, 0x000000,false);
                break;
            case 'linkTitle':
                color = config.color;
                var text:String = config.text;
                text = text.toUpperCase();
                textField = new TextField(698,30,config.text, "EdmondSansMedium", 17, color,false);
                break;
            case 'linkDescription':
                textField = new TextField(698,60,config.text, "Georgia", 14, 0x000000,false);
                break;
            case 'linkPage':
                color = config.color;
                textField = new TextField(698,30,config.text, "GeorgiaBold", 14, color,false);
                break;
            case 'pageInfo':
                textField = new TextField(698,35,config.text, "EdmondSansMedium", 13, 0x000000,false);
                break;
        }
            textField.hAlign = HAlign.LEFT;
            textField.vAlign = VAlign.TOP;
            textContainer.addChild(textField);

        return textContainer;
    }
}
}
