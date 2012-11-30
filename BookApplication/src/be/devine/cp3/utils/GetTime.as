/**
 * Created by Nicholas Olivier on 28/11/12 at 15:14
 * website: http://www.nicholasolivier.be
 * --------------------------------------
 * Created with IntelliJ IDEA.
 */
package be.devine.cp3.utils {
public class GetTime {

    //Constructor
    static private var theDate:Date;
    static private var seconds:Number;
    static private var minutes:Number;
    static private var hours:Number;
    static private var theTime:String;

    static public function getTime():String
    {
        // create time segments
        theDate = new Date();
        seconds = theDate.getSeconds();
        minutes = theDate.getMinutes();
        hours = theDate.getHours();

        // create vars for sec and min
        var sec:String = seconds.toString();
        var min:String = minutes.toString();

        // set seconds, minutes, hours, and am/pm depending on actual time
        sec = (sec.length == 1) ? '0' + seconds.toString() : sec;
        min = (min.length == 1) ? '0' + minutes.toString() : min;

        // set time string
        theTime = hours +':'+ min +':'+ sec;
        return theTime;
    }

    //getters/setters

}
}
