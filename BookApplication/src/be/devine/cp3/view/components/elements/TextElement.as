/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 16/12/12
 * Time: 12:03
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.elements {
import be.devine.cp3.factory.text.TextFactory;
import be.devine.cp3.vo.TextElementVO;

import flash.display.BitmapData;
import flash.display.ShaderParameter;
import flash.display.ShaderPrecision;
import flash.display.SpreadMethod;
import flash.display.Sprite;

import flashx.textLayout.container.ContainerController;

import flashx.textLayout.elements.ParagraphElement;

import flashx.textLayout.elements.SpanElement;

import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.TextLayoutFormat;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;

public class TextElement extends Element{
    private var type:uint;
    private var color:Number;
    private var textElementVO:TextElementVO;
    private var textField:starling.display.Sprite;

    public function TextElement(textElementVO:TextElementVO,type:uint,color:Number = 0x000000):void {
        super(textElementVO);

        this.textElementVO = textElementVO;
        this.type = type;
        this.color = color;

        if(textElementVO.textLayout != 'paragraph'){
            textField = TextFactory.createTextField({
                text:textElementVO.text,
                textLayout:textElementVO.textLayout,
                color: color
            });


        }else{
            textField = addParagraph(textElementVO.text);
        }
        textField.x = 35;
        addChild(textField);

        switch (type){

            case 2:
            case 3:
                if (textElementVO.textLayout == 'title') textField.y = 385;
                if (textElementVO.textLayout == 'author') textField.y = 470;
                if (textElementVO.textLayout == 'paragraph') textField.y = 540;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 60;
                if (textElementVO.textLayout == 'linkPage') textField.y = 115;
                break;
            case 4:
                textField.x = 60;
                textField.y = 250;
                textField.skewY = -0.25;
                break;
            case 5:
                if (textElementVO.textLayout == 'title') textField.y = 100;
                if (textElementVO.textLayout == 'author') textField.y = 190;
                if (textElementVO.textLayout == 'paragraph') textField.y = 300;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 60;
                if (textElementVO.textLayout == 'linkPage') textField.y = 115;
                break;
        }

    }

    //Functions
    private function addParagraph(text:String):starling.display.Sprite
    {
        var container:flash.display.Sprite=new flash.display.Sprite();

        var format:TextLayoutFormat = new TextLayoutFormat();
        format.color = 0x000000;
        format.fontFamily = "Georgia";
        format.fontSize = 14;
        format.paragraphSpaceBefore=0;
        format.paragraphSpaceAfter=20;

        var flow:TextFlow = new TextFlow();
        flow.columnCount=2;
        flow.columnGap=40;
        flow.hostFormat = format;

        var paragraaf:ParagraphElement = new ParagraphElement();
        var span:SpanElement = new SpanElement();
        span.text = textElementVO.text;
        paragraaf.addChild(span);
        paragraaf.format=format;
        flow.addChild(paragraaf);

        if(type == 2 || type == 3) flow.flowComposer.addController(new ContainerController(container, 698, 350));
        if(type == 5) flow.flowComposer.addController(new ContainerController(container, 698, 500));

        flow.flowComposer.updateAllControllers();

        var bmpData : BitmapData = new BitmapData(698,350, true, 0xFFFFFF);
        bmpData.draw(container);

        var texture:Texture = Texture.fromBitmapData(bmpData);
        var image:Image = new Image(texture);

        var textField:starling.display.Sprite = new starling.display.Sprite();
        textField.addChild(image);

        return textField;
    }
}
}
