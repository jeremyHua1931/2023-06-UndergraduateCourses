  [] rbx
  [] rax ->0x18(%rsp)
  []
  []
  []  rsp
  
  rbx=rdi;

  eax=eax^eax; 

  if(eax!=6)
  {
      explode_bomb();
  }
  else   //eax=6
  {
      eax=0;
      ecx=*(rbx+rax);  //n=
      *rsp=cl;
      rdx=*rsp;

      edx=edx&1111;
      edx=*(rdx+0x4024b0);
      *(rsp+rax+0x10)=dl;
      
      if(rax=6)
      {
           explode_bomb;
      }
      else
      { 
          
         *(%rsp+0x16)=0;
         esi=0x40245;
         rdi=%rsp+0x10;

         call String();
         
         if(eax!=0)
         {
             explode_bomb();
         }
         else
         {
             rax=*(%rap+0x18);
             if(rax!=rax^0x28)
                callq _stack_chk_fail;
             else
             {
                rsp=rsp-16;
                //弹出&rbx,rsp 上移8的字节
                return ;
             }
         }
      }

  }