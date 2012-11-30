/**
 * Created with IntelliJ IDEA.
 * User: nicholasolivier
 * Date: 28/09/12
 * Time: 09:20
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.queue {
import flash.net.URLLoader;
import flash.net.URLRequest;

public class XmlTask extends URLLoader implements ITask
{
    private var xmlUrl:String;

    public function XmlTask(xmlUrl:String)
    {
        this.xmlUrl = xmlUrl;
    }

    public function start():void
    {
        this.load(new URLRequest(xmlUrl));
    }

}
}
