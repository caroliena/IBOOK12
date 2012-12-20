/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 15/12/12
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.buttons {
import be.devine.cp3.model.AppModel;

import flash.display.BitmapData;
import flash.events.Event;

import starling.display.Button;
import starling.display.Quad;
import starling.textures.Texture;

public class Button extends starling.display.Button{

    private var appModel:AppModel;
    private var background:Quad;

    public function Button(upState:Texture, text:String="", downState:Texture=null) {

        this.appModel = AppModel.getInstance();

        var bmpData:BitmapData = new BitmapData(25, 1024, false, 0xFFFFFF);
        var texture:Texture = Texture.fromBitmapData(bmpData);
        upState = texture;

        super(upState, text, downState);

        background = new Quad(25,1024,appModel.themeColor);
        addChild(background);

        appModel.addEventListener(AppModel.THEMECOLOR_CHANGED, themeColorChangedHandler);

    }

    private function themeColorChangedHandler(event:Event):void {
        background.color = appModel.themeColor;
    }



}
}
