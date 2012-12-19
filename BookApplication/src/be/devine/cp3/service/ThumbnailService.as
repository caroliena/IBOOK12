/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 14/12/12
 * Time: 14:25
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.service {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.queue.ImageTask;
import be.devine.cp3.queue.Queue;
import be.devine.cp3.vo.PageVO;

import flash.display.Bitmap;

import flash.display.DisplayObject;

import flash.events.Event;
import flash.events.EventDispatcher;

import starling.display.DisplayObject;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.textures.Texture;

public class ThumbnailService extends EventDispatcher{

    private var appModel:AppModel;
    private var queue:Queue;

    public function ThumbnailService() {
        this.appModel = AppModel.getInstance();
    }

    public function load():void
    {
        queue = new Queue();
        for each( var page:PageVO in appModel.pages ){
            queue.add(new ImageTask(page.thumbnail));
        }
        queue.start();
        queue.addEventListener(Event.COMPLETE, imagesCompleteHandler);
    }

    private function imagesCompleteHandler(event:Event):void {
        for each(var task:ImageTask in queue.completedTasks)
        {
            var thumbnailBitmap:Bitmap = task.content as Bitmap;
            var thumbnail:Image = new Image(Texture.fromBitmap(thumbnailBitmap));
            appModel.thumbnails.push(thumbnail);
        }
        dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
