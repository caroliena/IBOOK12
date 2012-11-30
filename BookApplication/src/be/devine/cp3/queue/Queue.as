/**
 * Created with IntelliJ IDEA.
 * User: nicholasolivier
 * Date: 28/09/12
 * Time: 09:14
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue
{

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

public class Queue extends EventDispatcher
{
    public var tasks:Array = new Array();
    public var currentTask:ITask;

    public var completedTasks:Array = new Array();
    public var totalTasks:int;

    public function Queue()
    {
        completedTasks = [];
        tasks = [];
        totalTasks = 0;
    }

    /**
     * <code>pushData</code> function. Pushes an ITask object in the queue.
     * @param media an ITask media which requires the start function.
     */
    private function appendData( media:ITask ):void
    {
        tasks.push(media);
        totalTasks++;
    }

    public function add( media:Object ):void
    {
        if(media == null) throw "ITask cannot be null!";
        if(media is ITask) appendData(media as ITask);
        else
        for(var i:int = 0; i<media.length; i++) if(media[i] is ITask) appendData(media[i]);
    }

    /**
     * Starts the current task.
     */
    public function start():void
    {
        if(tasks.length > 0)
        {
            currentTask = tasks.shift();
            currentTask.addEventListener(Event.COMPLETE, currentTaskCompleteHandler);
            currentTask.addEventListener(IOErrorEvent.IO_ERROR, currentTaskErrorHandler);
            currentTask.start();

        }  else {
           dispatchEvent(new Event(Event.COMPLETE,true));
        }

    }


    /**
     * Dispatches an error and removes the parsed item from the completed tasks array.
     * @param e The object where the error occurred.
     */
    private function currentTaskErrorHandler( e:IOErrorEvent ):void
    {
        totalTasks--;
        dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false,false,"Niet geladen task: "+e.text));
        start();
    }


    /**
     * Dispatches a progressEvent when the current task is completed.
     * @param e
     */
    private function currentTaskCompleteHandler( e:Event ):void
    {
        completedTasks.push(e.target);
        //trace(completedTasks.length);
        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false,false, completedTasks.length, totalTasks));
        start();

    }

}
}
