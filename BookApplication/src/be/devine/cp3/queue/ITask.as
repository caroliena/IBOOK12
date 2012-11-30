/**
 * Created with IntelliJ IDEA.
 * User: nicholasolivier
 * Date: 28/09/12
 * Time: 09:17
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue
{
import flash.events.IEventDispatcher;

public interface ITask extends IEventDispatcher
{
    function start():void;
}
}
