/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 16/12/12
 * Time: 12:04
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.elements {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.vo.LinkElementVO;
import be.devine.cp3.vo.TextElementVO;

import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Button;
import starling.display.Quad;
import starling.textures.Texture;

public class LinkElement extends Element{
    private var appModel:AppModel;
    private var type:uint;
    private var themeColor:Number;
    private var linkElementVO:LinkElementVO;
    private var link:Button;
    public var pageNumber:uint = 1;

    public function LinkElement(linkElementVO:LinkElementVO,type:uint) {

        appModel = AppModel.getInstance();

        super(linkElementVO);
        this.linkElementVO = linkElementVO;
        this.type = type;

        themeColor = appModel.themeColor;

        var loader:Loader = new Loader();
        loader.load(new URLRequest("assets/ui/link.png"));
        loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, loaderCompleteHandler );
    }

    private function loaderCompleteHandler(event:Event):void {

        var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture:Texture = Texture.fromBitmap(loadedBitmap);

        link = new Button(texture,'',texture);
        link.x = 410;
        link.y = 710;
        addChild(link);

        for each(var textElementVO:TextElementVO in linkElementVO.linkElements) {
            var textElement:TextElement = new TextElement(textElementVO,type,themeColor);
            if(textElementVO.textLayout == "linkPage") pageNumber = uint(textElementVO.text);
            link.addChild(textElement);
        }

        var line:Quad = new Quad(250,1,appModel.themeColor);
        line.x = 35;
        line.y = 110;
        link.addChildAt(line,link.numChildren-1);

    }


}
}
