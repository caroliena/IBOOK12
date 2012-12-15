/**
 * Created by Nicholas Olivier on 25/11/12 at 10:54
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.pageOverview.ThumbnailGallery;
import be.devine.cp3.view.components.pageOverview.ThumbnailInfo;
import flash.events.Event;

import starling.display.Sprite;

public class PageOverview extends starling.display.Sprite {

    //Constructor
    private var appModel:AppModel;
    private var pageOverviewContainer:starling.display.Sprite;
    private var thumbnailGallery:ThumbnailGallery;
    private var thumbnailInfo:ThumbnailInfo;

    public function PageOverview()
    {
        this.appModel = AppModel.getInstance();

        pageOverviewContainer = new Sprite();
        thumbnailGallery = new ThumbnailGallery();
        thumbnailInfo = new ThumbnailInfo();
        thumbnailInfo.y = 200;

        addChild(pageOverviewContainer);
        pageOverviewContainer.addChild(thumbnailGallery);
        pageOverviewContainer.addChild(thumbnailInfo);

        appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
    }

    private function currentPageChangedHandler(event:flash.events.Event):void {

        trace("ook aanpassen");

    }

    //Functions

    //getters/setters

}
}
