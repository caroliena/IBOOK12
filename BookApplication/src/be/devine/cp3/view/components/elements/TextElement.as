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

import starling.display.Sprite;

import starling.text.TextField;

public class TextElement extends Element{
    private var type:uint;
    private var textElementVO:TextElementVO;
    private var textField:Sprite;

    public function TextElement(textElementVO:TextElementVO,type:uint):void {
        super(textElementVO);
        this.textElementVO = textElementVO;
        this.type = type;

        textField = TextFactory.createTextField({
            text:textElementVO.text,
            textLayout:textElementVO.textLayout
        });

        switch (type){

            case 2:
            case 3:
                textField.x = 35;
                if (textElementVO.textLayout == 'title') textField.y = 325;
                if (textElementVO.textLayout == 'author') textField.y = 450;
                //if (textElementVO.textLayout == 'paragraph') textField.y = 300;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 30;
                if (textElementVO.textLayout == 'linkPage') textField.y = 30;
                break;
            case 4:
                textField.x = 60;
                textField.y = 250;
                textField.skewY = -0.25;
                break;
            case 5:
                textField.x = 35;
                if (textElementVO.textLayout == 'title') textField.y = 100;
                if (textElementVO.textLayout == 'author') textField.y = 250;
                //if (textElementVO.textLayout == 'paragraph') textField.y = 150;
                if (textElementVO.textLayout == 'linkTitle') textField.y = 30;
                if (textElementVO.textLayout == 'linkDescription') textField.y = 30;
                if (textElementVO.textLayout == 'linkPage') textField.y = 30;
                break;
        }
        addChild(textField);

    }
}
}
