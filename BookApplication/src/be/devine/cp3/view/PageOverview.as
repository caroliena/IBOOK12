/**
 * Created by Nicholas Olivier on 25/11/12 at 10:54
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;

import flash.display.Sprite;

import starling.display.Sprite;


[SWF(backgroundColor="#666666")]
public class PageOverview extends starling.display.Sprite {

    //Constructor
    private var appModel:AppModel;

    public function PageOverview() {
        this.appModel = AppModel.getInstance();

    }

    //Functions

    //getters/setters

}
}
