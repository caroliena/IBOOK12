/**
 * Created by Nicholas Olivier on 25/11/12 at 10:59
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.*;

import flash.display.Sprite;

public class IBook extends Sprite{

    private var fontContainer:FontContainer = new FontContainer();

    //aanmaken views
    private var pageInfo:PageInfo;
    private var pageDetail:PageDetail;
    private var pageOverview:PageOverview;

    //aanmaken appModel
    private var appModel:AppModel;

    //Constructor
    public function IBook()
    {
        appModel = AppModel.getInstance();

        appModel = AppModel.getInstance();
        appModel.loadXML();                                    //inladen vanuit de pagina's vanuit de XML

        //paginanummer, thema,...
        pageInfo = new PageInfo();
        addChild(pageInfo);

        //pagina zelf: titel, tekst, foto, links
        pageDetail = new PageDetail();
        addChild(pageDetail);

        //het overzicht met de thumbnails
        pageOverview = new PageOverview();
        addChild(pageOverview);

        }

    //getters/setters


}
}
