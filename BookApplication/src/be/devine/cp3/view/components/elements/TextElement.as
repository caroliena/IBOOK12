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

import flashx.textLayout.elements.TextFlow;

import starling.display.Sprite;

public class TextElement extends Element{
    private var type:uint;
    private var color:Number;
    private var textElementVO:TextElementVO;
    private var textField:Sprite;

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
            textField.x = 35;
            addChild(textField);
        }else{
            //TODO Paragraaf wordt nog niet weergegeven
            //Eventueel opsplitsen in twee xml-elementen
            //Moet dmv bitmapdata aan sprite gekoppeld worden
            //http://forums.adobe.com/message/3338933?tstart=0#3338933
            //http://www.flashandmath.com/flashcs5/textcols/index.html
            var paragraaf:TextFlow = TextFactory.addParagraph(textElementVO.text);

            var bmpData:BitmapData = new BitmapData(698,600,true,0xFFFFFF);
            //bmpData.draw(paragraaf);
            //trace(paragraaf);
            //Starling.current.nativeStage.addChild(paragraaf);
        }


        switch (type){

            case 2:
            case 3:
                if (textElementVO.textLayout == 'title') textField.y = 385;
                if (textElementVO.textLayout == 'author') textField.y = 470;
                //if (textElementVO.textLayout == 'paragraph') paragraaf.y = 300;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 70;
                if (textElementVO.textLayout == 'linkPage') textField.y = 90;
                break;
            case 4:
                textField.x = 60;
                textField.y = 250;
                textField.skewY = -0.25;
                break;
            case 5:
                if (textElementVO.textLayout == 'title') textField.y = 100;
                if (textElementVO.textLayout == 'author') textField.y = 250;
                //if (textElementVO.textLayout == 'paragraph') paragraaf.y = 150;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 50;
                if (textElementVO.textLayout == 'linkPage') textField.y = 70;
                break;
        }

    }
}
}
