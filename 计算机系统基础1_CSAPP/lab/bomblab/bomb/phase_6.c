
for(int i=0;i<6;i++)
{
   if(nums[i]-1>5)
        explode_bomb();
    
    for(int k=i+1;k<=5;k++)
    {
        if(num[k]==nums[i])
            explode_bomb();
    }
}