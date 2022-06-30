void test()
{ 
	int val;/* Put canary on stack to detect possible corruption */ 
    volatile int local = uniqueval();

	val = getbuf();/* Check for corrupted stack */
	
	if (local != uniqueval())
	{
		printf("Sabotaged!: the stack has been corrupted\n");
    } 
    else if (val == cookie) 
    {
        printf("Boom!: getbuf returned 0x%x\n", val);
         validate(3);
    } 
    else 
    {
		printf("Dud: getbuf returned 0x%x\n", val);
	}
}

void smoke()
{
    printf("Smoke!: You called smoke()\n");
    validate(0);
    exit(0);
}