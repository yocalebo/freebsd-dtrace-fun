#!/usr/sbin/dtrace -s

BEGIN
{
	trace("Hello, World!");
	exit(0);
}
