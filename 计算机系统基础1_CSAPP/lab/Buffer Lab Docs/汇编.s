08049284 <getbuf>:
 8049284:       55                      push   %ebp
 8049285:       89 e5                   mov    %esp,%ebp
 8049287:       83 ec 38                sub    $0x38,%esp
 804928a:       8d 45 d8                lea    -0x28(%ebp),%eax
 804928d:       89 04 24                mov    %eax,(%esp)
 8049290:       e8 d1 fa ff ff          call   8048d66 <Gets>
 8049295:       b8 01 00 00 00          mov    $0x1,%eax
 804929a:       c9                      leave
 804929b:       c3 

 08048b2e <fizz>:
 8048b2e:       55                      push   %ebp
 8048b2f:       89 e5                   mov    %esp,%ebp
 8048b31:       83 ec 18                sub    $0x18,%esp
 8048b34:       8b 55 08                mov    0x8(%ebp),%edx
 8048b37:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048b3c:       39 c2                   cmp    %eax,%edx
 8048b3e:       75 22                   jne    8048b62 <fizz+0x34>
 8048b40:       b8 cb a5 04 08          mov    $0x804a5cb,%eax
 8048b45:       8b 55 08                mov    0x8(%ebp),%edx
 8048b48:       89 54 24 04             mov    %edx,0x4(%esp)
 8048b4c:       89 04 24                mov    %eax,(%esp)
 8048b4f:       e8 dc fc ff ff          call   8048830 <printf@plt>
 8048b54:       c7 04 24 01 00 00 00    movl   $0x1,(%esp)
 8048b5b:       e8 ce 08 00 00          call   804942e <validate>
 8048b60:       eb 14                   jmp    8048b76 <fizz+0x48>
 8048b62:       b8 ec a5 04 08          mov    $0x804a5ec,%eax
 8048b67:       8b 55 08                mov    0x8(%ebp),%edx
 8048b6a:       89 54 24 04             mov    %edx,0x4(%esp)
 8048b6e:       89 04 24                mov    %eax,(%esp)
 8048b71:       e8 ba fc ff ff          call   8048830 <printf@plt>
 8048b76:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048b7d:       e8 9e fd ff ff          call   8048920 <exit@plt>

 08048b82 <bang>:
 8048b82:       55                      push   %ebp
 8048b83:       89 e5                   mov    %esp,%ebp
 8048b85:       83 ec 18                sub    $0x18,%esp
 8048b88:       a1 0c e1 04 08          mov    0x804e10c,%eax
 8048b8d:       89 c2                   mov    %eax,%edx
 8048b8f:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048b94:       39 c2                   cmp    %eax,%edx
 8048b96:       75 25                   jne    8048bbd <bang+0x3b>
 8048b98:       8b 15 0c e1 04 08       mov    0x804e10c,%edx
 8048b9e:       b8 0c a6 04 08          mov    $0x804a60c,%eax
 8048ba3:       89 54 24 04             mov    %edx,0x4(%esp)
 8048ba7:       89 04 24                mov    %eax,(%esp)
 8048baa:       e8 81 fc ff ff          call   8048830 <printf@plt>
 8048baf:       c7 04 24 02 00 00 00    movl   $0x2,(%esp)
 8048bb6:       e8 73 08 00 00          call   804942e <validate>
 8048bbb:       eb 17                   jmp    8048bd4 <bang+0x52>
 8048bbd:       8b 15 0c e1 04 08       mov    0x804e10c,%edx
 8048bc3:       b8 31 a6 04 08          mov    $0x804a631,%eax
 8048bc8:       89 54 24 04             mov    %edx,0x4(%esp)
 8048bcc:       89 04 24                mov    %eax,(%esp)
 8048bcf:       e8 5c fc ff ff          call   8048830 <printf@plt>
 8048bd4:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048bdb:       e8 40 fd ff ff          call   8048920 <exit@plt>



 bufbomb:     file format elf32-i386


Disassembly of section .init:

080487c4 <_init>:
 80487c4:       53                      push   %ebx
 80487c5:       83 ec 08                sub    $0x8,%esp
 80487c8:       e8 00 00 00 00          call   80487cd <_init+0x9>
 80487cd:       5b                      pop    %ebx
 80487ce:       81 c3 27 48 00 00       add    $0x4827,%ebx
 80487d4:       8b 83 fc ff ff ff       mov    -0x4(%ebx),%eax
 80487da:       85 c0                   test   %eax,%eax
 80487dc:       74 05                   je     80487e3 <_init+0x1f>
 80487de:       e8 2d 01 00 00          call   8048910 <__gmon_start__@plt>
 80487e3:       e8 f8 02 00 00          call   8048ae0 <frame_dummy>
 80487e8:       e8 73 1d 00 00          call   804a560 <__do_global_ctors_aux>
 80487ed:       83 c4 08                add    $0x8,%esp
 80487f0:       5b                      pop    %ebx
 80487f1:       c3                      ret

 isassembly of section .plt:

08048800 <.plt>:
 8048800:       ff 35 f8 cf 04 08       pushl  0x804cff8
 8048806:       ff 25 fc cf 04 08       jmp    *0x804cffc
 804880c:       00 00                   add    %al,(%eax)
        ...

08048810 <read@plt>:
 8048810:       ff 25 00 d0 04 08       jmp    *0x804d000
 8048816:       68 00 00 00 00          push   $0x0
 804881b:       e9 e0 ff ff ff          jmp    8048800 <.plt>

08048820 <srandom@plt>:
 8048820:       ff 25 04 d0 04 08       jmp    *0x804d004
 8048826:       68 08 00 00 00          push   $0x8
 804882b:       e9 d0 ff ff ff          jmp    8048800 <.plt>

08048830 <printf@plt>:
 8048830:       ff 25 08 d0 04 08       jmp    *0x804d008
 8048836:       68 10 00 00 00          push   $0x10
 804883b:       e9 c0 ff ff ff          jmp    8048800 <.plt>

08048840 <strdup@plt>:
 8048840:       ff 25 0c d0 04 08       jmp    *0x804d00c
 8048846:       68 18 00 00 00          push   $0x18
 804884b:       e9 b0 ff ff ff          jmp    8048800 <.plt>

 08048850 <memcpy@plt>:
 8048850:       ff 25 10 d0 04 08       jmp    *0x804d010
 8048856:       68 20 00 00 00          push   $0x20
 804885b:       e9 a0 ff ff ff          jmp    8048800 <.plt>

08048860 <signal@plt>:
 8048860:       ff 25 14 d0 04 08       jmp    *0x804d014
 8048866:       68 28 00 00 00          push   $0x28
 804886b:       e9 90 ff ff ff          jmp    8048800 <.plt>

08048870 <alarm@plt>:
 8048870:       ff 25 18 d0 04 08       jmp    *0x804d018
 8048876:       68 30 00 00 00          push   $0x30
 804887b:       e9 80 ff ff ff          jmp    8048800 <.plt>

08048880 <__stack_chk_fail@plt>:
 8048880:       ff 25 1c d0 04 08       jmp    *0x804d01c
 8048886:       68 38 00 00 00          push   $0x38
 804888b:       e9 70 ff ff ff          jmp    8048800 <.plt>

08048890 <_IO_getc@plt>:
 8048890:       ff 25 20 d0 04 08       jmp    *0x804d020
 8048896:       68 40 00 00 00          push   $0x40
 804889b:       e9 60 ff ff ff          jmp    8048800 <.plt>

 080488a0 <htons@plt>:
 80488a0:       ff 25 24 d0 04 08       jmp    *0x804d024
 80488a6:       68 48 00 00 00          push   $0x48
 80488ab:       e9 50 ff ff ff          jmp    8048800 <.plt>

080488b0 <fwrite@plt>:
 80488b0:       ff 25 28 d0 04 08       jmp    *0x804d028
 80488b6:       68 50 00 00 00          push   $0x50
 80488bb:       e9 40 ff ff ff          jmp    8048800 <.plt>

080488c0 <bcopy@plt>:
 80488c0:       ff 25 2c d0 04 08       jmp    *0x804d02c
 80488c6:       68 58 00 00 00          push   $0x58
 80488cb:       e9 30 ff ff ff          jmp    8048800 <.plt>

080488d0 <strcpy@plt>:
 80488d0:       ff 25 30 d0 04 08       jmp    *0x804d030
 80488d6:       68 60 00 00 00          push   $0x60
 80488db:       e9 20 ff ff ff          jmp    8048800 <.plt>


 080488e0 <getpid@plt>:
 80488e0:       ff 25 34 d0 04 08       jmp    *0x804d034
 80488e6:       68 68 00 00 00          push   $0x68
 80488eb:       e9 10 ff ff ff          jmp    8048800 <.plt>

080488f0 <gethostname@plt>:
 80488f0:       ff 25 38 d0 04 08       jmp    *0x804d038
 80488f6:       68 70 00 00 00          push   $0x70
 80488fb:       e9 00 ff ff ff          jmp    8048800 <.plt>

08048900 <puts@plt>:
 8048900:       ff 25 3c d0 04 08       jmp    *0x804d03c
 8048906:       68 78 00 00 00          push   $0x78
 804890b:       e9 f0 fe ff ff          jmp    8048800 <.plt>

08048910 <__gmon_start__@plt>:
 8048910:       ff 25 40 d0 04 08       jmp    *0x804d040
 8048916:       68 80 00 00 00          push   $0x80
 804891b:       e9 e0 fe ff ff          jmp    8048800 <.plt>

08048920 <exit@plt>:
 8048920:       ff 25 44 d0 04 08       jmp    *0x804d044
 8048926:       68 88 00 00 00          push   $0x88
 804892b:       e9 d0 fe ff ff          jmp    8048800 <.plt>


 08048930 <srand@plt>:
 8048930:       ff 25 48 d0 04 08       jmp    *0x804d048
 8048936:       68 90 00 00 00          push   $0x90
 804893b:       e9 c0 fe ff ff          jmp    8048800 <.plt>

08048940 <mmap@plt>:
 8048940:       ff 25 4c d0 04 08       jmp    *0x804d04c
 8048946:       68 98 00 00 00          push   $0x98
 804894b:       e9 b0 fe ff ff          jmp    8048800 <.plt>

08048950 <__libc_start_main@plt>:
 8048950:       ff 25 50 d0 04 08       jmp    *0x804d050
 8048956:       68 a0 00 00 00          push   $0xa0
 804895b:       e9 a0 fe ff ff          jmp    8048800 <.plt>

08048960 <write@plt>:
 8048960:       ff 25 54 d0 04 08       jmp    *0x804d054
 8048966:       68 a8 00 00 00          push   $0xa8
 804896b:       e9 90 fe ff ff          jmp    8048800 <.plt>

08048970 <getopt@plt>:
 8048970:       ff 25 58 d0 04 08       jmp    *0x804d058
 8048976:       68 b0 00 00 00          push   $0xb0
 804897b:       e9 80 fe ff ff          jmp    8048800 <.plt>

08048980 <strcasecmp@plt>:
 8048980:       ff 25 5c d0 04 08       jmp    *0x804d05c
 8048986:       68 b8 00 00 00          push   $0xb8
 804898b:       e9 70 fe ff ff          jmp    8048800 <.plt>



 08048990 <__isoc99_sscanf@plt>:
 8048990:       ff 25 60 d0 04 08       jmp    *0x804d060
 8048996:       68 c0 00 00 00          push   $0xc0
 804899b:       e9 60 fe ff ff          jmp    8048800 <.plt>

080489a0 <memset@plt>:
 80489a0:       ff 25 64 d0 04 08       jmp    *0x804d064
 80489a6:       68 c8 00 00 00          push   $0xc8
 80489ab:       e9 50 fe ff ff          jmp    8048800 <.plt>

080489b0 <__errno_location@plt>:
 80489b0:       ff 25 68 d0 04 08       jmp    *0x804d068
 80489b6:       68 d0 00 00 00          push   $0xd0
 80489bb:       e9 40 fe ff ff          jmp    8048800 <.plt>

080489c0 <rand@plt>:
 80489c0:       ff 25 6c d0 04 08       jmp    *0x804d06c
 80489c6:       68 d8 00 00 00          push   $0xd8
 80489cb:       e9 30 fe ff ff          jmp    8048800 <.plt>

080489d0 <munmap@plt>:
 80489d0:       ff 25 70 d0 04 08       jmp    *0x804d070
 80489d6:       68 e0 00 00 00          push   $0xe0
 80489db:       e9 20 fe ff ff          jmp    8048800 <.plt>


 080489e0 <sprintf@plt>:
 80489e0:       ff 25 74 d0 04 08       jmp    *0x804d074
 80489e6:       68 e8 00 00 00          push   $0xe8
 80489eb:       e9 10 fe ff ff          jmp    8048800 <.plt>

080489f0 <socket@plt>:
 80489f0:       ff 25 78 d0 04 08       jmp    *0x804d078
 80489f6:       68 f0 00 00 00          push   $0xf0
 80489fb:       e9 00 fe ff ff          jmp    8048800 <.plt>

08048a00 <random@plt>:
 8048a00:       ff 25 7c d0 04 08       jmp    *0x804d07c
 8048a06:       68 f8 00 00 00          push   $0xf8
 8048a0b:       e9 f0 fd ff ff          jmp    8048800 <.plt>

08048a10 <gethostbyname@plt>:
 8048a10:       ff 25 80 d0 04 08       jmp    *0x804d080
 8048a16:       68 00 01 00 00          push   $0x100
 8048a1b:       e9 e0 fd ff ff          jmp    8048800 <.plt>

08048a20 <connect@plt>:
 8048a20:       ff 25 84 d0 04 08       jmp    *0x804d084
 8048a26:       68 08 01 00 00          push   $0x108
 8048a2b:       e9 d0 fd ff ff          jmp    8048800 <.plt>


 Disassembly of section .text:

08048a50 <_start>:
 8048a50:       31 ed                   xor    %ebp,%ebp
 8048a52:       5e                      pop    %esi
 8048a53:       89 e1                   mov    %esp,%ecx
 8048a55:       83 e4 f0                and    $0xfffffff0,%esp
 8048a58:       50                      push   %eax
 8048a59:       54                      push   %esp
 8048a5a:       52                      push   %edx
 8048a5b:       68 50 a5 04 08          push   $0x804a550
 8048a60:       68 e0 a4 04 08          push   $0x804a4e0
 8048a65:       51                      push   %ecx
 8048a66:       56                      push   %esi
 8048a67:       68 3d 90 04 08          push   $0x804903d
 8048a6c:       e8 df fe ff ff          call   8048950 <__libc_start_main@plt>
 8048a71:       f4                      hlt
 8048a72:       90                      nop
 8048a73:       90                      nop
 8048a74:       90                      nop
 8048a75:       90                      nop
 8048a76:       90                      nop
 8048a77:       90                      nop
 8048a78:       90                      nop
 8048a79:       90                      nop
 8048a7a:       90                      nop
 8048a7b:       90                      nop
 8048a7c:       90                      nop
 8048a7d:       90                      nop
 8048a7e:       90                      nop
 8048a7f:       90                      nop


 08048a80 <__do_global_dtors_aux>:
 8048a80:       55                      push   %ebp
 8048a81:       89 e5                   mov    %esp,%ebp
 8048a83:       53                      push   %ebx
 8048a84:       83 ec 04                sub    $0x4,%esp
 8048a87:       80 3d ec e0 04 08 00    cmpb   $0x0,0x804e0ec
 8048a8e:       75 3f                   jne    8048acf <__do_global_dtors_aux+0x4f>
 8048a90:       a1 f0 e0 04 08          mov    0x804e0f0,%eax
 8048a95:       bb 20 cf 04 08          mov    $0x804cf20,%ebx
 8048a9a:       81 eb 1c cf 04 08       sub    $0x804cf1c,%ebx
 8048aa0:       c1 fb 02                sar    $0x2,%ebx
 8048aa3:       83 eb 01                sub    $0x1,%ebx
 8048aa6:       39 d8                   cmp    %ebx,%eax
 8048aa8:       73 1e                   jae    8048ac8 <__do_global_dtors_aux+0x48>
 8048aaa:       8d b6 00 00 00 00       lea    0x0(%esi),%esi
 8048ab0:       83 c0 01                add    $0x1,%eax
 8048ab3:       a3 f0 e0 04 08          mov    %eax,0x804e0f0
 8048ab8:       ff 14 85 1c cf 04 08    call   *0x804cf1c(,%eax,4)
 8048abf:       a1 f0 e0 04 08          mov    0x804e0f0,%eax
 8048ac4:       39 d8                   cmp    %ebx,%eax
 8048ac6:       72 e8                   jb     8048ab0 <__do_global_dtors_aux+0x30>
 8048ac8:       c6 05 ec e0 04 08 01    movb   $0x1,0x804e0ec
 8048acf:       83 c4 04                add    $0x4,%esp
 8048ad2:       5b                      pop    %ebx
 8048ad3:       5d                      pop    %ebp
 8048ad4:       c3                      ret
 8048ad5:       8d 74 26 00             lea    0x0(%esi,%eiz,1),%esi
 8048ad9:       8d bc 27 00 00 00 00    lea    0x0(%edi,%eiz,1),%edi

08048ae0 <frame_dummy>:
 8048ae0:       55                      push   %ebp
 8048ae1:       89 e5                   mov    %esp,%ebp
 8048ae3:       83 ec 18                sub    $0x18,%esp
 8048ae6:       a1 24 cf 04 08          mov    0x804cf24,%eax
 8048aeb:       85 c0                   test   %eax,%eax
 8048aed:       74 12                   je     8048b01 <frame_dummy+0x21>
 8048aef:       b8 00 00 00 00          mov    $0x0,%eax
 8048af4:       85 c0                   test   %eax,%eax
 8048af6:       74 09                   je     8048b01 <frame_dummy+0x21>
 8048af8:       c7 04 24 24 cf 04 08    movl   $0x804cf24,(%esp)
 8048aff:       ff d0                   call   *%eax
 8048b01:       c9                      leave
 8048b02:       c3                      ret
 8048b03:       90                      nop

 08048b04 <smoke>:
 8048b04:       55                      push   %ebp
 8048b05:       89 e5                   mov    %esp,%ebp
 8048b07:       83 ec 18                sub    $0x18,%esp
 8048b0a:       c7 04 24 b0 a5 04 08    movl   $0x804a5b0,(%esp)
 8048b11:       e8 ea fd ff ff          call   8048900 <puts@plt>
 8048b16:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048b1d:       e8 0c 09 00 00          call   804942e <validate>
 8048b22:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048b29:       e8 f2 fd ff ff          call   8048920 <exit@plt>

 08048b2e <fizz>:
 8048b2e:       55                      push   %ebp  
 8048b2f:       89 e5                   mov    %esp,%ebp
 8048b31:       83 ec 18                sub    $0x18,%esp
 8048b34:       8b 55 08                mov    0x8(%ebp),%edx
 8048b37:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048b3c:       39 c2                   cmp    %eax,%edx
 8048b3e:       75 22                   jne    8048b62 <fizz+0x34>
 8048b40:       b8 cb a5 04 08          mov    $0x804a5cb,%eax
 8048b45:       8b 55 08                mov    0x8(%ebp),%edx
 8048b48:       89 54 24 04             mov    %edx,0x4(%esp)
 8048b4c:       89 04 24                mov    %eax,(%esp)
 8048b4f:       e8 dc fc ff ff          call   8048830 <printf@plt>
 8048b54:       c7 04 24 01 00 00 00    movl   $0x1,(%esp)
 8048b5b:       e8 ce 08 00 00          call   804942e <validate>
 8048b60:       eb 14                   jmp    8048b76 <fizz+0x48>
 8048b62:       b8 ec a5 04 08          mov    $0x804a5ec,%eax
 8048b67:       8b 55 08                mov    0x8(%ebp),%edx
 8048b6a:       89 54 24 04             mov    %edx,0x4(%esp)
 8048b6e:       89 04 24                mov    %eax,(%esp)
 8048b71:       e8 ba fc ff ff          call   8048830 <printf@plt>
 8048b76:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048b7d:       e8 9e fd ff ff          call   8048920 <exit@plt>

 08048b82 <bang>:
 8048b82:       55                      push   %ebp
 8048b83:       89 e5                   mov    %esp,%ebp
 8048b85:       83 ec 18                sub    $0x18,%esp
 8048b88:       a1 0c e1 04 08          mov    0x804e10c,%eax
 8048b8d:       89 c2                   mov    %eax,%edx
 8048b8f:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048b94:       39 c2                   cmp    %eax,%edx
 8048b96:       75 25                   jne    8048bbd <bang+0x3b>
 8048b98:       8b 15 0c e1 04 08       mov    0x804e10c,%edx
 8048b9e:       b8 0c a6 04 08          mov    $0x804a60c,%eax
 8048ba3:       89 54 24 04             mov    %edx,0x4(%esp)
 8048ba7:       89 04 24                mov    %eax,(%esp)
 8048baa:       e8 81 fc ff ff          call   8048830 <printf@plt>
 8048baf:       c7 04 24 02 00 00 00    movl   $0x2,(%esp)
 8048bb6:       e8 73 08 00 00          call   804942e <validate>
 8048bbb:       eb 17                   jmp    8048bd4 <bang+0x52>
 8048bbd:       8b 15 0c e1 04 08       mov    0x804e10c,%edx
 8048bc3:       b8 31 a6 04 08          mov    $0x804a631,%eax
 8048bc8:       89 54 24 04             mov    %edx,0x4(%esp)
 8048bcc:       89 04 24                mov    %eax,(%esp)
 8048bcf:       e8 5c fc ff ff          call   8048830 <printf@plt>
 8048bd4:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048bdb:       e8 40 fd ff ff          call   8048920 <exit@plt>

 08048be0 <test>:
 8048be0:       55                      push   %ebp
 8048be1:       89 e5                   mov    %esp,%ebp
 8048be3:       83 ec 28                sub    $0x28,%esp
 8048be6:       e8 38 04 00 00          call   8049023 <uniqueval>
 8048beb:       89 45 f0                mov    %eax,-0x10(%ebp)
 8048bee:       e8 91 06 00 00          call   8049284 <getbuf>
 8048bf3:       89 45 f4                mov    %eax,-0xc(%ebp)
 8048bf6:       e8 28 04 00 00          call   8049023 <uniqueval>
 8048bfb:       8b 55 f0                mov    -0x10(%ebp),%edx
 8048bfe:       39 d0                   cmp    %edx,%eax
 8048c00:       74 0e                   je     8048c10 <test+0x30>
 8048c02:       c7 04 24 50 a6 04 08    movl   $0x804a650,(%esp)
 8048c09:       e8 f2 fc ff ff          call   8048900 <puts@plt>
 8048c0e:       eb 42                   jmp    8048c52 <test+0x72>
 8048c10:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048c13:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048c18:       39 c2                   cmp    %eax,%edx
 8048c1a:       75 22                   jne    8048c3e <test+0x5e>
 8048c1c:       b8 79 a6 04 08          mov    $0x804a679,%eax
 8048c21:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048c24:       89 54 24 04             mov    %edx,0x4(%esp)
 8048c28:       89 04 24                mov    %eax,(%esp)
 8048c2b:       e8 00 fc ff ff          call   8048830 <printf@plt>
 8048c30:       c7 04 24 03 00 00 00    movl   $0x3,(%esp)
 8048c37:       e8 f2 07 00 00          call   804942e <validate>
 8048c3c:       eb 14                   jmp    8048c52 <test+0x72>
 8048c3e:       b8 96 a6 04 08          mov    $0x804a696,%eax
 8048c43:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048c46:       89 54 24 04             mov    %edx,0x4(%esp)
 8048c4a:       89 04 24                mov    %eax,(%esp)
 8048c4d:       e8 de fb ff ff          call   8048830 <printf@plt>
 8048c52:       c9                      leave
 8048c53:       c3                      ret

 
08048c54 <testn>:
 8048c54:       55                      push   %ebp
 8048c55:       89 e5                   mov    %esp,%ebp
 8048c57:       83 ec 28                sub    $0x28,%esp
 8048c5a:       e8 c4 03 00 00          call   8049023 <uniqueval>
 8048c5f:       89 45 f0                mov    %eax,-0x10(%ebp)
 8048c62:       e8 35 06 00 00          call   804929c <getbufn>
 8048c67:       89 45 f4                mov    %eax,-0xc(%ebp)
 8048c6a:       e8 b4 03 00 00          call   8049023 <uniqueval>
 8048c6f:       8b 55 f0                mov    -0x10(%ebp),%edx
 8048c72:       39 d0                   cmp    %edx,%eax
 8048c74:       74 0e                   je     8048c84 <testn+0x30>
 8048c76:       c7 04 24 50 a6 04 08    movl   $0x804a650,(%esp)
 8048c7d:       e8 7e fc ff ff          call   8048900 <puts@plt>
 8048c82:       eb 42                   jmp    8048cc6 <testn+0x72>
 8048c84:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048c87:       a1 04 e1 04 08          mov    0x804e104,%eax
 8048c8c:       39 c2                   cmp    %eax,%edx
 8048c8e:       75 22                   jne    8048cb2 <testn+0x5e>
 8048c90:       b8 b4 a6 04 08          mov    $0x804a6b4,%eax
 8048c95:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048c98:       89 54 24 04             mov    %edx,0x4(%esp)
 8048c9c:       89 04 24                mov    %eax,(%esp)
 8048c9f:       e8 8c fb ff ff          call   8048830 <printf@plt>
 8048ca4:       c7 04 24 04 00 00 00    movl   $0x4,(%esp)
 8048cab:       e8 7e 07 00 00          call   804942e <validate>
 8048cb0:       eb 14                   jmp    8048cc6 <testn+0x72>
 8048cb2:       b8 d4 a6 04 08          mov    $0x804a6d4,%eax
 8048cb7:       8b 55 f4                mov    -0xc(%ebp),%edx
 8048cba:       89 54 24 04             mov    %edx,0x4(%esp)
 8048cbe:       89 04 24                mov    %eax,(%esp)
 8048cc1:       e8 6a fb ff ff          call   8048830 <printf@plt>
 8048cc6:       c9                      leave
 8048cc7:       c3                      ret

08048cc8 <save_char>:
 8048cc8:       55                      push   %ebp
 8048cc9:       89 e5                   mov    %esp,%ebp
 8048ccb:       83 ec 04                sub    $0x4,%esp
 8048cce:       8b 45 08                mov    0x8(%ebp),%eax
 8048cd1:       88 45 fc                mov    %al,-0x4(%ebp)
 8048cd4:       a1 10 e1 04 08          mov    0x804e110,%eax
 8048cd9:       3d ff 03 00 00          cmp    $0x3ff,%eax
 8048cde:       7f 6c                   jg     8048d4c <save_char+0x84>
 8048ce0:       8b 15 10 e1 04 08       mov    0x804e110,%edx
 8048ce6:       89 d0                   mov    %edx,%eax
 8048ce8:       01 c0                   add    %eax,%eax
 8048cea:       01 c2                   add    %eax,%edx
 8048cec:       0f b6 45 fc             movzbl -0x4(%ebp),%eax
 8048cf0:       c0 f8 04                sar    $0x4,%al
 8048cf3:       0f be c0                movsbl %al,%eax
 8048cf6:       83 e0 0f                and    $0xf,%eax
 8048cf9:       0f b6 80 a8 d0 04 08    movzbl 0x804d0a8(%eax),%eax
 8048d00:       88 82 40 e1 04 08       mov    %al,0x804e140(%edx)
 8048d06:       8b 15 10 e1 04 08       mov    0x804e110,%edx
 8048d0c:       89 d0                   mov    %edx,%eax
 8048d0e:       01 c0                   add    %eax,%eax
 8048d10:       01 d0                   add    %edx,%eax
 8048d12:       8d 50 01                lea    0x1(%eax),%edx
 8048d15:       0f be 45 fc             movsbl -0x4(%ebp),%eax
 8048d19:       83 e0 0f                and    $0xf,%eax
 8048d1c:       0f b6 80 a8 d0 04 08    movzbl 0x804d0a8(%eax),%eax
 8048d23:       88 82 40 e1 04 08       mov    %al,0x804e140(%edx)
 8048d29:       8b 15 10 e1 04 08       mov    0x804e110,%edx
 8048d2f:       89 d0                   mov    %edx,%eax
 8048d31:       01 c0                   add    %eax,%eax
 8048d33:       01 d0                   add    %edx,%eax
 8048d35:       83 c0 02                add    $0x2,%eax
 8048d38:       c6 80 40 e1 04 08 20    movb   $0x20,0x804e140(%eax)
 8048d3f:       a1 10 e1 04 08          mov    0x804e110,%eax
 8048d44:       83 c0 01                add    $0x1,%eax
 8048d47:       a3 10 e1 04 08          mov    %eax,0x804e110
 8048d4c:       c9                      leave
 8048d4d:       c3                      ret

 08048d4e <save_term>:
 8048d4e:       55                      push   %ebp
 8048d4f:       89 e5                   mov    %esp,%ebp
 8048d51:       8b 15 10 e1 04 08       mov    0x804e110,%edx
 8048d57:       89 d0                   mov    %edx,%eax
 8048d59:       01 c0                   add    %eax,%eax
 8048d5b:       01 d0                   add    %edx,%eax
 8048d5d:       c6 80 40 e1 04 08 00    movb   $0x0,0x804e140(%eax)
 8048d64:       5d                      pop    %ebp
 8048d65:       c3                      ret

08048d66 <Gets>:
 8048d66:       55                      push   %ebp
 8048d67:       89 e5                   mov    %esp,%ebp
 8048d69:       83 ec 28                sub    $0x28,%esp
 8048d6c:       8b 45 08                mov    0x8(%ebp),%eax
 8048d6f:       89 45 f0                mov    %eax,-0x10(%ebp)
 8048d72:       c7 05 10 e1 04 08 00    movl   $0x0,0x804e110
 8048d79:       00 00 00
 8048d7c:       eb 1c                   jmp    8048d9a <Gets+0x34>
 8048d7e:       8b 45 f4                mov    -0xc(%ebp),%eax
 8048d81:       89 c2                   mov    %eax,%edx
 8048d83:       8b 45 f0                mov    -0x10(%ebp),%eax
 8048d86:       88 10                   mov    %dl,(%eax)
 8048d88:       83 45 f0 01             addl   $0x1,-0x10(%ebp)
 8048d8c:       8b 45 f4                mov    -0xc(%ebp),%eax
 8048d8f:       0f be c0                movsbl %al,%eax
 8048d92:       89 04 24                mov    %eax,(%esp)
 8048d95:       e8 2e ff ff ff          call   8048cc8 <save_char>
 8048d9a:       a1 00 e1 04 08          mov    0x804e100,%eax
 8048d9f:       89 04 24                mov    %eax,(%esp)
 8048da2:       e8 e9 fa ff ff          call   8048890 <_IO_getc@plt>
 8048da7:       89 45 f4                mov    %eax,-0xc(%ebp)
 8048daa:       83 7d f4 ff             cmpl   $0xffffffff,-0xc(%ebp)
 8048dae:       74 06                   je     8048db6 <Gets+0x50>
 8048db0:       83 7d f4 0a             cmpl   $0xa,-0xc(%ebp)
 8048db4:       75 c8                   jne    8048d7e <Gets+0x18>
 8048db6:       8b 45 f0                mov    -0x10(%ebp),%eax
 8048db9:       c6 00 00                movb   $0x0,(%eax)
 8048dbc:       83 45 f0 01             addl   $0x1,-0x10(%ebp)
 8048dc0:       e8 89 ff ff ff          call   8048d4e <save_term>
 8048dc5:       8b 45 08                mov    0x8(%ebp),%eax
 8048dc8:       c9                      leave
 8048dc9:       c3                      ret


 08048dca <usage>:
 8048dca:       55                      push   %ebp
 8048dcb:       89 e5                   mov    %esp,%ebp
 8048dcd:       83 ec 18                sub    $0x18,%esp
 8048dd0:       b8 f0 a6 04 08          mov    $0x804a6f0,%eax
 8048dd5:       8b 55 08                mov    0x8(%ebp),%edx
 8048dd8:       89 54 24 04             mov    %edx,0x4(%esp)
 8048ddc:       89 04 24                mov    %eax,(%esp)
 8048ddf:       e8 4c fa ff ff          call   8048830 <printf@plt>
 8048de4:       c7 04 24 0e a7 04 08    movl   $0x804a70e,(%esp)
 8048deb:       e8 10 fb ff ff          call   8048900 <puts@plt>
 8048df0:       c7 04 24 24 a7 04 08    movl   $0x804a724,(%esp)
 8048df7:       e8 04 fb ff ff          call   8048900 <puts@plt>
 8048dfc:       c7 04 24 40 a7 04 08    movl   $0x804a740,(%esp)
 8048e03:       e8 f8 fa ff ff          call   8048900 <puts@plt>
 8048e08:       c7 04 24 7c a7 04 08    movl   $0x804a77c,(%esp)
 8048e0f:       e8 ec fa ff ff          call   8048900 <puts@plt>
 8048e14:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048e1b:       e8 00 fb ff ff          call   8048920 <exit@plt>

 08048e20 <bushandler>:
 8048e20:       55                      push   %ebp
 8048e21:       89 e5                   mov    %esp,%ebp
 8048e23:       83 ec 18                sub    $0x18,%esp
 8048e26:       c7 04 24 a4 a7 04 08    movl   $0x804a7a4,(%esp)
 8048e2d:       e8 ce fa ff ff          call   8048900 <puts@plt>
 8048e32:       c7 04 24 c4 a7 04 08    movl   $0x804a7c4,(%esp)
 8048e39:       e8 c2 fa ff ff          call   8048900 <puts@plt>
 8048e3e:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048e45:       e8 d6 fa ff ff          call   8048920 <exit@plt>

08048e4a <seghandler>:
 8048e4a:       55                      push   %ebp
 8048e4b:       89 e5                   mov    %esp,%ebp
 8048e4d:       83 ec 18                sub    $0x18,%esp
 8048e50:       c7 04 24 dc a7 04 08    movl   $0x804a7dc,(%esp)
 8048e57:       e8 a4 fa ff ff          call   8048900 <puts@plt>
 8048e5c:       c7 04 24 c4 a7 04 08    movl   $0x804a7c4,(%esp)
 8048e63:       e8 98 fa ff ff          call   8048900 <puts@plt>
 8048e68:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048e6f:       e8 ac fa ff ff          call   8048920 <exit@plt>

 08048e74 <illegalhandler>:
 8048e74:       55                      push   %ebp
 8048e75:       89 e5                   mov    %esp,%ebp
 8048e77:       83 ec 18                sub    $0x18,%esp
 8048e7a:       c7 04 24 04 a8 04 08    movl   $0x804a804,(%esp)
 8048e81:       e8 7a fa ff ff          call   8048900 <puts@plt>
 8048e86:       c7 04 24 c4 a7 04 08    movl   $0x804a7c4,(%esp)
 8048e8d:       e8 6e fa ff ff          call   8048900 <puts@plt>
 8048e92:       c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 8048e99:       e8 82 fa ff ff          call   8048920 <exit@plt>

 08048e9e <launch>:
 8048e9e:       55                      push   %ebp
 8048e9f:       89 e5                   mov    %esp,%ebp
 8048ea1:       83 ec 78                sub    $0x78,%esp
 8048ea4:       c7 45 f0 00 00 00 00    movl   $0x0,-0x10(%ebp)
 8048eab:       8d 45 b0                lea    -0x50(%ebp),%eax
 8048eae:       25 f0 3f 00 00          and    $0x3ff0,%eax
 8048eb3:       89 45 f0                mov    %eax,-0x10(%ebp)
 8048eb6:       8b 45 0c                mov    0xc(%ebp),%eax
 8048eb9:       03 45 f0                add    -0x10(%ebp),%eax
 8048ebc:       8d 50 0f                lea    0xf(%eax),%edx
 8048ebf:       b8 10 00 00 00          mov    $0x10,%eax
 8048ec4:       83 e8 01                sub    $0x1,%eax
 8048ec7:       01 d0                   add    %edx,%eax
 8048ec9:       c7 45 a4 10 00 00 00    movl   $0x10,-0x5c(%ebp)
 8048ed0:       ba 00 00 00 00          mov    $0x0,%edx
 8048ed5:       f7 75 a4                divl   -0x5c(%ebp)
 8048ed8:       6b c0 10                imul   $0x10,%eax,%eax
 8048edb:       29 c4                   sub    %eax,%esp
 8048edd:       8d 44 24 0c             lea    0xc(%esp),%eax
 8048ee1:       83 c0 0f                add    $0xf,%eax
 8048ee4:       c1 e8 04                shr    $0x4,%eax
 8048ee7:       c1 e0 04                shl    $0x4,%eax
 8048eea:       89 45 f4                mov    %eax,-0xc(%ebp)
 8048eed:       8b 45 f0                mov    -0x10(%ebp),%eax
 8048ef0:       89 44 24 08             mov    %eax,0x8(%esp)
 8048ef4:       c7 44 24 04 f4 00 00    movl   $0xf4,0x4(%esp)
 8048efb:       00
 8048efc:       8b 45 f4                mov    -0xc(%ebp),%eax
 8048eff:       89 04 24                mov    %eax,(%esp)
 8048f02:       e8 99 fa ff ff          call   80489a0 <memset@plt>
 8048f07:       b8 2f a8 04 08          mov    $0x804a82f,%eax
 8048f0c:       89 04 24                mov    %eax,(%esp)
 8048f0f:       e8 1c f9 ff ff          call   8048830 <printf@plt>
 8048f14:       83 7d 08 00             cmpl   $0x0,0x8(%ebp)
 8048f18:       74 07                   je     8048f21 <launch+0x83>
 8048f1a:       e8 35 fd ff ff          call   8048c54 <testn>
 8048f1f:       eb 05                   jmp    8048f26 <launch+0x88>
 8048f21:       e8 ba fc ff ff          call   8048be0 <test>
 8048f26:       a1 08 e1 04 08          mov    0x804e108,%eax
 8048f2b:       85 c0                   test   %eax,%eax
 8048f2d:       75 16                   jne    8048f45 <launch+0xa7>
 8048f2f:       c7 04 24 c4 a7 04 08    movl   $0x804a7c4,(%esp)
 8048f36:       e8 c5 f9 ff ff          call   8048900 <puts@plt>
 8048f3b:       c7 05 08 e1 04 08 00    movl   $0x0,0x804e108
 8048f42:       00 00 00
 8048f45:       c9                      leave
 8048f46:       c3                      ret

 08048f47 <launcher>:
 8048f47:       55                      push   %ebp
 8048f48:       89 e5                   mov    %esp,%ebp
 8048f4a:       83 ec 38                sub    $0x38,%esp
 8048f4d:       8b 45 08                mov    0x8(%ebp),%eax
 8048f50:       a3 14 e1 04 08          mov    %eax,0x804e114
 8048f55:       8b 45 0c                mov    0xc(%ebp),%eax
 8048f58:       a3 18 e1 04 08          mov    %eax,0x804e118
 8048f5d:       c7 44 24 14 00 00 00    movl   $0x0,0x14(%esp)
 8048f64:       00
 8048f65:       c7 44 24 10 00 00 00    movl   $0x0,0x10(%esp)
 8048f6c:       00
 8048f6d:       c7 44 24 0c 32 01 00    movl   $0x132,0xc(%esp)
 8048f74:       00
 8048f75:       c7 44 24 08 07 00 00    movl   $0x7,0x8(%esp)
 8048f7c:       00
 8048f7d:       c7 44 24 04 00 00 10    movl   $0x100000,0x4(%esp)
 8048f84:       00
 8048f85:       c7 04 24 00 60 58 55    movl   $0x55586000,(%esp)
 8048f8c:       e8 af f9 ff ff          call   8048940 <mmap@plt>
 8048f91:       89 45 f4                mov    %eax,-0xc(%ebp)
 8048f94:       81 7d f4 00 60 58 55    cmpl   $0x55586000,-0xc(%ebp)
 8048f9b:       74 34                   je     8048fd1 <launcher+0x8a>
 8048f9d:       a1 e0 e0 04 08          mov    0x804e0e0,%eax
 8048fa2:       89 c2                   mov    %eax,%edx
 8048fa4:       b8 3c a8 04 08          mov    $0x804a83c,%eax
 8048fa9:       89 54 24 0c             mov    %edx,0xc(%esp)
 8048fad:       c7 44 24 08 47 00 00    movl   $0x47,0x8(%esp)
 8048fb4:       00
 8048fb5:       c7 44 24 04 01 00 00    movl   $0x1,0x4(%esp)
 8048fbc:       00
 8048fbd:       89 04 24                mov    %eax,(%esp)
 8048fc0:       e8 eb f8 ff ff          call   80488b0 <fwrite@plt>
 8048fc5:       c7 04 24 01 00 00 00    movl   $0x1,(%esp)
 8048fcc:       e8 4f f9 ff ff          call   8048920 <exit@plt>
 8048fd1:       8b 45 f4                mov    -0xc(%ebp),%eax
 8048fd4:       05 f8 ff 0f 00          add    $0xffff8,%eax
 8048fd9:       a3 20 e1 04 08          mov    %eax,0x804e120
 8048fde:       8b 15 20 e1 04 08       mov    0x804e120,%edx
 8048fe4:       89 e0                   mov    %esp,%eax
 8048fe6:       89 d4                   mov    %edx,%esp
 8048fe8:       89 c2                   mov    %eax,%edx
 8048fea:       89 15 1c e1 04 08       mov    %edx,0x804e11c
 8048ff0:       8b 15 18 e1 04 08       mov    0x804e118,%edx
 8048ff6:       a1 14 e1 04 08          mov    0x804e114,%eax
 8048ffb:       89 54 24 04             mov    %edx,0x4(%esp)
 8048fff:       89 04 24                mov    %eax,(%esp)
 8049002:       e8 97 fe ff ff          call   8048e9e <launch>
 8049007:       a1 1c e1 04 08          mov    0x804e11c,%eax
 804900c:       89 c4                   mov    %eax,%esp
 804900e:       c7 44 24 04 00 00 10    movl   $0x100000,0x4(%esp)
 8049015:       00
 8049016:       8b 45 f4                mov    -0xc(%ebp),%eax
 8049019:       89 04 24                mov    %eax,(%esp)
 804901c:       e8 af f9 ff ff          call   80489d0 <munmap@plt>
 8049021:       c9                      leave
 8049022:       c3                      ret

 08049023 <uniqueval>:
 8049023:       55                      push   %ebp
 8049024:       89 e5                   mov    %esp,%ebp
 8049026:       83 ec 18                sub    $0x18,%esp
 8049029:       e8 b2 f8 ff ff          call   80488e0 <getpid@plt>
 804902e:       89 04 24                mov    %eax,(%esp)
 8049031:       e8 ea f7 ff ff          call   8048820 <srandom@plt>
 8049036:       e8 c5 f9 ff ff          call   8048a00 <random@plt>
 804903b:       c9                      leave
 804903c:       c3                      ret

 0804903d <main>:
 804903d:       55                      push   %ebp
 804903e:       89 e5                   mov    %esp,%ebp
 8049040:       53                      push   %ebx
 8049041:       83 e4 f0                and    $0xfffffff0,%esp
 8049044:       83 ec 30                sub    $0x30,%esp
 8049047:       c7 44 24 24 00 00 00    movl   $0x0,0x24(%esp)
 804904e:       00
 804904f:       c7 44 24 18 00 00 00    movl   $0x0,0x18(%esp)
 8049056:       00
 8049057:       c7 44 24 20 01 00 00    movl   $0x1,0x20(%esp)
 804905e:       00
 804905f:       c7 44 24 04 4a 8e 04    movl   $0x8048e4a,0x4(%esp)
 8049066:       08
 8049067:       c7 04 24 0b 00 00 00    movl   $0xb,(%esp)
 804906e:       e8 ed f7 ff ff          call   8048860 <signal@plt>
 8049073:       c7 44 24 04 20 8e 04    movl   $0x8048e20,0x4(%esp)
 804907a:       08
 804907b:       c7 04 24 07 00 00 00    movl   $0x7,(%esp)
 8049082:       e8 d9 f7 ff ff          call   8048860 <signal@plt>
 8049087:       c7 44 24 04 74 8e 04    movl   $0x8048e74,0x4(%esp)
 804908e:       08
 804908f:       c7 04 24 04 00 00 00    movl   $0x4,(%esp)
 8049096:       e8 c5 f7 ff ff          call   8048860 <signal@plt>
 804909b:       a1 e4 e0 04 08          mov    0x804e0e4,%eax
 80490a0:       a3 00 e1 04 08          mov    %eax,0x804e100
 80490a5:       e9 8e 00 00 00          jmp    8049138 <main+0xfb>
 80490aa:       0f be 44 24 2f          movsbl 0x2f(%esp),%eax
 80490af:       83 e8 67                sub    $0x67,%eax
 80490b2:       83 f8 0e                cmp    $0xe,%eax
 80490b5:       77 74                   ja     804912b <main+0xee>
 80490b7:       8b 04 85 fc a8 04 08    mov    0x804a8fc(,%eax,4),%eax
 80490be:       ff e0                   jmp    *%eax
 80490c0:       8b 45 0c                mov    0xc(%ebp),%eax
 80490c3:       8b 00                   mov    (%eax),%eax
 80490c5:       89 04 24                mov    %eax,(%esp)
 80490c8:       e8 fd fc ff ff          call   8048dca <usage>
 80490cd:       eb 69                   jmp    8049138 <main+0xfb>
 80490cf:       c7 44 24 18 01 00 00    movl   $0x1,0x18(%esp)
 80490d6:       00
 80490d7:       c7 44 24 20 05 00 00    movl   $0x5,0x20(%esp)
 80490de:       00
 80490df:       eb 57                   jmp    8049138 <main+0xfb>
 80490e1:       a1 e8 e0 04 08          mov    0x804e0e8,%eax
 80490e6:       89 04 24                mov    %eax,(%esp)
 80490e9:       e8 52 f7 ff ff          call   8048840 <strdup@plt>
 80490ee:       a3 f4 e0 04 08          mov    %eax,0x804e0f4
 80490f3:       a1 f4 e0 04 08          mov    0x804e0f4,%eax
 80490f8:       89 04 24                mov    %eax,(%esp)
 80490fb:       e8 a3 13 00 00          call   804a4a3 <gencookie>
 8049100:       a3 04 e1 04 08          mov    %eax,0x804e104
 8049105:       eb 31                   jmp    8049138 <main+0xfb>
8049107:       c7 04 24 84 a8 04 08    movl   $0x804a884,(%esp)
 804910e:       e8 ed f7 ff ff          call   8048900 <puts@plt>
 8049113:       c7 05 f8 e0 04 08 00    movl   $0x0,0x804e0f8
 804911a:       00 00 00
 804911d:       eb 19                   jmp    8049138 <main+0xfb>
 804911f:       c7 05 fc e0 04 08 01    movl   $0x1,0x804e0fc
 8049126:       00 00 00
 8049129:       eb 0d                   jmp    8049138 <main+0xfb>
 804912b:       8b 45 0c                mov    0xc(%ebp),%eax
 804912e:       8b 00                   mov    (%eax),%eax
 8049130:       89 04 24                mov    %eax,(%esp)
 8049133:       e8 92 fc ff ff          call   8048dca <usage>
 8049138:       c7 44 24 08 ac a8 04    movl   $0x804a8ac,0x8(%esp)
 804913f:       08
 8049140:       8b 45 0c                mov    0xc(%ebp),%eax
 8049143:       89 44 24 04             mov    %eax,0x4(%esp)
 8049147:       8b 45 08                mov    0x8(%ebp),%eax
 804914a:       89 04 24                mov    %eax,(%esp)
 804914d:       e8 1e f8 ff ff          call   8048970 <getopt@plt>
 8049152:       88 44 24 2f             mov    %al,0x2f(%esp)
 8049156:       80 7c 24 2f ff          cmpb   $0xff,0x2f(%esp)
  804915b:       0f 85 49 ff ff ff       jne    80490aa <main+0x6d>
 8049161:       a1 f4 e0 04 08          mov    0x804e0f4,%eax
 8049166:       85 c0                   test   %eax,%eax
 8049168:       75 23                   jne    804918d <main+0x150>
 804916a:       8b 45 0c                mov    0xc(%ebp),%eax
 804916d:       8b 10                   mov    (%eax),%edx
 804916f:       b8 b4 a8 04 08          mov    $0x804a8b4,%eax
 8049174:       89 54 24 04             mov    %edx,0x4(%esp)
 8049178:       89 04 24                mov    %eax,(%esp)
 804917b:       e8 b0 f6 ff ff          call   8048830 <printf@plt>
 8049180:       8b 45 0c                mov    0xc(%ebp),%eax
 8049183:       8b 00                   mov    (%eax),%eax
 8049185:       89 04 24                mov    %eax,(%esp)
 8049188:       e8 3d fc ff ff          call   8048dca <usage>
 804918d:       e8 2a 01 00 00          call   80492bc <initialize_bomb>
 8049192:       8b 15 f4 e0 04 08       mov    0x804e0f4,%edx
 8049198:       b8 e0 a8 04 08          mov    $0x804a8e0,%eax
 804919d:       89 54 24 04             mov    %edx,0x4(%esp)
 