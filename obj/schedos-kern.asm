
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 42 02 00 00       	call   10025b <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 5b 01 00 00       	call   1001cd <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <priority_array>:
 * Initialize arr to contain all the pid entries with the 
 * lowest level priority (highest priority)
*/
int
priority_array(pid_t *arr)
{
  10009c:	57                   	push   %edi
  10009d:	31 c0                	xor    %eax,%eax
  10009f:	56                   	push   %esi
  1000a0:	53                   	push   %ebx
  1000a1:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1000a5:	bb ff ff ff 7f       	mov    $0x7fffffff,%ebx

        // determine the value of the maximum priority
        pid_t pid;
        for (pid = 0; pid < NPROCS; pid++)
        {
                procstate_t state = proc_array[pid].p_state;
  1000aa:	8b 90 cc 6d 10 00    	mov    0x106dcc(%eax),%edx
                if(state != P_EMPTY && state != P_ZOMBIE)
  1000b0:	83 fa 03             	cmp    $0x3,%edx
  1000b3:	74 10                	je     1000c5 <priority_array+0x29>
  1000b5:	85 d2                	test   %edx,%edx
  1000b7:	74 0c                	je     1000c5 <priority_array+0x29>
  1000b9:	8b 90 84 6d 10 00    	mov    0x106d84(%eax),%edx
  1000bf:	39 d3                	cmp    %edx,%ebx
  1000c1:	7e 02                	jle    1000c5 <priority_array+0x29>
  1000c3:	89 d3                	mov    %edx,%ebx
  1000c5:	83 c0 54             	add    $0x54,%eax
        int size = 0;
        int priority_max = MAX_INT;

        // determine the value of the maximum priority
        pid_t pid;
        for (pid = 0; pid < NPROCS; pid++)
  1000c8:	3d a4 01 00 00       	cmp    $0x1a4,%eax
  1000cd:	75 db                	jne    1000aa <priority_array+0xe>
  1000cf:	b9 cc 6d 10 00       	mov    $0x106dcc,%ecx
  1000d4:	31 d2                	xor    %edx,%edx
  1000d6:	66 31 c0             	xor    %ax,%ax
        }

        // create array of processes that have max priority
        for(pid = 0; pid < NPROCS; pid++)
        {
                procstate_t state = proc_array[pid].p_state;
  1000d9:	8b 31                	mov    (%ecx),%esi
                if(state != P_EMPTY && state != P_ZOMBIE)
  1000db:	83 fe 03             	cmp    $0x3,%esi
  1000de:	74 0d                	je     1000ed <priority_array+0x51>
  1000e0:	85 f6                	test   %esi,%esi
  1000e2:	74 09                	je     1000ed <priority_array+0x51>
                {
                        int tmp = proc_array[pid].p_priority;
                        if (tmp == priority_max)
  1000e4:	39 59 b8             	cmp    %ebx,-0x48(%ecx)
  1000e7:	75 04                	jne    1000ed <priority_array+0x51>
                        {
                                arr[size] = pid;
  1000e9:	89 14 87             	mov    %edx,(%edi,%eax,4)
                                size++;
  1000ec:	40                   	inc    %eax
                                priority_max = tmp;
                }
        }

        // create array of processes that have max priority
        for(pid = 0; pid < NPROCS; pid++)
  1000ed:	42                   	inc    %edx
  1000ee:	83 c1 54             	add    $0x54,%ecx
  1000f1:	83 fa 05             	cmp    $0x5,%edx
  1000f4:	75 e3                	jne    1000d9 <priority_array+0x3d>
                        }
                }
        }

        return size;
}
  1000f6:	5b                   	pop    %ebx
  1000f7:	5e                   	pop    %esi
  1000f8:	5f                   	pop    %edi
  1000f9:	c3                   	ret    

001000fa <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  1000fa:	56                   	push   %esi
  1000fb:	53                   	push   %ebx
  1000fc:	83 ec 24             	sub    $0x24,%esp
	pid_t pid = current->p_pid;
  1000ff:	a1 8c 77 10 00       	mov    0x10778c,%eax
  100104:	8b 18                	mov    (%eax),%ebx

	if (scheduling_algorithm == __EXERCISE_1__)
  100106:	a1 90 77 10 00       	mov    0x107790,%eax
  10010b:	85 c0                	test   %eax,%eax
  10010d:	75 1b                	jne    10012a <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  10010f:	b9 05 00 00 00       	mov    $0x5,%ecx
  100114:	8d 43 01             	lea    0x1(%ebx),%eax
  100117:	99                   	cltd   
  100118:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  10011a:	6b c2 54             	imul   $0x54,%edx,%eax
{
	pid_t pid = current->p_pid;

	if (scheduling_algorithm == __EXERCISE_1__)
		while (1) {
			pid = (pid + 1) % NPROCS;
  10011d:	89 d3                	mov    %edx,%ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  10011f:	83 b8 cc 6d 10 00 01 	cmpl   $0x1,0x106dcc(%eax)
  100126:	75 ec                	jne    100114 <schedule+0x1a>
  100128:	eb 74                	jmp    10019e <schedule+0xa4>
				run(&proc_array[pid]);
		}
	else if (scheduling_algorithm == __EXERCISE_2__)
  10012a:	83 f8 01             	cmp    $0x1,%eax
  10012d:	75 1e                	jne    10014d <schedule+0x53>
  10012f:	ba 01 00 00 00       	mov    $0x1,%edx
                pid = 1;

                while(1) {
                        if (proc_array[pid].p_state == P_RUNNABLE)
                                run(&proc_array[pid]);
                        pid = (pid + 1) % NPROCS;
  100134:	b9 05 00 00 00       	mov    $0x5,%ecx
	else if (scheduling_algorithm == __EXERCISE_2__)
        {
                pid = 1;

                while(1) {
                        if (proc_array[pid].p_state == P_RUNNABLE)
  100139:	6b c2 54             	imul   $0x54,%edx,%eax
  10013c:	83 b8 cc 6d 10 00 01 	cmpl   $0x1,0x106dcc(%eax)
  100143:	74 59                	je     10019e <schedule+0xa4>
                                run(&proc_array[pid]);
                        pid = (pid + 1) % NPROCS;
  100145:	8d 42 01             	lea    0x1(%edx),%eax
  100148:	99                   	cltd   
  100149:	f7 f9                	idiv   %ecx
                }
  10014b:	eb ec                	jmp    100139 <schedule+0x3f>
        }
	else if (scheduling_algorithm == __EXERCISE_4A__)
  10014d:	83 f8 02             	cmp    $0x2,%eax
  100150:	75 5a                	jne    1001ac <schedule+0xb2>
        {
                pid_t pArr[NPROCS];                     // array of processes with max priority
                int i = -1;                             // index into array
                int size = priority_array(pArr);        // size of array 
  100152:	83 ec 0c             	sub    $0xc,%esp
  100155:	8d 74 24 18          	lea    0x18(%esp),%esi
  100159:	56                   	push   %esi
  10015a:	e8 3d ff ff ff       	call   10009c <priority_array>

                // find current process's index into array
                if(first)
  10015f:	83 c4 10             	add    $0x10,%esp
  100162:	83 3d 00 10 10 00 00 	cmpl   $0x0,0x101000
        }
	else if (scheduling_algorithm == __EXERCISE_4A__)
        {
                pid_t pArr[NPROCS];                     // array of processes with max priority
                int i = -1;                             // index into array
                int size = priority_array(pArr);        // size of array 
  100169:	89 c1                	mov    %eax,%ecx

                // find current process's index into array
                if(first)
  10016b:	75 04                	jne    100171 <schedule+0x77>
  10016d:	31 d2                	xor    %edx,%edx
  10016f:	eb 15                	jmp    100186 <schedule+0x8c>
                        first = 0;
  100171:	c7 05 00 10 10 00 00 	movl   $0x0,0x101000
  100178:	00 00 00 
  10017b:	83 ca ff             	or     $0xffffffff,%edx
  10017e:	eb 0a                	jmp    10018a <schedule+0x90>
                else
                {
                        for(i = 0; i < size; i++)
                        {
                                if(pArr[i] == pid)
  100180:	39 1c 96             	cmp    %ebx,(%esi,%edx,4)
  100183:	74 05                	je     10018a <schedule+0x90>
                // find current process's index into array
                if(first)
                        first = 0;
                else
                {
                        for(i = 0; i < size; i++)
  100185:	42                   	inc    %edx
  100186:	39 ca                	cmp    %ecx,%edx
  100188:	7c f6                	jl     100180 <schedule+0x86>
                        }
                }

                // while any processes remain in the priority array, run them
                while (1) {
                        i = (i + 1) % size;
  10018a:	8d 42 01             	lea    0x1(%edx),%eax
  10018d:	99                   	cltd   
  10018e:	f7 f9                	idiv   %ecx

                        pid = pArr[i];

                        // run process if runnable
                        if (proc_array[pid].p_state == P_RUNNABLE)
  100190:	6b 44 94 0c 54       	imul   $0x54,0xc(%esp,%edx,4),%eax
  100195:	83 b8 cc 6d 10 00 01 	cmpl   $0x1,0x106dcc(%eax)
  10019c:	75 ec                	jne    10018a <schedule+0x90>
                                run(&proc_array[pid]);
  10019e:	83 ec 0c             	sub    $0xc,%esp
  1001a1:	05 80 6d 10 00       	add    $0x106d80,%eax
  1001a6:	50                   	push   %eax
  1001a7:	e8 e9 03 00 00       	call   100595 <run>
                }
        }
	
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001ac:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001b2:	50                   	push   %eax
  1001b3:	68 54 0b 10 00       	push   $0x100b54
  1001b8:	68 00 01 00 00       	push   $0x100
  1001bd:	52                   	push   %edx
  1001be:	e8 77 09 00 00       	call   100b3a <console_printf>
  1001c3:	83 c4 10             	add    $0x10,%esp
  1001c6:	a3 00 80 19 00       	mov    %eax,0x198000
  1001cb:	eb fe                	jmp    1001cb <schedule+0xd1>

001001cd <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001cd:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001ce:	a1 8c 77 10 00       	mov    0x10778c,%eax
  1001d3:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001d8:	56                   	push   %esi
  1001d9:	53                   	push   %ebx
  1001da:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001de:	8d 78 08             	lea    0x8(%eax),%edi
  1001e1:	89 de                	mov    %ebx,%esi
  1001e3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001e5:	8b 53 28             	mov    0x28(%ebx),%edx
  1001e8:	83 fa 32             	cmp    $0x32,%edx
  1001eb:	74 38                	je     100225 <interrupt+0x58>
  1001ed:	77 0e                	ja     1001fd <interrupt+0x30>
  1001ef:	83 fa 30             	cmp    $0x30,%edx
  1001f2:	74 15                	je     100209 <interrupt+0x3c>
  1001f4:	77 18                	ja     10020e <interrupt+0x41>
  1001f6:	83 fa 20             	cmp    $0x20,%edx
  1001f9:	74 59                	je     100254 <interrupt+0x87>
  1001fb:	eb 5c                	jmp    100259 <interrupt+0x8c>
  1001fd:	83 fa 33             	cmp    $0x33,%edx
  100200:	74 2e                	je     100230 <interrupt+0x63>
  100202:	83 fa 34             	cmp    $0x34,%edx
  100205:	74 32                	je     100239 <interrupt+0x6c>
  100207:	eb 50                	jmp    100259 <interrupt+0x8c>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100209:	e8 ec fe ff ff       	call   1000fa <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10020e:	a1 8c 77 10 00       	mov    0x10778c,%eax
		current->p_exit_status = reg->reg_eax;
  100213:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100216:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = reg->reg_eax;
  10021d:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  100220:	e8 d5 fe ff ff       	call   1000fa <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100225:	83 ec 0c             	sub    $0xc,%esp
  100228:	ff 35 8c 77 10 00    	pushl  0x10778c
  10022e:	eb 04                	jmp    100234 <interrupt+0x67>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100230:	83 ec 0c             	sub    $0xc,%esp
  100233:	50                   	push   %eax
  100234:	e8 5c 03 00 00       	call   100595 <run>

	case INT_SYS_ATOMICPRINT:
                *cursorpos++ = reg->reg_eax;
  100239:	a1 00 80 19 00       	mov    0x198000,%eax
  10023e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100241:	66 89 10             	mov    %dx,(%eax)
  100244:	83 c0 02             	add    $0x2,%eax
	default:
		while (1)
			/* do nothing */;

	}
}
  100247:	5b                   	pop    %ebx
  100248:	5e                   	pop    %esi
  100249:	5f                   	pop    %edi
	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);

	case INT_SYS_ATOMICPRINT:
                *cursorpos++ = reg->reg_eax;
  10024a:	a3 00 80 19 00       	mov    %eax,0x198000
                schedule();
  10024f:	e9 a6 fe ff ff       	jmp    1000fa <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100254:	e8 a1 fe ff ff       	call   1000fa <schedule>
  100259:	eb fe                	jmp    100259 <interrupt+0x8c>

0010025b <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10025b:	57                   	push   %edi
	}

	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
  10025c:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100261:	56                   	push   %esi
	}

	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
  100262:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100264:	53                   	push   %ebx
	}

	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
  100265:	bb d4 6d 10 00       	mov    $0x106dd4,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10026a:	e8 05 01 00 00       	call   100374 <segments_init>
	interrupt_controller_init(1);
  10026f:	83 ec 0c             	sub    $0xc,%esp
  100272:	6a 01                	push   $0x1
  100274:	e8 f6 01 00 00       	call   10046f <interrupt_controller_init>
	console_clear();
  100279:	e8 7a 02 00 00       	call   1004f8 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10027e:	83 c4 0c             	add    $0xc,%esp
  100281:	68 a4 01 00 00       	push   $0x1a4
  100286:	6a 00                	push   $0x0
  100288:	68 80 6d 10 00       	push   $0x106d80
  10028d:	e8 46 04 00 00       	call   1006d8 <memset>
	}

	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
  100292:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100295:	c7 05 80 6d 10 00 00 	movl   $0x0,0x106d80
  10029c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10029f:	c7 05 cc 6d 10 00 00 	movl   $0x0,0x106dcc
  1002a6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002a9:	c7 05 d4 6d 10 00 01 	movl   $0x1,0x106dd4
  1002b0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002b3:	c7 05 20 6e 10 00 00 	movl   $0x0,0x106e20
  1002ba:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002bd:	c7 05 28 6e 10 00 02 	movl   $0x2,0x106e28
  1002c4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002c7:	c7 05 74 6e 10 00 00 	movl   $0x0,0x106e74
  1002ce:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d1:	c7 05 7c 6e 10 00 03 	movl   $0x3,0x106e7c
  1002d8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002db:	c7 05 c8 6e 10 00 00 	movl   $0x0,0x106ec8
  1002e2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002e5:	c7 05 d0 6e 10 00 04 	movl   $0x4,0x106ed0
  1002ec:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002ef:	c7 05 1c 6f 10 00 00 	movl   $0x0,0x106f1c
  1002f6:	00 00 00 
	}

	proc_array[1].p_priority = __PRIORITY_1__;	
  1002f9:	c7 05 d8 6d 10 00 01 	movl   $0x1,0x106dd8
  100300:	00 00 00 
	proc_array[2].p_priority = __PRIORITY_2__;
  100303:	c7 05 2c 6e 10 00 02 	movl   $0x2,0x106e2c
  10030a:	00 00 00 
	proc_array[3].p_priority = __PRIORITY_3__;
  10030d:	c7 05 80 6e 10 00 03 	movl   $0x3,0x106e80
  100314:	00 00 00 
	proc_array[4].p_priority = __PRIORITY_4__;
  100317:	c7 05 d4 6e 10 00 04 	movl   $0x4,0x106ed4
  10031e:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100321:	83 ec 0c             	sub    $0xc,%esp
  100324:	53                   	push   %ebx
  100325:	e8 82 02 00 00       	call   1005ac <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10032a:	58                   	pop    %eax
  10032b:	5a                   	pop    %edx
  10032c:	8d 43 38             	lea    0x38(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10032f:	89 7b 44             	mov    %edi,0x44(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100332:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100338:	50                   	push   %eax
  100339:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10033a:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10033b:	e8 a8 02 00 00       	call   1005e8 <program_loader>
	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100340:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100343:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  10034a:	83 c3 54             	add    $0x54,%ebx
	proc_array[1].p_priority = __PRIORITY_1__;	
	proc_array[2].p_priority = __PRIORITY_2__;
	proc_array[3].p_priority = __PRIORITY_3__;
	proc_array[4].p_priority = __PRIORITY_4__;
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10034d:	83 fe 04             	cmp    $0x4,%esi
  100350:	75 cf                	jne    100321 <start+0xc6>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = __EXERCISE_4A__;

	// Switch to the first process.
	run(&proc_array[1]);
  100352:	83 ec 0c             	sub    $0xc,%esp
  100355:	68 d4 6d 10 00       	push   $0x106dd4
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10035a:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100361:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = __EXERCISE_4A__;
  100364:	c7 05 90 77 10 00 02 	movl   $0x2,0x107790
  10036b:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10036e:	e8 22 02 00 00       	call   100595 <run>
  100373:	90                   	nop

00100374 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100374:	b8 24 6f 10 00       	mov    $0x106f24,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100379:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10037e:	89 c2                	mov    %eax,%edx
  100380:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100383:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100384:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100389:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10038c:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  100392:	c1 e8 18             	shr    $0x18,%eax
  100395:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10039b:	ba 8c 6f 10 00       	mov    $0x106f8c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a0:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a5:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a7:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  1003ae:	68 00 
  1003b0:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003b7:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003be:	c7 05 28 6f 10 00 00 	movl   $0x180000,0x106f28
  1003c5:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003c8:	66 c7 05 2c 6f 10 00 	movw   $0x10,0x106f2c
  1003cf:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d1:	66 89 0c c5 8c 6f 10 	mov    %cx,0x106f8c(,%eax,8)
  1003d8:	00 
  1003d9:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003e0:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003e5:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003ea:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003ef:	40                   	inc    %eax
  1003f0:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003f5:	75 da                	jne    1003d1 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003f7:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003fc:	ba 8c 6f 10 00       	mov    $0x106f8c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100401:	66 a3 8c 70 10 00    	mov    %ax,0x10708c
  100407:	c1 e8 10             	shr    $0x10,%eax
  10040a:	66 a3 92 70 10 00    	mov    %ax,0x107092
  100410:	b8 30 00 00 00       	mov    $0x30,%eax
  100415:	66 c7 05 8e 70 10 00 	movw   $0x8,0x10708e
  10041c:	08 00 
  10041e:	c6 05 90 70 10 00 00 	movb   $0x0,0x107090
  100425:	c6 05 91 70 10 00 8e 	movb   $0x8e,0x107091

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10042c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100433:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10043a:	66 89 0c c5 8c 6f 10 	mov    %cx,0x106f8c(,%eax,8)
  100441:	00 
  100442:	c1 e9 10             	shr    $0x10,%ecx
  100445:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10044a:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10044f:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100454:	40                   	inc    %eax
  100455:	83 f8 3a             	cmp    $0x3a,%eax
  100458:	75 d2                	jne    10042c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10045a:	b0 28                	mov    $0x28,%al
  10045c:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  100463:	0f 00 d8             	ltr    %ax
  100466:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10046d:	5b                   	pop    %ebx
  10046e:	c3                   	ret    

0010046f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10046f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100470:	b0 ff                	mov    $0xff,%al
  100472:	57                   	push   %edi
  100473:	56                   	push   %esi
  100474:	53                   	push   %ebx
  100475:	bb 21 00 00 00       	mov    $0x21,%ebx
  10047a:	89 da                	mov    %ebx,%edx
  10047c:	ee                   	out    %al,(%dx)
  10047d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100482:	89 ca                	mov    %ecx,%edx
  100484:	ee                   	out    %al,(%dx)
  100485:	be 11 00 00 00       	mov    $0x11,%esi
  10048a:	bf 20 00 00 00       	mov    $0x20,%edi
  10048f:	89 f0                	mov    %esi,%eax
  100491:	89 fa                	mov    %edi,%edx
  100493:	ee                   	out    %al,(%dx)
  100494:	b0 20                	mov    $0x20,%al
  100496:	89 da                	mov    %ebx,%edx
  100498:	ee                   	out    %al,(%dx)
  100499:	b0 04                	mov    $0x4,%al
  10049b:	ee                   	out    %al,(%dx)
  10049c:	b0 03                	mov    $0x3,%al
  10049e:	ee                   	out    %al,(%dx)
  10049f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004a4:	89 f0                	mov    %esi,%eax
  1004a6:	89 ea                	mov    %ebp,%edx
  1004a8:	ee                   	out    %al,(%dx)
  1004a9:	b0 28                	mov    $0x28,%al
  1004ab:	89 ca                	mov    %ecx,%edx
  1004ad:	ee                   	out    %al,(%dx)
  1004ae:	b0 02                	mov    $0x2,%al
  1004b0:	ee                   	out    %al,(%dx)
  1004b1:	b0 01                	mov    $0x1,%al
  1004b3:	ee                   	out    %al,(%dx)
  1004b4:	b0 68                	mov    $0x68,%al
  1004b6:	89 fa                	mov    %edi,%edx
  1004b8:	ee                   	out    %al,(%dx)
  1004b9:	be 0a 00 00 00       	mov    $0xa,%esi
  1004be:	89 f0                	mov    %esi,%eax
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	b0 68                	mov    $0x68,%al
  1004c3:	89 ea                	mov    %ebp,%edx
  1004c5:	ee                   	out    %al,(%dx)
  1004c6:	89 f0                	mov    %esi,%eax
  1004c8:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004c9:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004ce:	89 da                	mov    %ebx,%edx
  1004d0:	19 c0                	sbb    %eax,%eax
  1004d2:	f7 d0                	not    %eax
  1004d4:	05 ff 00 00 00       	add    $0xff,%eax
  1004d9:	ee                   	out    %al,(%dx)
  1004da:	b0 ff                	mov    $0xff,%al
  1004dc:	89 ca                	mov    %ecx,%edx
  1004de:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004df:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004e4:	74 0d                	je     1004f3 <interrupt_controller_init+0x84>
  1004e6:	b2 43                	mov    $0x43,%dl
  1004e8:	b0 34                	mov    $0x34,%al
  1004ea:	ee                   	out    %al,(%dx)
  1004eb:	b0 a9                	mov    $0xa9,%al
  1004ed:	b2 40                	mov    $0x40,%dl
  1004ef:	ee                   	out    %al,(%dx)
  1004f0:	b0 04                	mov    $0x4,%al
  1004f2:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004f3:	5b                   	pop    %ebx
  1004f4:	5e                   	pop    %esi
  1004f5:	5f                   	pop    %edi
  1004f6:	5d                   	pop    %ebp
  1004f7:	c3                   	ret    

001004f8 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004f8:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004f9:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1004fb:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1004fc:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100503:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100506:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10050c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100512:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100515:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10051a:	75 ea                	jne    100506 <console_clear+0xe>
  10051c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100521:	b0 0e                	mov    $0xe,%al
  100523:	89 f2                	mov    %esi,%edx
  100525:	ee                   	out    %al,(%dx)
  100526:	31 c9                	xor    %ecx,%ecx
  100528:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10052d:	88 c8                	mov    %cl,%al
  10052f:	89 da                	mov    %ebx,%edx
  100531:	ee                   	out    %al,(%dx)
  100532:	b0 0f                	mov    $0xf,%al
  100534:	89 f2                	mov    %esi,%edx
  100536:	ee                   	out    %al,(%dx)
  100537:	88 c8                	mov    %cl,%al
  100539:	89 da                	mov    %ebx,%edx
  10053b:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10053c:	5b                   	pop    %ebx
  10053d:	5e                   	pop    %esi
  10053e:	c3                   	ret    

0010053f <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10053f:	ba 64 00 00 00       	mov    $0x64,%edx
  100544:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100545:	a8 01                	test   $0x1,%al
  100547:	74 45                	je     10058e <console_read_digit+0x4f>
  100549:	b2 60                	mov    $0x60,%dl
  10054b:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10054c:	8d 50 fe             	lea    -0x2(%eax),%edx
  10054f:	80 fa 08             	cmp    $0x8,%dl
  100552:	77 05                	ja     100559 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100554:	0f b6 c0             	movzbl %al,%eax
  100557:	48                   	dec    %eax
  100558:	c3                   	ret    
	else if (data == 0x0B)
  100559:	3c 0b                	cmp    $0xb,%al
  10055b:	74 35                	je     100592 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10055d:	8d 50 b9             	lea    -0x47(%eax),%edx
  100560:	80 fa 02             	cmp    $0x2,%dl
  100563:	77 07                	ja     10056c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100565:	0f b6 c0             	movzbl %al,%eax
  100568:	83 e8 40             	sub    $0x40,%eax
  10056b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10056c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10056f:	80 fa 02             	cmp    $0x2,%dl
  100572:	77 07                	ja     10057b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100574:	0f b6 c0             	movzbl %al,%eax
  100577:	83 e8 47             	sub    $0x47,%eax
  10057a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10057b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10057e:	80 fa 02             	cmp    $0x2,%dl
  100581:	77 07                	ja     10058a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100583:	0f b6 c0             	movzbl %al,%eax
  100586:	83 e8 4e             	sub    $0x4e,%eax
  100589:	c3                   	ret    
	else if (data == 0x53)
  10058a:	3c 53                	cmp    $0x53,%al
  10058c:	74 04                	je     100592 <console_read_digit+0x53>
  10058e:	83 c8 ff             	or     $0xffffffff,%eax
  100591:	c3                   	ret    
  100592:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100594:	c3                   	ret    

00100595 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100595:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100599:	a3 8c 77 10 00       	mov    %eax,0x10778c

	asm volatile("movl %0,%%esp\n\t"
  10059e:	83 c0 08             	add    $0x8,%eax
  1005a1:	89 c4                	mov    %eax,%esp
  1005a3:	61                   	popa   
  1005a4:	07                   	pop    %es
  1005a5:	1f                   	pop    %ds
  1005a6:	83 c4 08             	add    $0x8,%esp
  1005a9:	cf                   	iret   
  1005aa:	eb fe                	jmp    1005aa <run+0x15>

001005ac <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005ac:	53                   	push   %ebx
  1005ad:	83 ec 0c             	sub    $0xc,%esp
  1005b0:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005b4:	6a 44                	push   $0x44
  1005b6:	6a 00                	push   $0x0
  1005b8:	8d 43 08             	lea    0x8(%ebx),%eax
  1005bb:	50                   	push   %eax
  1005bc:	e8 17 01 00 00       	call   1006d8 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005c1:	66 c7 43 3c 1b 00    	movw   $0x1b,0x3c(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005c7:	66 c7 43 2c 23 00    	movw   $0x23,0x2c(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005cd:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005d3:	66 c7 43 48 23 00    	movw   $0x23,0x48(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005d9:	c7 43 40 00 02 00 00 	movl   $0x200,0x40(%ebx)
}
  1005e0:	83 c4 18             	add    $0x18,%esp
  1005e3:	5b                   	pop    %ebx
  1005e4:	c3                   	ret    
  1005e5:	90                   	nop
  1005e6:	90                   	nop
  1005e7:	90                   	nop

001005e8 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005e8:	55                   	push   %ebp
  1005e9:	57                   	push   %edi
  1005ea:	56                   	push   %esi
  1005eb:	53                   	push   %ebx
  1005ec:	83 ec 1c             	sub    $0x1c,%esp
  1005ef:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005f3:	83 f8 03             	cmp    $0x3,%eax
  1005f6:	7f 04                	jg     1005fc <program_loader+0x14>
  1005f8:	85 c0                	test   %eax,%eax
  1005fa:	79 02                	jns    1005fe <program_loader+0x16>
  1005fc:	eb fe                	jmp    1005fc <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1005fe:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100605:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10060b:	74 02                	je     10060f <program_loader+0x27>
  10060d:	eb fe                	jmp    10060d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10060f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100612:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100616:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100618:	c1 e5 05             	shl    $0x5,%ebp
  10061b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10061e:	eb 3f                	jmp    10065f <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100620:	83 3b 01             	cmpl   $0x1,(%ebx)
  100623:	75 37                	jne    10065c <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100625:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100628:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10062b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10062e:	01 c7                	add    %eax,%edi
	memsz += va;
  100630:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100632:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100637:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10063b:	52                   	push   %edx
  10063c:	89 fa                	mov    %edi,%edx
  10063e:	29 c2                	sub    %eax,%edx
  100640:	52                   	push   %edx
  100641:	8b 53 04             	mov    0x4(%ebx),%edx
  100644:	01 f2                	add    %esi,%edx
  100646:	52                   	push   %edx
  100647:	50                   	push   %eax
  100648:	e8 27 00 00 00       	call   100674 <memcpy>
  10064d:	83 c4 10             	add    $0x10,%esp
  100650:	eb 04                	jmp    100656 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100652:	c6 07 00             	movb   $0x0,(%edi)
  100655:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100656:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10065a:	72 f6                	jb     100652 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  10065c:	83 c3 20             	add    $0x20,%ebx
  10065f:	39 eb                	cmp    %ebp,%ebx
  100661:	72 bd                	jb     100620 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100663:	8b 56 18             	mov    0x18(%esi),%edx
  100666:	8b 44 24 34          	mov    0x34(%esp),%eax
  10066a:	89 10                	mov    %edx,(%eax)
}
  10066c:	83 c4 1c             	add    $0x1c,%esp
  10066f:	5b                   	pop    %ebx
  100670:	5e                   	pop    %esi
  100671:	5f                   	pop    %edi
  100672:	5d                   	pop    %ebp
  100673:	c3                   	ret    

00100674 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100674:	56                   	push   %esi
  100675:	31 d2                	xor    %edx,%edx
  100677:	53                   	push   %ebx
  100678:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10067c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100680:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100684:	eb 08                	jmp    10068e <memcpy+0x1a>
		*d++ = *s++;
  100686:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100689:	4e                   	dec    %esi
  10068a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10068d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10068e:	85 f6                	test   %esi,%esi
  100690:	75 f4                	jne    100686 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100692:	5b                   	pop    %ebx
  100693:	5e                   	pop    %esi
  100694:	c3                   	ret    

00100695 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100695:	57                   	push   %edi
  100696:	56                   	push   %esi
  100697:	53                   	push   %ebx
  100698:	8b 44 24 10          	mov    0x10(%esp),%eax
  10069c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006a0:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006a4:	39 c7                	cmp    %eax,%edi
  1006a6:	73 26                	jae    1006ce <memmove+0x39>
  1006a8:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006ab:	39 c6                	cmp    %eax,%esi
  1006ad:	76 1f                	jbe    1006ce <memmove+0x39>
		s += n, d += n;
  1006af:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006b2:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006b4:	eb 07                	jmp    1006bd <memmove+0x28>
			*--d = *--s;
  1006b6:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006b9:	4a                   	dec    %edx
  1006ba:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006bd:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006be:	85 d2                	test   %edx,%edx
  1006c0:	75 f4                	jne    1006b6 <memmove+0x21>
  1006c2:	eb 10                	jmp    1006d4 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006c4:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006c7:	4a                   	dec    %edx
  1006c8:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006cb:	41                   	inc    %ecx
  1006cc:	eb 02                	jmp    1006d0 <memmove+0x3b>
  1006ce:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006d0:	85 d2                	test   %edx,%edx
  1006d2:	75 f0                	jne    1006c4 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006d4:	5b                   	pop    %ebx
  1006d5:	5e                   	pop    %esi
  1006d6:	5f                   	pop    %edi
  1006d7:	c3                   	ret    

001006d8 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006d8:	53                   	push   %ebx
  1006d9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006dd:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006e1:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006e5:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006e7:	eb 04                	jmp    1006ed <memset+0x15>
		*p++ = c;
  1006e9:	88 1a                	mov    %bl,(%edx)
  1006eb:	49                   	dec    %ecx
  1006ec:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006ed:	85 c9                	test   %ecx,%ecx
  1006ef:	75 f8                	jne    1006e9 <memset+0x11>
		*p++ = c;
	return v;
}
  1006f1:	5b                   	pop    %ebx
  1006f2:	c3                   	ret    

001006f3 <strlen>:

size_t
strlen(const char *s)
{
  1006f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006f7:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006f9:	eb 01                	jmp    1006fc <strlen+0x9>
		++n;
  1006fb:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1006fc:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100700:	75 f9                	jne    1006fb <strlen+0x8>
		++n;
	return n;
}
  100702:	c3                   	ret    

00100703 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100703:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100707:	31 c0                	xor    %eax,%eax
  100709:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10070d:	eb 01                	jmp    100710 <strnlen+0xd>
		++n;
  10070f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100710:	39 d0                	cmp    %edx,%eax
  100712:	74 06                	je     10071a <strnlen+0x17>
  100714:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100718:	75 f5                	jne    10070f <strnlen+0xc>
		++n;
	return n;
}
  10071a:	c3                   	ret    

0010071b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10071b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10071c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100721:	53                   	push   %ebx
  100722:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100724:	76 05                	jbe    10072b <console_putc+0x10>
  100726:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10072b:	80 fa 0a             	cmp    $0xa,%dl
  10072e:	75 2c                	jne    10075c <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100730:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100736:	be 50 00 00 00       	mov    $0x50,%esi
  10073b:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  10073d:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100740:	99                   	cltd   
  100741:	f7 fe                	idiv   %esi
  100743:	89 de                	mov    %ebx,%esi
  100745:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100747:	eb 07                	jmp    100750 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100749:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10074c:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  10074d:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100750:	83 f8 50             	cmp    $0x50,%eax
  100753:	75 f4                	jne    100749 <console_putc+0x2e>
  100755:	29 d0                	sub    %edx,%eax
  100757:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10075a:	eb 0b                	jmp    100767 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  10075c:	0f b6 d2             	movzbl %dl,%edx
  10075f:	09 ca                	or     %ecx,%edx
  100761:	66 89 13             	mov    %dx,(%ebx)
  100764:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100767:	5b                   	pop    %ebx
  100768:	5e                   	pop    %esi
  100769:	c3                   	ret    

0010076a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10076a:	56                   	push   %esi
  10076b:	53                   	push   %ebx
  10076c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100770:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100773:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100777:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10077c:	75 04                	jne    100782 <fill_numbuf+0x18>
  10077e:	85 d2                	test   %edx,%edx
  100780:	74 10                	je     100792 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100782:	89 d0                	mov    %edx,%eax
  100784:	31 d2                	xor    %edx,%edx
  100786:	f7 f1                	div    %ecx
  100788:	4b                   	dec    %ebx
  100789:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10078c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10078e:	89 c2                	mov    %eax,%edx
  100790:	eb ec                	jmp    10077e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100792:	89 d8                	mov    %ebx,%eax
  100794:	5b                   	pop    %ebx
  100795:	5e                   	pop    %esi
  100796:	c3                   	ret    

00100797 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100797:	55                   	push   %ebp
  100798:	57                   	push   %edi
  100799:	56                   	push   %esi
  10079a:	53                   	push   %ebx
  10079b:	83 ec 38             	sub    $0x38,%esp
  10079e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007a2:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007a6:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007aa:	e9 60 03 00 00       	jmp    100b0f <console_vprintf+0x378>
		if (*format != '%') {
  1007af:	80 fa 25             	cmp    $0x25,%dl
  1007b2:	74 13                	je     1007c7 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007b4:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007b8:	0f b6 d2             	movzbl %dl,%edx
  1007bb:	89 f0                	mov    %esi,%eax
  1007bd:	e8 59 ff ff ff       	call   10071b <console_putc>
  1007c2:	e9 45 03 00 00       	jmp    100b0c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007c7:	47                   	inc    %edi
  1007c8:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007cf:	00 
  1007d0:	eb 12                	jmp    1007e4 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007d2:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007d3:	8a 11                	mov    (%ecx),%dl
  1007d5:	84 d2                	test   %dl,%dl
  1007d7:	74 1a                	je     1007f3 <console_vprintf+0x5c>
  1007d9:	89 e8                	mov    %ebp,%eax
  1007db:	38 c2                	cmp    %al,%dl
  1007dd:	75 f3                	jne    1007d2 <console_vprintf+0x3b>
  1007df:	e9 3f 03 00 00       	jmp    100b23 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007e4:	8a 17                	mov    (%edi),%dl
  1007e6:	84 d2                	test   %dl,%dl
  1007e8:	74 0b                	je     1007f5 <console_vprintf+0x5e>
  1007ea:	b9 78 0b 10 00       	mov    $0x100b78,%ecx
  1007ef:	89 d5                	mov    %edx,%ebp
  1007f1:	eb e0                	jmp    1007d3 <console_vprintf+0x3c>
  1007f3:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007f5:	8d 42 cf             	lea    -0x31(%edx),%eax
  1007f8:	3c 08                	cmp    $0x8,%al
  1007fa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100801:	00 
  100802:	76 13                	jbe    100817 <console_vprintf+0x80>
  100804:	eb 1d                	jmp    100823 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100806:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10080b:	0f be c0             	movsbl %al,%eax
  10080e:	47                   	inc    %edi
  10080f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100813:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100817:	8a 07                	mov    (%edi),%al
  100819:	8d 50 d0             	lea    -0x30(%eax),%edx
  10081c:	80 fa 09             	cmp    $0x9,%dl
  10081f:	76 e5                	jbe    100806 <console_vprintf+0x6f>
  100821:	eb 18                	jmp    10083b <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100823:	80 fa 2a             	cmp    $0x2a,%dl
  100826:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10082d:	ff 
  10082e:	75 0b                	jne    10083b <console_vprintf+0xa4>
			width = va_arg(val, int);
  100830:	83 c3 04             	add    $0x4,%ebx
			++format;
  100833:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100834:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100837:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10083b:	83 cd ff             	or     $0xffffffff,%ebp
  10083e:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100841:	75 37                	jne    10087a <console_vprintf+0xe3>
			++format;
  100843:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100844:	31 ed                	xor    %ebp,%ebp
  100846:	8a 07                	mov    (%edi),%al
  100848:	8d 50 d0             	lea    -0x30(%eax),%edx
  10084b:	80 fa 09             	cmp    $0x9,%dl
  10084e:	76 0d                	jbe    10085d <console_vprintf+0xc6>
  100850:	eb 17                	jmp    100869 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100852:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100855:	0f be c0             	movsbl %al,%eax
  100858:	47                   	inc    %edi
  100859:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  10085d:	8a 07                	mov    (%edi),%al
  10085f:	8d 50 d0             	lea    -0x30(%eax),%edx
  100862:	80 fa 09             	cmp    $0x9,%dl
  100865:	76 eb                	jbe    100852 <console_vprintf+0xbb>
  100867:	eb 11                	jmp    10087a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100869:	3c 2a                	cmp    $0x2a,%al
  10086b:	75 0b                	jne    100878 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  10086d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100870:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100871:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100874:	85 ed                	test   %ebp,%ebp
  100876:	79 02                	jns    10087a <console_vprintf+0xe3>
  100878:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10087a:	8a 07                	mov    (%edi),%al
  10087c:	3c 64                	cmp    $0x64,%al
  10087e:	74 34                	je     1008b4 <console_vprintf+0x11d>
  100880:	7f 1d                	jg     10089f <console_vprintf+0x108>
  100882:	3c 58                	cmp    $0x58,%al
  100884:	0f 84 a2 00 00 00    	je     10092c <console_vprintf+0x195>
  10088a:	3c 63                	cmp    $0x63,%al
  10088c:	0f 84 bf 00 00 00    	je     100951 <console_vprintf+0x1ba>
  100892:	3c 43                	cmp    $0x43,%al
  100894:	0f 85 d0 00 00 00    	jne    10096a <console_vprintf+0x1d3>
  10089a:	e9 a3 00 00 00       	jmp    100942 <console_vprintf+0x1ab>
  10089f:	3c 75                	cmp    $0x75,%al
  1008a1:	74 4d                	je     1008f0 <console_vprintf+0x159>
  1008a3:	3c 78                	cmp    $0x78,%al
  1008a5:	74 5c                	je     100903 <console_vprintf+0x16c>
  1008a7:	3c 73                	cmp    $0x73,%al
  1008a9:	0f 85 bb 00 00 00    	jne    10096a <console_vprintf+0x1d3>
  1008af:	e9 86 00 00 00       	jmp    10093a <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008b4:	83 c3 04             	add    $0x4,%ebx
  1008b7:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008ba:	89 d1                	mov    %edx,%ecx
  1008bc:	c1 f9 1f             	sar    $0x1f,%ecx
  1008bf:	89 0c 24             	mov    %ecx,(%esp)
  1008c2:	31 ca                	xor    %ecx,%edx
  1008c4:	55                   	push   %ebp
  1008c5:	29 ca                	sub    %ecx,%edx
  1008c7:	68 80 0b 10 00       	push   $0x100b80
  1008cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008d1:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008d5:	e8 90 fe ff ff       	call   10076a <fill_numbuf>
  1008da:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008de:	58                   	pop    %eax
  1008df:	5a                   	pop    %edx
  1008e0:	ba 01 00 00 00       	mov    $0x1,%edx
  1008e5:	8b 04 24             	mov    (%esp),%eax
  1008e8:	83 e0 01             	and    $0x1,%eax
  1008eb:	e9 a5 00 00 00       	jmp    100995 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008f0:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008f8:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008fb:	55                   	push   %ebp
  1008fc:	68 80 0b 10 00       	push   $0x100b80
  100901:	eb 11                	jmp    100914 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100903:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100906:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100909:	55                   	push   %ebp
  10090a:	68 94 0b 10 00       	push   $0x100b94
  10090f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100914:	8d 44 24 40          	lea    0x40(%esp),%eax
  100918:	e8 4d fe ff ff       	call   10076a <fill_numbuf>
  10091d:	ba 01 00 00 00       	mov    $0x1,%edx
  100922:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100926:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100928:	59                   	pop    %ecx
  100929:	59                   	pop    %ecx
  10092a:	eb 69                	jmp    100995 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10092c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10092f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100932:	55                   	push   %ebp
  100933:	68 80 0b 10 00       	push   $0x100b80
  100938:	eb d5                	jmp    10090f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10093a:	83 c3 04             	add    $0x4,%ebx
  10093d:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100940:	eb 40                	jmp    100982 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100942:	83 c3 04             	add    $0x4,%ebx
  100945:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100948:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  10094c:	e9 bd 01 00 00       	jmp    100b0e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100951:	83 c3 04             	add    $0x4,%ebx
  100954:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100957:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10095b:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100960:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100964:	88 44 24 24          	mov    %al,0x24(%esp)
  100968:	eb 27                	jmp    100991 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10096a:	84 c0                	test   %al,%al
  10096c:	75 02                	jne    100970 <console_vprintf+0x1d9>
  10096e:	b0 25                	mov    $0x25,%al
  100970:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100974:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100979:	80 3f 00             	cmpb   $0x0,(%edi)
  10097c:	74 0a                	je     100988 <console_vprintf+0x1f1>
  10097e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100982:	89 44 24 04          	mov    %eax,0x4(%esp)
  100986:	eb 09                	jmp    100991 <console_vprintf+0x1fa>
				format--;
  100988:	8d 54 24 24          	lea    0x24(%esp),%edx
  10098c:	4f                   	dec    %edi
  10098d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100991:	31 d2                	xor    %edx,%edx
  100993:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100995:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100997:	83 fd ff             	cmp    $0xffffffff,%ebp
  10099a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009a1:	74 1f                	je     1009c2 <console_vprintf+0x22b>
  1009a3:	89 04 24             	mov    %eax,(%esp)
  1009a6:	eb 01                	jmp    1009a9 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009a8:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009a9:	39 e9                	cmp    %ebp,%ecx
  1009ab:	74 0a                	je     1009b7 <console_vprintf+0x220>
  1009ad:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009b1:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009b5:	75 f1                	jne    1009a8 <console_vprintf+0x211>
  1009b7:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009ba:	89 0c 24             	mov    %ecx,(%esp)
  1009bd:	eb 1f                	jmp    1009de <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009bf:	42                   	inc    %edx
  1009c0:	eb 09                	jmp    1009cb <console_vprintf+0x234>
  1009c2:	89 d1                	mov    %edx,%ecx
  1009c4:	8b 14 24             	mov    (%esp),%edx
  1009c7:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009cb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009cf:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009d3:	75 ea                	jne    1009bf <console_vprintf+0x228>
  1009d5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009d9:	89 14 24             	mov    %edx,(%esp)
  1009dc:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009de:	85 c0                	test   %eax,%eax
  1009e0:	74 0c                	je     1009ee <console_vprintf+0x257>
  1009e2:	84 d2                	test   %dl,%dl
  1009e4:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009eb:	00 
  1009ec:	75 24                	jne    100a12 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009ee:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009f3:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1009fa:	00 
  1009fb:	75 15                	jne    100a12 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1009fd:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a01:	83 e0 08             	and    $0x8,%eax
  100a04:	83 f8 01             	cmp    $0x1,%eax
  100a07:	19 c9                	sbb    %ecx,%ecx
  100a09:	f7 d1                	not    %ecx
  100a0b:	83 e1 20             	and    $0x20,%ecx
  100a0e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a12:	3b 2c 24             	cmp    (%esp),%ebp
  100a15:	7e 0d                	jle    100a24 <console_vprintf+0x28d>
  100a17:	84 d2                	test   %dl,%dl
  100a19:	74 40                	je     100a5b <console_vprintf+0x2c4>
			zeros = precision - len;
  100a1b:	2b 2c 24             	sub    (%esp),%ebp
  100a1e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a22:	eb 3f                	jmp    100a63 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a24:	84 d2                	test   %dl,%dl
  100a26:	74 33                	je     100a5b <console_vprintf+0x2c4>
  100a28:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a2c:	83 e0 06             	and    $0x6,%eax
  100a2f:	83 f8 02             	cmp    $0x2,%eax
  100a32:	75 27                	jne    100a5b <console_vprintf+0x2c4>
  100a34:	45                   	inc    %ebp
  100a35:	75 24                	jne    100a5b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a37:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a39:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a3c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a41:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a44:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a47:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a4b:	7d 0e                	jge    100a5b <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a4d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a51:	29 ca                	sub    %ecx,%edx
  100a53:	29 c2                	sub    %eax,%edx
  100a55:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a59:	eb 08                	jmp    100a63 <console_vprintf+0x2cc>
  100a5b:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a62:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a63:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a67:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a69:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a6d:	2b 2c 24             	sub    (%esp),%ebp
  100a70:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a75:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a78:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a7b:	29 c5                	sub    %eax,%ebp
  100a7d:	89 f0                	mov    %esi,%eax
  100a7f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a83:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a87:	eb 0f                	jmp    100a98 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a89:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a8d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a92:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a93:	e8 83 fc ff ff       	call   10071b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a98:	85 ed                	test   %ebp,%ebp
  100a9a:	7e 07                	jle    100aa3 <console_vprintf+0x30c>
  100a9c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100aa1:	74 e6                	je     100a89 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100aa3:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100aa8:	89 c6                	mov    %eax,%esi
  100aaa:	74 23                	je     100acf <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100aac:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ab1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ab5:	e8 61 fc ff ff       	call   10071b <console_putc>
  100aba:	89 c6                	mov    %eax,%esi
  100abc:	eb 11                	jmp    100acf <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100abe:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ac2:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ac7:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100ac8:	e8 4e fc ff ff       	call   10071b <console_putc>
  100acd:	eb 06                	jmp    100ad5 <console_vprintf+0x33e>
  100acf:	89 f0                	mov    %esi,%eax
  100ad1:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ad5:	85 f6                	test   %esi,%esi
  100ad7:	7f e5                	jg     100abe <console_vprintf+0x327>
  100ad9:	8b 34 24             	mov    (%esp),%esi
  100adc:	eb 15                	jmp    100af3 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ade:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100ae2:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100ae3:	0f b6 11             	movzbl (%ecx),%edx
  100ae6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aea:	e8 2c fc ff ff       	call   10071b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100aef:	ff 44 24 04          	incl   0x4(%esp)
  100af3:	85 f6                	test   %esi,%esi
  100af5:	7f e7                	jg     100ade <console_vprintf+0x347>
  100af7:	eb 0f                	jmp    100b08 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100af9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100afd:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b02:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b03:	e8 13 fc ff ff       	call   10071b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b08:	85 ed                	test   %ebp,%ebp
  100b0a:	7f ed                	jg     100af9 <console_vprintf+0x362>
  100b0c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b0e:	47                   	inc    %edi
  100b0f:	8a 17                	mov    (%edi),%dl
  100b11:	84 d2                	test   %dl,%dl
  100b13:	0f 85 96 fc ff ff    	jne    1007af <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b19:	83 c4 38             	add    $0x38,%esp
  100b1c:	89 f0                	mov    %esi,%eax
  100b1e:	5b                   	pop    %ebx
  100b1f:	5e                   	pop    %esi
  100b20:	5f                   	pop    %edi
  100b21:	5d                   	pop    %ebp
  100b22:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b23:	81 e9 78 0b 10 00    	sub    $0x100b78,%ecx
  100b29:	b8 01 00 00 00       	mov    $0x1,%eax
  100b2e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b30:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b31:	09 44 24 14          	or     %eax,0x14(%esp)
  100b35:	e9 aa fc ff ff       	jmp    1007e4 <console_vprintf+0x4d>

00100b3a <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b3a:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b3e:	50                   	push   %eax
  100b3f:	ff 74 24 10          	pushl  0x10(%esp)
  100b43:	ff 74 24 10          	pushl  0x10(%esp)
  100b47:	ff 74 24 10          	pushl  0x10(%esp)
  100b4b:	e8 47 fc ff ff       	call   100797 <console_vprintf>
  100b50:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b53:	c3                   	ret    
