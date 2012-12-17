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
        var pageVO:PageVO = new PageVO();
        pageVO.type = pageXML.@type;
        pageVO.theme = pageXML.@theme;
        pageVO.thumbnail = "assets/thumbs/" + pageXML.@thumb;

        for each(var elementXML:XML in pageXML.element){
            pageVO.elements.push(ElementVOFactory.createFromXML(elementXML));
            if(elementXML.@type == 'text' && elementXML.@textLayout == 'title'){
                pageVO.title = elementXML.text();
            }
        }

        return pageVO;
    }

}
}
