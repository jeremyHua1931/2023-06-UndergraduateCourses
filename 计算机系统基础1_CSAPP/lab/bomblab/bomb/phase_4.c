[]
[]
[]   rcx  0xc(%rsp)
[]   rdx  0x8(%rsp)
[]
[]

if(eax!=2)
{

     if(rdx<=15)
     {
        
         esi=0;
         edi=rdx;

         fun4(edx,esi,edi)   //  esi= 0  edx=14  %edi=%rsp+8
         {
             []    //sub    $0x8,%rsp

             eax=edx;
             eax=eax-esi;  
              //eax=edx-esi
             ecx=eax;       
             ecx=ecx>>31;  // logic  //0
             //ecx=edx-esi
             eax=eax+ecx;   
             eax=eax>>1;//Ath   
             //eax=(edx-esi)  +  (edx-esi)>>31
             //eax=eax>>1
             ecx=rax+rsi;    
             //ecx=eax + esi;
             //ecx= ((edx-esi)  +  (edx-esi)>>31))/2  +esi
              
           if(ecx>edi)
           {
               edx=rcx-1;
               fun4(edx,esi,edi);
               eax=2*eax+1;
               return ;
           }
           else
           {
               eax=0;
               if(ecx<edi)
               {
                   esi=rcx+1;
                   fun4(edx,esi,edi);
                   eax=2*rax+1;
               }
               else
               {
                   return ;
               }
           }
         }


         if(eax=0)
         {
             explode_bomb;
         }

         if(rdx=0)    //rdx=0xc(%rsp) 
           return;
         else 
           explode_bomb;    //rdx=0;
     }
     else
     {
         explode_bomb;
     }
}
else
{
    explode_bomb;
}