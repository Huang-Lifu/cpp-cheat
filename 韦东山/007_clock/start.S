/* 编写时钟频率 */
.text 
.global _start

/* start函数 */
_start:
	/* 关闭看门狗 */
	/* s3c2440 手册第463页 */
	ldr r0, =0x53000000
	ldr r1, =0
	str r1, [r0]

	/* 设置Mpll控制寄存器 */
	ldr r0, =0x4c000004
	ldr r1, =0x0005c011
	ldr r1, [r0]
	
	/* 设置LOCKTIME寄存器 */
	ldr r0, =0x4c000000
	ldr r1, =0xffffffff
	ldr r1, [r0]

	/* 设置HDIVN PDIVN控制寄存器 */
	ldr r0, =0x4c000014
	ldr r1, =(1<<2)|(1<<0)
	ldr r1, [r0]

	/* 将cpu总线模式从 fast bus mode改为异步总线模式 */
	mrc p15,0,r0,c1,c0,0
	orr r0,r0,#0x00000000
	mcr p15,0,r0,c1,c0,0

	/* 分辨是从nor/nand启动 */
	/* nor不可写 nand装载到sdram后可写*/
	ldr r0, =0
	ldr r1, [r0]
	ldr r2, =80
	str r2, [r0]
	ldr r3, [r0]
	cmp r1, r3
	ldr sp, =0x40000000+4096	/* nor 启动 */
	moveq sp, #4096 		/* nand 启动, r0被修改,值等于r2 */
	streq r1, [r0]

	bl main
halt:
	b halt
