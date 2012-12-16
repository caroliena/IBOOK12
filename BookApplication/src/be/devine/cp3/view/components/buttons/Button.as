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

        //TODO Afstemmen op themecolor
        background = new Quad(25,1024,0x000000);
        addChild(background);

    }



}
}
