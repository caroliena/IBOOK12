/**
 * Created with IntelliJ IDEA.
 * User: carolina
 * Date: 30/11/12
 * Time: 11:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.vo {

    public class PageVO {

        public var type:uint;
        public var thumbnail:String;
        public var theme:String;
        public var elements:Vector.<ElementVO>;

        public function PageVO(){
            elements = new Vector.<ElementVO>();
        }
}
}
