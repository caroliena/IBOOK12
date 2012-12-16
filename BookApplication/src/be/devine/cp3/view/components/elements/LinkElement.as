/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 16/12/12
 * Time: 12:04
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.elements {
import be.devine.cp3.vo.LinkElementVO;
import be.devine.cp3.vo.TextElementVO;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Button;
import starling.textures.Texture;

public class LinkElement extends Element{
    private var type:uint;
    private var linkElementVO:LinkElementVO;
    private var link:Button;
    public var pageNumber:uint = 1;

    public function LinkElement(linkElementVO:LinkElementVO,type:uint) {
        super(linkElementVO);
        this.linkElementVO = linkElementVO;
        this.type = type;

        var loader:Loader = new Loader();
        loader.load(new URLRequest("assets/ui/link.png"));
        loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, loaderCompleteHandler );
    }

    private function loaderCompleteHandler(event:Event):void {

        var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture:Texture = Texture.fromBitmap(loadedBitmap);

        link = new Button(texture);
        link.x = 410;
        link.y = 750;
        addChild(link);

        for each(var textElementVO:TextElementVO in linkElementVO.linkElements) {
            var textElement:TextElement = new TextElement(textElementVO,type);
            if(textElementVO.textLayout == "linkPage") pageNumber = uint(textElementVO.text);
            link.addChild(textElement);
        }
    }


}
}
