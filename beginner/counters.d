#!/usr/sbin/dtrace -s

dtrace:::BEGIN
{
	i = 0;
}
profile:::tick-1sec
{
	i += 1;
	trace(i);
}
dtrace:::END
{
	trace(i);
}
