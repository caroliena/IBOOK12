/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 16/12/12
 * Time: 12:03
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.view.components.elements {
import be.devine.cp3.vo.ImageElementVO;

import flash.display.Bitmap;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;

import starling.textures.Texture;

public class ImageElement extends Element{

    private var loader:Loader;
    private var type:uint;
    private var imageElementVO:ImageElementVO;

    public function ImageElement(imageElementVO:ImageElementVO,type:uint) {
        super(imageElementVO);
        this.imageElementVO = imageElementVO;
        this.type = type;

        loader = new Loader();
        loader.load ( new URLRequest(imageElementVO.url));
        loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, imageLoadedHandler );

    }

    private function imageLoadedHandler(event:Event):void {

        var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
        var texture:Texture = Texture.fromBitmap (loadedBitmap);
        var image:Image = new Image(texture);

        switch (type){
            case 4:
            case 1:
                image.x = image.y = 0;
                break;
            case 2:
            case 3:
                image.x = image.y = 35;
                break;
        }

        addChild(image);
    }
}
}
