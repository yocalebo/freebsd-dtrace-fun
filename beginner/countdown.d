/*BSD 3-Clause License

Copyright (c) 2017, yocalebo
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/


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
