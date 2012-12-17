/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 15/12/12
 * Time: 16:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.factory.vo {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.vo.ElementVO;
import be.devine.cp3.vo.ImageElementVO;
import be.devine.cp3.vo.LinkElementVO;
import be.devine.cp3.vo.TextElementVO;

public class ElementVOFactory {

    public static function createFromXML(elementXML:XML):ElementVO
    {
        switch("" + elementXML.@type)
        {
            case "image": return createImageElementVO(elementXML);
            case "text": return createTextElementVO(elementXML);
            case "link": return createLinkElementVO(elementXML);
        }
        return null;
    }

    public static function createImageElementVO(elementXML:XML):ImageElementVO
    {
        var imageElementVO:ImageElementVO = new ImageElementVO();
        imageElementVO.type = "image";
        imageElementVO.url = "assets/images/" + elementXML.text();

        return imageElementVO;
    }

    public static function createTextElementVO(elementXML:XML):TextElementVO
    {
        var textElementVO:TextElementVO = new TextElementVO();
        textElementVO.type = "text";
        textElementVO.text = elementXML.text();
        textElementVO.textLayout = elementXML.@textLayout;

        return textElementVO;
    }

    public static function createLinkElementVO(elementXML:XML):LinkElementVO
    {
        var linkElementVO:LinkElementVO = new LinkElementVO();
        linkElementVO.type = "link";

        for each(var linkElementXML:XML in elementXML.element){
            linkElementVO.linkElements.push(createTextElementVO(linkElementXML));
        }
        return linkElementVO;
    }
}
}
