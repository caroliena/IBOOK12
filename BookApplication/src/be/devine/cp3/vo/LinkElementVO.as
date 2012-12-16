/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 15/12/12
 * Time: 17:15
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.vo {
public class LinkElementVO extends ElementVO {

    public var linkElements:Vector.<TextElementVO>;

    public function LinkElementVO() {
        linkElements = new Vector.<TextElementVO>();
    }
}
}
