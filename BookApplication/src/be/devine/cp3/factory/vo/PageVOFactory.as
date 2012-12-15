/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 3/12/12
 * Time: 14:30
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.factory.vo {
import be.devine.cp3.vo.PageVO;

public class PageVOFactory {

    public static function createPageVOFromXML(pageXML:XML):PageVO
    {

        /* TODO: Opsplitsing van verschillende VO's moet nog gemaakt worden */
        /* Voorstel: Gaan we dit doen? */

        var pageVO:PageVO = new PageVO();

        //Thumbs en pageinfo zijn altijd aanwezig
        //Types = om de verschillende opmaak te kunnen voorzien in de views

        pageVO.thumb = "assets/thumbs/" + pageXML.@thumb;
        pageVO.pageInfo = pageXML.@pageinfo;
        pageVO.type = pageXML.@type;
        pageVO.theme = pageXML.theme;
        pageVO.themecolor = pageXML.theme.@kleur;

        //Deze zaken zijn optioneel
        if(pageXML.title != undefined) pageVO.title = pageXML.title;
        if(pageXML.author != undefined) pageVO.author = pageXML.author;
        if(pageXML.paragraph != undefined) pageVO.paragraph = pageXML.paragraph;
        if(pageXML.image != undefined) pageVO.image = "assets/images/" + pageXML.image;
        if(pageXML.link.linktitle != undefined) pageVO.linktitle = pageXML.link.linktitle;
        if(pageXML.link.description != undefined) pageVO.description = pageXML.link.description;
        if(pageXML.link.pageid != undefined) pageVO.pageId = pageXML.link.pageid;

        return pageVO;
    }

}
}
