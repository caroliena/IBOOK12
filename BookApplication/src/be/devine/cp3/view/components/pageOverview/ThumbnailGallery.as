/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.pageOverview {
import be.devine.cp3.model.AppModel;

import starling.display.Quad;
import starling.display.Sprite;

public class ThumbnailGallery extends Sprite{

    private var appModel:AppModel;

    private var background:Quad;

    public function ThumbnailGallery()
    {
        this.appModel = AppModel.getInstance();
        background = new Quad(768,210,0xeeeeee);
        background.alpha = 0.8;
        addChild(background);
    }
}
}
