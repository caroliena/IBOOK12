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
import flashx.textLayout.elements.SpanElement;

import flashx.textLayout.elements.TextFlow;
import flashx.textLayout.formats.TextLayoutFormat;

public class TextFactory extends flash.display.Sprite
{
    private var appModel:AppModel;
    private var format:TextLayoutFormat;
    public var flow:TextFlow;
    public var paragraphElement:ParagraphElement;
    public var span:SpanElement;

    public function TextFactory()
    {
        appModel = AppModel.getInstance();
        format = new TextLayoutFormat();
        flow = new TextFlow();
        paragraphElement = new ParagraphElement();
        span = new SpanElement();
    }

    //Functions
    public function addParagraph(color:Number = 0x660000, fontFamily:String = "Arial, Helvetica, _sans", fontSize:Number = 14):void
    {
        //format parameters
        format.color = color;
        format.fontFamily = fontFamily;
        format.fontSize = fontSize;

        //flow parameters
        flow.columnCount = 2;
        flow.columnGap = 35;
        flow.hostFormat = this.format;

        //span parameters
        span.text = appModel.currentPage.paragraph;

        //paragraph parameters
        paragraphElement.addChild(span);
        paragraphElement.format = format;

    }
    //getters/setters

}
}
