#!/usr/sbin/dtrace -s
/*Below is the beginning of the dtrace script that says to set i equal to 5 before any other tracing is performed.*/
dtrace:::BEGIN
{
	i=5;
}
/*Below is the "predicate" portion of the dtrace script. It basically says, I want to run the built-in profile "tick-1sec" when i is > 0
 *we know i is > 0 because at the beginning of this script we set the variable i to 5.*/
profile:::tick-1sec
/i > 0/
{
	trace(i--);
}
/*Below is another "predicate" portion of the dtrace script. It says, I want to run the built-in profile "tick-1sec" when i is 0.
 *Once i is equal to 0, we will return true and trace a message to the terminal and output "done!" and then exit(0) the script*/
profile:::tick-1sec
/i == 0/
{
	trace("\t    done!\n");
	exit(0);
}

/*Output of running this script is below:
 *CPU     ID                    FUNCTION:NAME
  0  71260                       :tick-1sec         5
  0  71260                       :tick-1sec         4
  0  71260                       :tick-1sec         3
  0  71260                       :tick-1sec         2
  0  71260                       :tick-1sec         1
  0  71260                       :tick-1sec   	    done!
*/
