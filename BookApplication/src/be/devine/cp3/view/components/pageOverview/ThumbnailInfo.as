/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {

import be.devine.cp3.model.AppModel;

import starling.display.Quad;
import starling.display.Sprite;

public class ThumbnailInfo extends Sprite {

    private var appModel:AppModel;
    private var background:Quad;

    public function ThumbnailInfo()
    {
        this.appModel = AppModel.getInstance();
        background = new Quad(768,50,0xaaaaaa);
        addChild(background);
    }
}
}
