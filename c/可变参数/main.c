#include <stdio.h>
#include <stdarg.h>

void mutil_parameter_delive(int num,...)
{

	va_list valist;
	int i;
	int access;

	/* 为 num 个参数初始化 valist */
	va_start(valist, num);

	/* 访问赋给 valist 的参数 */
	access = va_arg(valist, int);
	printf("%d\n", access);
     
	/* 访问下一个参数 */
	access = va_arg(valist, int);
	printf("%d\n", access);

	/* 访问下一个参数 */
	access = va_arg(valist, int);
	printf("%d\n", access);

	/* 可以继续访问下去,但是结果未知 因为只传递了三个int参数5 10 15*/
	access = va_arg(valist, int);
	printf("%d\n", access);

	/* 清理为 valist 保留的内存 */
	va_end(valist);
}
	
void main() {
	mutil_parameter_delive(3, 5,10,15);
} 
