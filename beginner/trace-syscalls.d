#!/usr/sbin/dtrace -qs

syscall::read:entry,
syscall::write:entry
/pid == $1/
{
	printf("%s\t%s(%d, 0x%x, %4d)", execname, probefunc, arg0, arg1, arg2);
}
syscall::read:return,
syscall::write:return
/pid == $1/
{
	printf("\t\t = %d\n", arg1);
}
