/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 1/12/12
 * Time: 11:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;

import flash.display.Sprite;

import starling.display.Sprite;


[SWF(backgroundColor="#333333")]
public class PageInfo extends starling.display.Sprite{

    private var appModel:AppModel;

    public function PageInfo() {

        this.appModel = AppModel.getInstance();

    }
}
}
