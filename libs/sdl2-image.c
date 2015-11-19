/* Generated from libs/chicken-sdl2-image/sdl2-image.scm by the CHICKEN compiler
   http://www.call-cc.org
   2015-11-19 12:13
   Version 4.9.0.1 (stability/4.9.0) (rev 8b3189b)
   linux-unix-gnu-x86-64 [ 64bit manyargs dload ptables ]
   bootstrapped 2014-06-07
   command line: libs/chicken-sdl2-image/sdl2-image.scm -output-file libs/sdl2-image.c -feature chicken-compile-static -verbose -unit sdl2-image -uses sdl2-internals
   unit: sdl2_2dimage
*/

#include "chicken.h"

#include "SDL_image.h"

static C_PTABLE_ENTRY *create_ptable(void);
C_noret_decl(C_library_toplevel)
C_externimport void C_ccall C_library_toplevel(C_word c,C_word d,C_word k) C_noret;
C_noret_decl(C_eval_toplevel)
C_externimport void C_ccall C_eval_toplevel(C_word c,C_word d,C_word k) C_noret;
C_noret_decl(C_chicken_2dsyntax_toplevel)
C_externimport void C_ccall C_chicken_2dsyntax_toplevel(C_word c,C_word d,C_word k) C_noret;
C_noret_decl(C_sdl2_2dinternals_toplevel)
C_externimport void C_ccall C_sdl2_2dinternals_toplevel(C_word c,C_word d,C_word k) C_noret;
C_noret_decl(C_sdl2_2dinternals_toplevel)
C_externimport void C_ccall C_sdl2_2dinternals_toplevel(C_word c,C_word d,C_word k) C_noret;

static C_TLS C_word lf[39];
static double C_possibly_force_alignment;
static C_char C_TLS li0[] C_aligned={C_lihdr(0,0,21),40,109,97,112,45,108,111,111,112,49,48,52,32,103,49,49,54,49,50,57,41,0,0,0};
static C_char C_TLS li1[] C_aligned={C_lihdr(0,0,30),40,115,100,108,50,45,105,109,97,103,101,35,105,110,105,116,33,32,46,32,116,109,112,49,52,54,49,52,55,41,0,0};
static C_char C_TLS li2[] C_aligned={C_lihdr(0,0,18),40,115,100,108,50,45,105,109,97,103,101,35,113,117,105,116,33,41,0,0,0,0,0,0};
static C_char C_TLS li3[] C_aligned={C_lihdr(0,0,6),40,97,55,53,57,41,0,0};
static C_char C_TLS li4[] C_aligned={C_lihdr(0,0,28),40,97,55,56,48,32,46,32,114,101,115,117,108,116,45,118,97,108,117,101,115,49,55,50,49,57,54,41,0,0,0,0};
static C_char C_TLS li5[] C_aligned={C_lihdr(0,0,28),40,115,100,108,50,45,105,109,97,103,101,35,99,117,114,114,101,110,116,45,118,101,114,115,105,111,110,41,0,0,0,0};
static C_char C_TLS li6[] C_aligned={C_lihdr(0,0,6),40,97,56,51,52,41,0,0};
static C_char C_TLS li7[] C_aligned={C_lihdr(0,0,28),40,97,56,53,53,32,46,32,114,101,115,117,108,116,45,118,97,108,117,101,115,50,48,52,50,50,56,41,0,0,0,0};
static C_char C_TLS li8[] C_aligned={C_lihdr(0,0,29),40,115,100,108,50,45,105,109,97,103,101,35,99,111,109,112,105,108,101,100,45,118,101,114,115,105,111,110,41,0,0,0};
static C_char C_TLS li9[] C_aligned={C_lihdr(0,0,29),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,32,102,105,108,101,112,97,116,104,50,51,52,41,0,0,0};
static C_char C_TLS li10[] C_aligned={C_lihdr(0,0,30),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,42,32,102,105,108,101,112,97,116,104,50,51,57,41,0,0};
static C_char C_TLS li11[] C_aligned={C_lihdr(0,0,41),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,45,114,119,32,114,119,111,112,115,50,54,49,32,46,32,116,109,112,50,54,48,50,54,50,41,0,0,0,0,0,0,0};
static C_char C_TLS li12[] C_aligned={C_lihdr(0,0,42),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,45,114,119,42,32,114,119,111,112,115,50,55,55,32,46,32,116,109,112,50,55,54,50,55,56,41,0,0,0,0,0,0};
static C_char C_TLS li13[] C_aligned={C_lihdr(0,0,53),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,45,116,121,112,101,100,45,114,119,32,114,119,111,112,115,51,48,48,32,99,108,111,115,101,63,51,48,49,32,116,121,112,101,51,48,50,41,0,0,0};
static C_char C_TLS li14[] C_aligned={C_lihdr(0,0,54),40,115,100,108,50,45,105,109,97,103,101,35,108,111,97,100,45,116,121,112,101,100,45,114,119,42,32,114,119,111,112,115,51,48,55,32,99,108,111,115,101,63,51,48,56,32,116,121,112,101,51,48,57,41,0,0};
static C_char C_TLS li15[] C_aligned={C_lihdr(0,0,10),40,116,111,112,108,101,118,101,108,41,0,0,0,0,0,0};


/* from k1046 in k1057 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static C_word C_fcall stub316(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2) C_regparm;
C_regparm static C_word C_fcall stub316(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
SDL_RWops *t0=(SDL_RWops *)C_c_pointer_nn(C_a0);
int t1=(int )C_truep(C_a1);
char * t2=(char * )C_string_or_null(C_a2);
C_r=C_mpointer(&C_a,(void*)IMG_LoadTyped_RW(t0,t1,t2));
return C_r;}

/* from k975 */
static C_word C_fcall stub289(C_word C_buf,C_word C_a0,C_word C_a1) C_regparm;
C_regparm static C_word C_fcall stub289(C_word C_buf,C_word C_a0,C_word C_a1){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
SDL_RWops *t0=(SDL_RWops *)C_c_pointer_nn(C_a0);
int t1=(int )C_truep(C_a1);
C_r=C_mpointer(&C_a,(void*)IMG_Load_RW(t0,t1));
return C_r;}

/* from k899 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static C_word C_fcall stub244(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub244(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
const char * t0=(const char * )C_string_or_null(C_a0);
C_r=C_mpointer(&C_a,(void*)IMG_Load(t0));
return C_r;}

#define return(x) C_cblock C_r = (((C_word)(x))); goto C_ret; C_cblockend
static C_word C_fcall stub213(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2) C_regparm;
C_regparm static C_word C_fcall stub213(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
unsigned C_char *majorOut=(unsigned C_char *)C_c_pointer_or_null(C_a0);
unsigned C_char *minorOut=(unsigned C_char *)C_c_pointer_or_null(C_a1);
unsigned C_char *patchOut=(unsigned C_char *)C_c_pointer_or_null(C_a2);
SDL_version v;SDL_IMAGE_VERSION(&v);*majorOut = v.major;*minorOut = v.minor;*patchOut = v.patch;
C_ret:
#undef return

return C_r;}

#define return(x) C_cblock C_r = (((C_word)(x))); goto C_ret; C_cblockend
static C_word C_fcall stub181(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2) C_regparm;
C_regparm static C_word C_fcall stub181(C_word C_buf,C_word C_a0,C_word C_a1,C_word C_a2){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
unsigned C_char *majorOut=(unsigned C_char *)C_c_pointer_or_null(C_a0);
unsigned C_char *minorOut=(unsigned C_char *)C_c_pointer_or_null(C_a1);
unsigned C_char *patchOut=(unsigned C_char *)C_c_pointer_or_null(C_a2);
const SDL_version* v = IMG_Linked_Version();*majorOut = v->major;*minorOut = v->minor;*patchOut = v->patch;
C_ret:
#undef return

return C_r;}

/* from IMG_Quit */
static C_word C_fcall stub166(C_word C_buf) C_regparm;
C_regparm static C_word C_fcall stub166(C_word C_buf){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
IMG_Quit();
return C_r;}

/* from k691 */
static C_word C_fcall stub157(C_word C_buf,C_word C_a0) C_regparm;
C_regparm static C_word C_fcall stub157(C_word C_buf,C_word C_a0){
C_word C_r=C_SCHEME_UNDEFINED,*C_a=(C_word*)C_buf;
int t0=(int )C_unfix(C_a0);
C_r=C_fix((C_word)IMG_Init(t0));
return C_r;}

C_noret_decl(f_760)
static void C_ccall f_760(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_871)
static void C_ccall f_871(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_1014)
static void C_ccall f_1014(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4) C_noret;
C_noret_decl(f_712)
static void C_ccall f_712(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_827)
static void C_ccall f_827(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_824)
static void C_ccall f_824(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_954)
static void C_ccall f_954(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1006)
static void C_ccall f_1006(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_641)
static void C_fcall f_641(C_word t0,C_word t1) C_noret;
C_noret_decl(f_785)
static void C_ccall f_785(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_788)
static void C_ccall f_788(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_781)
static void C_ccall f_781(C_word c,C_word t0,C_word t1,...) C_noret;
C_noret_decl(f_781)
static void C_ccall f_781r(C_word t0,C_word t1,C_word t3) C_noret;
C_noret_decl(f_989)
static void C_fcall f_989(C_word t0,C_word t1) C_noret;
C_noret_decl(f_981)
static void C_ccall f_981(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_647)
static void C_fcall f_647(C_word t0,C_word t1) C_noret;
C_noret_decl(f_644)
static void C_fcall f_644(C_word t0,C_word t1) C_noret;
C_noret_decl(f_704)
static void C_ccall f_704(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1067)
static void C_fcall f_1067(C_word t0,C_word t1) C_noret;
C_noret_decl(f_721)
static void C_ccall f_721(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_835)
static void C_ccall f_835(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_830)
static void C_ccall f_830(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_901)
static void C_ccall f_901(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_682)
static void C_ccall f_682(C_word c,C_word t0,C_word t1,...) C_noret;
C_noret_decl(f_682)
static void C_ccall f_682r(C_word t0,C_word t1,C_word t3) C_noret;
C_noret_decl(f_919)
static void C_ccall f_919(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_916)
static void C_fcall f_916(C_word t0,C_word t1) C_noret;
C_noret_decl(f_749)
static void C_ccall f_749(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_602)
static void C_fcall f_602(C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_600)
static void C_ccall f_600(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_935)
static void C_ccall f_935(C_word c,C_word t0,C_word t1,C_word t2,...) C_noret;
C_noret_decl(f_935)
static void C_ccall f_935r(C_word t0,C_word t1,C_word t2,C_word t4) C_noret;
C_noret_decl(f_933)
static void C_ccall f_933(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_615)
static void C_fcall f_615(C_word t0,C_word t1) C_noret;
C_noret_decl(f_557)
static void C_ccall f_557(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_554)
static void C_ccall f_554(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_796)
static void C_ccall f_796(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_962)
static void C_ccall f_962(C_word c,C_word t0,C_word t1,C_word t2,...) C_noret;
C_noret_decl(f_962)
static void C_ccall f_962r(C_word t0,C_word t1,C_word t2,C_word t4) C_noret;
C_noret_decl(f_791)
static void C_ccall f_791(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_551)
static void C_ccall f_551(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_631)
static void C_ccall f_631(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1084)
static void C_ccall f_1084(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_545)
static void C_ccall f_545(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_548)
static void C_ccall f_548(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_854)
static void C_ccall f_854(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_542)
static void C_ccall f_542(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_856)
static void C_ccall f_856(C_word c,C_word t0,C_word t1,...) C_noret;
C_noret_decl(f_856)
static void C_ccall f_856r(C_word t0,C_word t1,C_word t3) C_noret;
C_noret_decl(f_850)
static void C_ccall f_850(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1070)
static void C_ccall f_1070(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1077)
static void C_ccall f_1077(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_889)
static void C_ccall f_889(C_word c,C_word t0,C_word t1,C_word t2) C_noret;
C_noret_decl(f_887)
static void C_ccall f_887(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_539)
static void C_ccall f_539(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1059)
static void C_ccall f_1059(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1048)
static void C_ccall f_1048(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(C_sdl2_2dimage_toplevel)
C_externexport void C_ccall C_sdl2_2dimage_toplevel(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_752)
static void C_ccall f_752(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_755)
static void C_ccall f_755(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_926)
static void C_ccall f_926(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_863)
static void C_ccall f_863(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_866)
static void C_ccall f_866(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_999)
static void C_ccall f_999(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_860)
static void C_ccall f_860(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_992)
static void C_ccall f_992(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_1032)
static void C_ccall f_1032(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4) C_noret;
C_noret_decl(f_1030)
static void C_ccall f_1030(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_775)
static void C_ccall f_775(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_779)
static void C_ccall f_779(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_771)
static void C_ccall f_771(C_word c,C_word t0,C_word t1) C_noret;
C_noret_decl(f_846)
static void C_ccall f_846(C_word c,C_word t0,C_word t1) C_noret;

C_noret_decl(trf_641)
static void C_fcall trf_641(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_641(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_641(t0,t1);}

C_noret_decl(trf_989)
static void C_fcall trf_989(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_989(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_989(t0,t1);}

C_noret_decl(trf_647)
static void C_fcall trf_647(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_647(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_647(t0,t1);}

C_noret_decl(trf_644)
static void C_fcall trf_644(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_644(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_644(t0,t1);}

C_noret_decl(trf_1067)
static void C_fcall trf_1067(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_1067(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_1067(t0,t1);}

C_noret_decl(trf_916)
static void C_fcall trf_916(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_916(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_916(t0,t1);}

C_noret_decl(trf_602)
static void C_fcall trf_602(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_602(void *dummy){
C_word t2=C_pick(0);
C_word t1=C_pick(1);
C_word t0=C_pick(2);
C_adjust_stack(-3);
f_602(t0,t1,t2);}

C_noret_decl(trf_615)
static void C_fcall trf_615(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall trf_615(void *dummy){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
f_615(t0,t1);}

C_noret_decl(tr5)
static void C_fcall tr5(C_proc5 k) C_regparm C_noret;
C_regparm static void C_fcall tr5(C_proc5 k){
C_word t4=C_pick(0);
C_word t3=C_pick(1);
C_word t2=C_pick(2);
C_word t1=C_pick(3);
C_word t0=C_pick(4);
C_adjust_stack(-5);
(k)(5,t0,t1,t2,t3,t4);}

C_noret_decl(tr3)
static void C_fcall tr3(C_proc3 k) C_regparm C_noret;
C_regparm static void C_fcall tr3(C_proc3 k){
C_word t2=C_pick(0);
C_word t1=C_pick(1);
C_word t0=C_pick(2);
C_adjust_stack(-3);
(k)(3,t0,t1,t2);}

C_noret_decl(tr2)
static void C_fcall tr2(C_proc2 k) C_regparm C_noret;
C_regparm static void C_fcall tr2(C_proc2 k){
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
(k)(2,t0,t1);}

C_noret_decl(tr3r)
static void C_fcall tr3r(C_proc3 k) C_regparm C_noret;
C_regparm static void C_fcall tr3r(C_proc3 k){
int n;
C_word *a,t3;
C_word t2=C_pick(0);
C_word t1=C_pick(1);
C_word t0=C_pick(2);
C_adjust_stack(-3);
n=C_rest_count(0);
a=C_alloc(n*3);
t3=C_restore_rest(a,n);
(k)(t0,t1,t2,t3);}

C_noret_decl(tr2r)
static void C_fcall tr2r(C_proc2 k) C_regparm C_noret;
C_regparm static void C_fcall tr2r(C_proc2 k){
int n;
C_word *a,t2;
C_word t1=C_pick(0);
C_word t0=C_pick(1);
C_adjust_stack(-2);
n=C_rest_count(0);
a=C_alloc(n*3);
t2=C_restore_rest(a,n);
(k)(t0,t1,t2);}

/* a759 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_760(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word ab[5],*a=ab;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_760,2,t0,t1);}
t2=(C_truep(((C_word*)t0)[2])?C_i_foreign_pointer_argumentp(((C_word*)t0)[2]):C_SCHEME_FALSE);
t3=(C_truep(((C_word*)t0)[3])?C_i_foreign_pointer_argumentp(((C_word*)t0)[3]):C_SCHEME_FALSE);
t4=(C_truep(((C_word*)t0)[4])?C_i_foreign_pointer_argumentp(((C_word*)t0)[4]):C_SCHEME_FALSE);
t5=stub181(C_SCHEME_UNDEFINED,t2,t3,t4);
t6=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_771,a[2]=t1,a[3]=((C_word*)t0)[4],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:181: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t6,((C_word*)t0)[2]);}

/* sdl2-image#load in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_871(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word ab[3],*a=ab;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_871,3,t0,t1,t2);}
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_887,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:223: load*");
((C_proc3)C_fast_retrieve_symbol_proc(lf[26]))(3,*((C_word*)lf[26]+1),t3,t2);}

/* sdl2-image#load-typed-rw in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1014(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4){
C_word tmp;
C_word t5;
C_word t6;
C_word ab[3],*a=ab;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr5,(void*)f_1014,5,t0,t1,t2,t3,t4);}
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1030,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:259: load-typed-rw*");
((C_proc5)C_fast_retrieve_symbol_proc(lf[33]))(5,*((C_word*)lf[33]+1),t5,t2,t3,t4);}

/* sdl2-image#quit! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_712(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_712,2,t0,t1);}
t2=t1;
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,stub166(C_SCHEME_UNDEFINED));}

/* k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_827(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_827,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_830,a[2]=((C_word*)t0)[2],a[3]=t2,a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:198: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t3);}

/* k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_824(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[4],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_824,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_827,a[2]=t2,a[3]=((C_word*)t0)[2],tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:197: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t3);}

/* k952 in sdl2-image#load-rw in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_954(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
t2=((C_word*)t0)[2];
if(C_truep(t1)){
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:216: set-finalizer!");
((C_proc4)C_fast_retrieve_symbol_proc(lf[24]))(4,*((C_word*)lf[24]+1),t2,t1,C_fast_retrieve(lf[25]));}
else{
t3=t2;
((C_proc2)(void*)(*((C_word*)t3+1)))(2,t3,t1);}}

/* k1004 in sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1006(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[8],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_1006,2,t0,t1);}
t2=((C_word*)t0)[2];
t3=t1;
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_989,a[2]=t2,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
t5=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_992,a[2]=t4,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#surface?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[28]))(3,*((C_word*)lf[28]+1),t5,t3);}

/* k639 in k702 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_641(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[12],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)trf_641,NULL,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_644,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
t3=C_a_i_bitwise_and(&a,2,((C_word*)t0)[4],C_retrieve2(lf[5],"sdl2-image#IMG_INIT_PNG"));
if(C_truep(C_i_zerop(t3))){
t4=t2;
f_644(t4,C_SCHEME_UNDEFINED);}
else{
t4=C_a_i_cons(&a,2,lf[10],((C_word*)((C_word*)t0)[3])[1]);
t5=C_mutate2(((C_word *)((C_word*)t0)[3])+1,t4);
t6=t2;
f_644(t6,t5);}}

/* k783 in a780 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_785(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_785,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_788,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:169: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t2,((C_word*)t0)[5]);}

/* k786 in k783 in a780 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_788(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[4],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_788,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_791,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:169: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t2,((C_word*)t0)[4]);}

/* a780 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_781(C_word c,C_word t0,C_word t1,...){
C_word tmp;
C_word t2;
va_list v;
C_word *a,c2=c;
C_save_rest(t1,c2,2);
C_check_for_interrupt;
if(!C_demand(c*C_SIZEOF_PAIR+6)){
C_save_and_reclaim((void*)tr2r,(void*)f_781r,2,t0,t1);}
else{
a=C_alloc((c-2)*3);
t2=C_restore_rest(a,C_rest_count(0));
f_781r(t0,t1,t2);}}

static void C_ccall f_781r(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word *a=C_alloc(6);
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_785,a[2]=t1,a[3]=t2,a[4]=((C_word*)t0)[2],a[5]=((C_word*)t0)[3],tmp=(C_word)a,a+=6,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:169: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t3,((C_word*)t0)[4]);}

/* k987 in k1004 in sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_989(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,(C_truep(t1)?((C_word*)t0)[3]:C_SCHEME_FALSE));}

/* k979 in sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_981(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word *a;
t2=C_i_foreign_pointer_argumentp(t1);
t3=stub289(((C_word*)t0)[2],t2,((C_word*)t0)[3]);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:245: g22");
((C_proc3)C_retrieve2_symbol_proc(lf[0],"sdl2-image#g22"))(3,lf[0],((C_word*)t0)[4],t3);}

/* k645 in k642 in k639 in k702 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_647(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,((C_word*)((C_word*)t0)[3])[1]);}

/* k642 in k639 in k702 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_644(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[11],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)trf_644,NULL,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_647,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],tmp=(C_word)a,a+=4,tmp);
t3=C_a_i_bitwise_and(&a,2,((C_word*)t0)[4],C_retrieve2(lf[4],"sdl2-image#IMG_INIT_JPG"));
if(C_truep(C_i_zerop(t3))){
t4=t2;
f_647(t4,C_SCHEME_UNDEFINED);}
else{
t4=C_a_i_cons(&a,2,lf[9],((C_word*)((C_word*)t0)[3])[1]);
t5=C_mutate2(((C_word *)((C_word*)t0)[3])+1,t4);
t6=t2;
f_647(t6,t5);}}

/* k702 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_704(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word ab[14],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_704,2,t0,t1);}
t2=C_i_foreign_fixnum_argumentp(t1);
t3=stub157(C_SCHEME_UNDEFINED,t2);
t4=((C_word*)t0)[2];
t5=t3;
t6=C_SCHEME_END_OF_LIST;
t7=(*a=C_VECTOR_TYPE|1,a[1]=t6,tmp=(C_word)a,a+=2,tmp);
t8=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_641,a[2]=t4,a[3]=t7,a[4]=t5,tmp=(C_word)a,a+=5,tmp);
t9=C_a_i_bitwise_and(&a,2,t5,C_retrieve2(lf[6],"sdl2-image#IMG_INIT_TIF"));
if(C_truep(C_i_zerop(t9))){
t10=t8;
f_641(t10,C_SCHEME_UNDEFINED);}
else{
t10=C_a_i_cons(&a,2,lf[11],((C_word*)t7)[1]);
t11=C_set_block_item(t7,0,t10);
t12=t8;
f_641(t12,t11);}}

/* k1065 in k1082 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_1067(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,(C_truep(t1)?((C_word*)t0)[3]:C_SCHEME_FALSE));}

/* sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_721(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_721,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_749,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:177: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t2);}

/* a834 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_835(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word ab[5],*a=ab;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_835,2,t0,t1);}
t2=(C_truep(((C_word*)t0)[2])?C_i_foreign_pointer_argumentp(((C_word*)t0)[2]):C_SCHEME_FALSE);
t3=(C_truep(((C_word*)t0)[3])?C_i_foreign_pointer_argumentp(((C_word*)t0)[3]):C_SCHEME_FALSE);
t4=(C_truep(((C_word*)t0)[4])?C_i_foreign_pointer_argumentp(((C_word*)t0)[4]):C_SCHEME_FALSE);
t5=stub213(C_SCHEME_UNDEFINED,t2,t3,t4);
t6=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_846,a[2]=t1,a[3]=((C_word*)t0)[4],a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:200: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t6,((C_word*)t0)[2]);}

/* k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_830(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word ab[12],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_830,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_835,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t2,a[5]=((C_word)li6),tmp=(C_word)a,a+=6,tmp);
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_856,a[2]=t2,a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[2],a[5]=((C_word)li7),tmp=(C_word)a,a+=6,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:187: ##sys#call-with-values");
C_call_with_values(4,0,((C_word*)t0)[4],t3,t4);}

/* k899 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_901(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
t2=stub244(((C_word*)t0)[2],t1);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:227: g22");
((C_proc3)C_retrieve2_symbol_proc(lf[0],"sdl2-image#g22"))(3,lf[0],((C_word*)t0)[3],t2);}

/* sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_682(C_word c,C_word t0,C_word t1,...){
C_word tmp;
C_word t2;
va_list v;
C_word *a,c2=c;
C_save_rest(t1,c2,2);
C_check_for_interrupt;
if(!C_demand(c*C_SIZEOF_PAIR+18)){
C_save_and_reclaim((void*)tr2r,(void*)f_682r,2,t0,t1);}
else{
a=C_alloc((c-2)*3);
t2=C_restore_rest(a,C_rest_count(0));
f_682r(t0,t1,t2);}}

static void C_ccall f_682r(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word t14;
C_word t15;
C_word t16;
C_word *a=C_alloc(18);
t3=C_i_nullp(t2);
t4=(C_truep(t3)?lf[8]:C_i_car(t2));
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_704,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
t6=t5;
t7=C_SCHEME_END_OF_LIST;
t8=(*a=C_VECTOR_TYPE|1,a[1]=t7,tmp=(C_word)a,a+=2,tmp);
t9=C_SCHEME_FALSE;
t10=(*a=C_VECTOR_TYPE|1,a[1]=t9,tmp=(C_word)a,a+=2,tmp);
t11=C_i_check_list_2(t4,lf[12]);
t12=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_600,a[2]=t6,tmp=(C_word)a,a+=3,tmp);
t13=C_SCHEME_UNDEFINED;
t14=(*a=C_VECTOR_TYPE|1,a[1]=t13,tmp=(C_word)a,a+=2,tmp);
t15=C_set_block_item(t14,0,(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_602,a[2]=t10,a[3]=t14,a[4]=t8,a[5]=((C_word)li0),tmp=(C_word)a,a+=6,tmp));
t16=((C_word*)t14)[1];
f_602(t16,t12,t4);}

/* k917 in k931 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_919(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_919,2,t0,t1);}
if(C_truep(t1)){
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_926,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#struct-null?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[27]))(3,*((C_word*)lf[27]+1),t2,((C_word*)t0)[3]);}
else{
t2=((C_word*)t0)[2];
f_916(t2,C_SCHEME_FALSE);}}

/* k914 in k931 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_916(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,(C_truep(t1)?((C_word*)t0)[3]:C_SCHEME_FALSE));}

/* k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_749(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[4],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_749,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_752,a[2]=t2,a[3]=((C_word*)t0)[2],tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:178: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t3);}

/* map-loop104 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_602(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word ab[7],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)trf_602,NULL,3,t0,t1,t2);}
if(C_truep(C_i_pairp(t2))){
t3=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_631,a[2]=((C_word*)t0)[2],a[3]=t2,a[4]=((C_word*)t0)[3],a[5]=t1,a[6]=((C_word*)t0)[4],tmp=(C_word)a,a+=7,tmp);
t4=C_slot(t2,C_fix(0));
t5=C_eqp(t4,lf[9]);
if(C_truep(t5)){
t6=t3;
f_631(2,t6,C_retrieve2(lf[4],"sdl2-image#IMG_INIT_JPG"));}
else{
t6=C_eqp(t4,lf[10]);
if(C_truep(t6)){
t7=t3;
f_631(2,t7,C_retrieve2(lf[5],"sdl2-image#IMG_INIT_PNG"));}
else{
t7=C_eqp(t4,lf[11]);
if(C_truep(t7)){
t8=t3;
f_631(2,t8,C_retrieve2(lf[6],"sdl2-image#IMG_INIT_TIF"));}
else{
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:135: error");
((C_proc5)C_fast_retrieve_proc(*((C_word*)lf[14]+1)))(5,*((C_word*)lf[14]+1),t3,lf[15],lf[16],t4);}}}}
else{
t3=t1;
((C_proc2)(void*)(*((C_word*)t3+1)))(2,t3,((C_word*)((C_word*)t0)[4])[1]);}}

/* k598 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_600(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_apply(4,0,((C_word*)t0)[2],*((C_word*)lf[13]+1),t1);}

/* sdl2-image#load-rw in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_935(C_word c,C_word t0,C_word t1,C_word t2,...){
C_word tmp;
C_word t3;
va_list v;
C_word *a,c2=c;
C_save_rest(t2,c2,3);
if(c<3) C_bad_min_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_demand(c*C_SIZEOF_PAIR+3)){
C_save_and_reclaim((void*)tr3r,(void*)f_935r,3,t0,t1,t2);}
else{
a=C_alloc((c-3)*3);
t3=C_restore_rest(a,C_rest_count(0));
f_935r(t0,t1,t2,t3);}}

static void C_ccall f_935r(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word *a=C_alloc(3);
t4=C_i_nullp(t3);
t5=(C_truep(t4)?C_SCHEME_FALSE:C_i_car(t3));
t6=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_954,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:239: load-rw*");
((C_proc4)C_fast_retrieve_symbol_proc(lf[31]))(4,*((C_word*)lf[31]+1),t6,t2,t5);}

/* k931 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_933(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[8],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_933,2,t0,t1);}
t2=((C_word*)t0)[2];
t3=t1;
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_916,a[2]=t2,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
t5=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_919,a[2]=t4,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#surface?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[28]))(3,*((C_word*)lf[28]+1),t5,t3);}

/* k613 in k629 in map-loop104 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_fcall f_615(C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word *a;
t2=C_mutate2(((C_word *)((C_word*)t0)[2])+1,((C_word*)t0)[3]);
t3=C_slot(((C_word*)t0)[4],C_fix(1));
t4=((C_word*)((C_word*)t0)[5])[1];
f_602(t4,((C_word*)t0)[6],t3);}

/* k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_557(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word t12;
C_word t13;
C_word t14;
C_word t15;
C_word t16;
C_word t17;
C_word ab[30],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_557,2,t0,t1);}
t2=C_mutate2(&lf[0] /* (set! sdl2-image#g22 ...) */,C_fast_retrieve(lf[1]));
t3=C_mutate2(&lf[2] /* (set! sdl2-image#g26 ...) */,C_fast_retrieve(lf[3]));
t4=C_mutate2(&lf[4] /* (set! sdl2-image#IMG_INIT_JPG ...) */,C_fix((C_word)IMG_INIT_JPG));
t5=C_mutate2(&lf[5] /* (set! sdl2-image#IMG_INIT_PNG ...) */,C_fix((C_word)IMG_INIT_PNG));
t6=C_mutate2(&lf[6] /* (set! sdl2-image#IMG_INIT_TIF ...) */,C_fix((C_word)IMG_INIT_TIF));
t7=C_mutate2((C_word*)lf[7]+1 /* (set! sdl2-image#init! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_682,a[2]=((C_word)li1),tmp=(C_word)a,a+=3,tmp));
t8=C_mutate2((C_word*)lf[17]+1 /* (set! sdl2-image#quit! ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_712,a[2]=((C_word)li2),tmp=(C_word)a,a+=3,tmp));
t9=C_mutate2((C_word*)lf[18]+1 /* (set! sdl2-image#current-version ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_721,a[2]=((C_word)li5),tmp=(C_word)a,a+=3,tmp));
t10=C_mutate2((C_word*)lf[22]+1 /* (set! sdl2-image#compiled-version ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_796,a[2]=((C_word)li8),tmp=(C_word)a,a+=3,tmp));
t11=C_mutate2((C_word*)lf[23]+1 /* (set! sdl2-image#load ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_871,a[2]=((C_word)li9),tmp=(C_word)a,a+=3,tmp));
t12=C_mutate2((C_word*)lf[26]+1 /* (set! sdl2-image#load* ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_889,a[2]=((C_word)li10),tmp=(C_word)a,a+=3,tmp));
t13=C_mutate2((C_word*)lf[30]+1 /* (set! sdl2-image#load-rw ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_935,a[2]=((C_word)li11),tmp=(C_word)a,a+=3,tmp));
t14=C_mutate2((C_word*)lf[31]+1 /* (set! sdl2-image#load-rw* ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_962,a[2]=((C_word)li12),tmp=(C_word)a,a+=3,tmp));
t15=C_mutate2((C_word*)lf[32]+1 /* (set! sdl2-image#load-typed-rw ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1014,a[2]=((C_word)li13),tmp=(C_word)a,a+=3,tmp));
t16=C_mutate2((C_word*)lf[33]+1 /* (set! sdl2-image#load-typed-rw* ...) */,(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1032,a[2]=((C_word)li14),tmp=(C_word)a,a+=3,tmp));
t17=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t17+1)))(2,t17,C_SCHEME_UNDEFINED);}

/* k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_554(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_554,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_557,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:33: ##sys#register-compiled-module");
((C_proc7)C_fast_retrieve_symbol_proc(lf[34]))(7,*((C_word*)lf[34]+1),t2,lf[35],C_SCHEME_END_OF_LIST,lf[36],C_SCHEME_END_OF_LIST,C_SCHEME_END_OF_LIST);}

/* sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_796(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
if(c!=2) C_bad_argc_2(c,2,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_796,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_824,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:196: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t2);}

/* sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_962(C_word c,C_word t0,C_word t1,C_word t2,...){
C_word tmp;
C_word t3;
va_list v;
C_word *a,c2=c;
C_save_rest(t2,c2,3);
if(c<3) C_bad_min_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_demand(c*C_SIZEOF_PAIR+13)){
C_save_and_reclaim((void*)tr3r,(void*)f_962r,3,t0,t1,t2);}
else{
a=C_alloc((c-3)*3);
t3=C_restore_rest(a,C_rest_count(0));
f_962r(t0,t1,t2,t3);}}

static void C_ccall f_962r(C_word t0,C_word t1,C_word t2,C_word t3){
C_word tmp;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word *a=C_alloc(13);
t4=C_i_nullp(t3);
t5=(C_truep(t4)?C_SCHEME_FALSE:C_i_car(t3));
t6=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1006,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
t7=t6;
t8=t5;
t9=C_a_i_bytevector(&a,1,C_fix(3));
t10=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_981,a[2]=t9,a[3]=t8,a[4]=t7,tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:245: g26");
((C_proc3)C_retrieve2_symbol_proc(lf[2],"sdl2-image#g26"))(3,lf[2],t10,t2);}

/* k789 in k786 in k783 in a780 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_791(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_apply_values(3,0,((C_word*)t0)[2],((C_word*)t0)[3]);}

/* k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_551(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_551,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_554,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:33: eval");
((C_proc3)C_fast_retrieve_symbol_proc(lf[37]))(3,*((C_word*)lf[37]+1),t2,lf[38]);}

/* k629 in map-loop104 in sdl2-image#init! in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_631(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[10],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_631,2,t0,t1);}
t2=C_a_i_cons(&a,2,t1,C_SCHEME_END_OF_LIST);
t3=t2;
t4=(*a=C_CLOSURE_TYPE|6,a[1]=(C_word)f_615,a[2]=((C_word*)t0)[2],a[3]=t3,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],a[6]=((C_word*)t0)[5],tmp=(C_word)a,a+=7,tmp);
if(C_truep(((C_word*)((C_word*)t0)[2])[1])){
t5=t4;
f_615(t5,C_i_setslot(((C_word*)((C_word*)t0)[2])[1],C_fix(1),t3));}
else{
t5=C_mutate2(((C_word *)((C_word*)t0)[6])+1,t3);
t6=t4;
f_615(t6,t5);}}

/* k1082 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1084(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[8],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_1084,2,t0,t1);}
t2=((C_word*)t0)[2];
t3=t1;
t4=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1067,a[2]=t2,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
t5=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_1070,a[2]=t4,a[3]=t3,tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#surface?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[28]))(3,*((C_word*)lf[28]+1),t5,t3);}

/* k543 in k540 in k537 */
static void C_ccall f_545(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_545,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_548,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_sdl2_2dinternals_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k546 in k543 in k540 in k537 */
static void C_ccall f_548(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_548,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_551,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_sdl2_2dinternals_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k852 in k848 in k844 in a834 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_854(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word ab[9],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_854,2,t0,t1);}
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,C_a_i_list3(&a,3,((C_word*)t0)[3],((C_word*)t0)[4],t1));}

/* k540 in k537 */
static void C_ccall f_542(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_542,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_545,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_chicken_2dsyntax_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* a855 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_856(C_word c,C_word t0,C_word t1,...){
C_word tmp;
C_word t2;
va_list v;
C_word *a,c2=c;
C_save_rest(t1,c2,2);
C_check_for_interrupt;
if(!C_demand(c*C_SIZEOF_PAIR+6)){
C_save_and_reclaim((void*)tr2r,(void*)f_856r,2,t0,t1);}
else{
a=C_alloc((c-2)*3);
t2=C_restore_rest(a,C_rest_count(0));
f_856r(t0,t1,t2);}}

static void C_ccall f_856r(C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word *a=C_alloc(6);
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_860,a[2]=t1,a[3]=t2,a[4]=((C_word*)t0)[2],a[5]=((C_word*)t0)[3],tmp=(C_word)a,a+=6,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:187: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t3,((C_word*)t0)[4]);}

/* k848 in k844 in a834 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_850(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_850,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_854,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t2,tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:202: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t3,((C_word*)t0)[4]);}

/* k1068 in k1082 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1070(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_1070,2,t0,t1);}
if(C_truep(t1)){
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1077,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#struct-null?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[27]))(3,*((C_word*)lf[27]+1),t2,((C_word*)t0)[3]);}
else{
t2=((C_word*)t0)[2];
f_1067(t2,C_SCHEME_FALSE);}}

/* k1075 in k1068 in k1082 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1077(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
f_1067(t2,C_i_not(t1));}

/* sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_889(C_word c,C_word t0,C_word t1,C_word t2){
C_word tmp;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word ab[12],*a=ab;
if(c!=3) C_bad_argc_2(c,3,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr3,(void*)f_889,3,t0,t1,t2);}
t3=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_933,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
t4=t3;
t5=C_a_i_bytevector(&a,1,C_fix(3));
t6=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_901,a[2]=t5,a[3]=t4,tmp=(C_word)a,a+=4,tmp);
if(C_truep(t2)){
t7=C_i_foreign_string_argumentp(t2);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:227: ##sys#make-c-string");
((C_proc3)C_fast_retrieve_symbol_proc(lf[29]))(3,*((C_word*)lf[29]+1),t6,t7);}
else{
t7=t6;
f_901(2,t7,C_SCHEME_FALSE);}}

/* k885 in sdl2-image#load in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_887(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
t2=((C_word*)t0)[2];
if(C_truep(t1)){
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:216: set-finalizer!");
((C_proc4)C_fast_retrieve_symbol_proc(lf[24]))(4,*((C_word*)lf[24]+1),t2,t1,C_fast_retrieve(lf[25]));}
else{
t3=t2;
((C_proc2)(void*)(*((C_word*)t3+1)))(2,t3,t1);}}

/* k537 */
static void C_ccall f_539(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_539,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_542,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_eval_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k1057 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1059(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word t6;
C_word ab[6],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_1059,2,t0,t1);}
t2=C_i_foreign_pointer_argumentp(t1);
t3=t2;
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1048,a[2]=((C_word*)t0)[2],a[3]=t3,a[4]=((C_word*)t0)[3],a[5]=((C_word*)t0)[4],tmp=(C_word)a,a+=6,tmp);
if(C_truep(((C_word*)t0)[5])){
t5=C_i_foreign_string_argumentp(((C_word*)t0)[5]);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:265: ##sys#make-c-string");
((C_proc3)C_fast_retrieve_symbol_proc(lf[29]))(3,*((C_word*)lf[29]+1),t4,t5);}
else{
t5=t4;
f_1048(2,t5,C_SCHEME_FALSE);}}

/* k1046 in k1057 in sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1048(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
t2=stub316(((C_word*)t0)[2],((C_word*)t0)[3],((C_word*)t0)[4],t1);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:265: g22");
((C_proc3)C_retrieve2_symbol_proc(lf[0],"sdl2-image#g22"))(3,lf[0],((C_word*)t0)[5],t2);}

/* toplevel */
static C_TLS int toplevel_initialized=0;
C_noret_decl(toplevel_trampoline)
static void C_fcall toplevel_trampoline(void *dummy) C_regparm C_noret;
C_regparm static void C_fcall toplevel_trampoline(void *dummy){
C_sdl2_2dimage_toplevel(2,C_SCHEME_UNDEFINED,C_restore);}

void C_ccall C_sdl2_2dimage_toplevel(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
if(toplevel_initialized) C_kontinue(t1,C_SCHEME_UNDEFINED);
else C_toplevel_entry(C_text("sdl2_2dimage_toplevel"));
C_check_nursery_minimum(3);
if(!C_demand(3)){
C_save(t1);
C_reclaim((void*)toplevel_trampoline,NULL);}
toplevel_initialized=1;
if(!C_demand_2(868)){
C_save(t1);
C_rereclaim2(868*sizeof(C_word), 1);
t1=C_restore;}
a=C_alloc(3);
C_initialize_lf(lf,39);
lf[1]=C_h_intern(&lf[1],27,"sdl2-internals#wrap-surface");
lf[3]=C_h_intern(&lf[3],27,"sdl2-internals#unwrap-rwops");
lf[7]=C_h_intern(&lf[7],16,"sdl2-image#init!");
lf[8]=C_decode_literal(C_heaptop,"\376\003\000\000\002\376\001\000\000\003jpg\376\003\000\000\002\376\001\000\000\003png\376\003\000\000\002\376\001\000\000\003tif\376\377\016");
lf[9]=C_h_intern(&lf[9],3,"jpg");
lf[10]=C_h_intern(&lf[10],3,"png");
lf[11]=C_h_intern(&lf[11],3,"tif");
lf[12]=C_h_intern(&lf[12],3,"map");
lf[13]=C_h_intern(&lf[13],11,"bitwise-ior");
lf[14]=C_h_intern(&lf[14],5,"error");
lf[15]=C_h_intern(&lf[15],5,"init!");
lf[16]=C_decode_literal(C_heaptop,"\376B\000\000\021invalid init flag");
lf[17]=C_h_intern(&lf[17],16,"sdl2-image#quit!");
lf[18]=C_h_intern(&lf[18],26,"sdl2-image#current-version");
lf[19]=C_h_intern(&lf[19],14,"pointer-u8-ref");
lf[20]=C_h_intern(&lf[20],4,"free");
lf[21]=C_h_intern(&lf[21],30,"sdl2-internals#%allocate-Uint8");
lf[22]=C_h_intern(&lf[22],27,"sdl2-image#compiled-version");
lf[23]=C_h_intern(&lf[23],15,"sdl2-image#load");
lf[24]=C_h_intern(&lf[24],14,"set-finalizer!");
lf[25]=C_h_intern(&lf[25],18,"sdl2#free-surface!");
lf[26]=C_h_intern(&lf[26],16,"sdl2-image#load\052");
lf[27]=C_h_intern(&lf[27],27,"sdl2-internals#struct-null\077");
lf[28]=C_h_intern(&lf[28],23,"sdl2-internals#surface\077");
lf[29]=C_h_intern(&lf[29],17,"\003sysmake-c-string");
lf[30]=C_h_intern(&lf[30],18,"sdl2-image#load-rw");
lf[31]=C_h_intern(&lf[31],19,"sdl2-image#load-rw\052");
lf[32]=C_h_intern(&lf[32],24,"sdl2-image#load-typed-rw");
lf[33]=C_h_intern(&lf[33],25,"sdl2-image#load-typed-rw\052");
lf[34]=C_h_intern(&lf[34],28,"\003sysregister-compiled-module");
lf[35]=C_h_intern(&lf[35],10,"sdl2-image");
lf[36]=C_decode_literal(C_heaptop,"\376\003\000\000\002\376\003\000\000\002\376\001\000\000\005init!\376\001\000\000\020sdl2-image#init!\376\003\000\000\002\376\003\000\000\002\376\001\000\000\005quit!\376\001\000\000\020sdl2-image#qui"
"t!\376\003\000\000\002\376\003\000\000\002\376\001\000\000\017current-version\376\001\000\000\032sdl2-image#current-version\376\003\000\000\002\376\003\000\000\002\376\001\000\000\020co"
"mpiled-version\376\001\000\000\033sdl2-image#compiled-version\376\003\000\000\002\376\003\000\000\002\376\001\000\000\004load\376\001\000\000\017sdl2-image"
"#load\376\003\000\000\002\376\003\000\000\002\376\001\000\000\005load\052\376\001\000\000\020sdl2-image#load\052\376\003\000\000\002\376\003\000\000\002\376\001\000\000\007load-rw\376\001\000\000\022sdl2-im"
"age#load-rw\376\003\000\000\002\376\003\000\000\002\376\001\000\000\010load-rw\052\376\001\000\000\023sdl2-image#load-rw\052\376\003\000\000\002\376\003\000\000\002\376\001\000\000\015load-ty"
"ped-rw\376\001\000\000\030sdl2-image#load-typed-rw\376\003\000\000\002\376\003\000\000\002\376\001\000\000\016load-typed-rw\052\376\001\000\000\031sdl2-image#"
"load-typed-rw\052\376\377\016");
lf[37]=C_h_intern(&lf[37],4,"eval");
lf[38]=C_decode_literal(C_heaptop,"\376\003\000\000\002\376\001\000\000\006import\376\003\000\000\002\376\003\000\000\002\376\001\000\000\006except\376\003\000\000\002\376\001\000\000\006scheme\376\003\000\000\002\376\001\000\000\004load\376\377\016\376\003\000\000\002\376\001\000\000\007"
"chicken\376\003\000\000\002\376\001\000\000\007foreign\376\003\000\000\002\376\001\000\000\007lolevel\376\003\000\000\002\376\003\000\000\002\376\001\000\000\004only\376\003\000\000\002\376\001\000\000\016sdl2-inter"
"nals\376\003\000\000\002\376\001\000\000\027define-function-binding\376\003\000\000\002\376\001\000\000\014struct-null\077\376\003\000\000\002\376\001\000\000\017%allocate-U"
"int8\376\003\000\000\002\376\001\000\000\010surface\077\376\003\000\000\002\376\001\000\000\016unwrap-surface\376\003\000\000\002\376\001\000\000\014wrap-surface\376\003\000\000\002\376\001\000\000\014un"
"wrap-rwops\376\003\000\000\002\376\001\000\000\012wrap-rwops\376\377\016\376\003\000\000\002\376\003\000\000\002\376\001\000\000\004only\376\003\000\000\002\376\001\000\000\004sdl2\376\003\000\000\002\376\001\000\000\015free"
"-surface!\376\377\016\376\377\016");
C_register_lf2(lf,39,create_ptable());
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_539,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
C_library_toplevel(2,C_SCHEME_UNDEFINED,t2);}

/* k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_752(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_752,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_755,a[2]=((C_word*)t0)[2],a[3]=t2,a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:179: sdl2-internals#%allocate-Uint8");
((C_proc2)C_fast_retrieve_symbol_proc(lf[21]))(2,*((C_word*)lf[21]+1),t3);}

/* k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_755(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word t5;
C_word ab[12],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_755,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_760,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t2,a[5]=((C_word)li3),tmp=(C_word)a,a+=6,tmp);
t4=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_781,a[2]=t2,a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[2],a[5]=((C_word)li4),tmp=(C_word)a,a+=6,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:169: ##sys#call-with-values");
C_call_with_values(4,0,((C_word*)t0)[4],t3,t4);}

/* k924 in k917 in k931 in sdl2-image#load* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_926(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
f_916(t2,C_i_not(t1));}

/* k861 in k858 in a855 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_863(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[4],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_863,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|3,a[1]=(C_word)f_866,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],tmp=(C_word)a,a+=4,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:187: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t2,((C_word*)t0)[4]);}

/* k864 in k861 in k858 in a855 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_866(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
C_apply_values(3,0,((C_word*)t0)[2],((C_word*)t0)[3]);}

/* k997 in k990 in k1004 in sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_999(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word *a;
t2=((C_word*)t0)[2];
f_989(t2,C_i_not(t1));}

/* k858 in a855 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_860(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_860,2,t0,t1);}
t2=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_863,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=((C_word*)t0)[4],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:187: free");
((C_proc3)C_fast_retrieve_symbol_proc(lf[20]))(3,*((C_word*)lf[20]+1),t2,((C_word*)t0)[5]);}

/* k990 in k1004 in sdl2-image#load-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_992(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word ab[3],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_992,2,t0,t1);}
if(C_truep(t1)){
t2=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_999,a[2]=((C_word*)t0)[2],tmp=(C_word)a,a+=3,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:210: sdl2-internals#struct-null?");
((C_proc3)C_fast_retrieve_symbol_proc(lf[27]))(3,*((C_word*)lf[27]+1),t2,((C_word*)t0)[3]);}
else{
t2=((C_word*)t0)[2];
f_989(t2,C_SCHEME_FALSE);}}

/* sdl2-image#load-typed-rw* in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1032(C_word c,C_word t0,C_word t1,C_word t2,C_word t3,C_word t4){
C_word tmp;
C_word t5;
C_word t6;
C_word t7;
C_word t8;
C_word t9;
C_word t10;
C_word t11;
C_word ab[14],*a=ab;
if(c!=5) C_bad_argc_2(c,5,t0);
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr5,(void*)f_1032,5,t0,t1,t2,t3,t4);}
t5=(*a=C_CLOSURE_TYPE|2,a[1]=(C_word)f_1084,a[2]=t1,tmp=(C_word)a,a+=3,tmp);
t6=t5;
t7=t3;
t8=t4;
t9=C_a_i_bytevector(&a,1,C_fix(3));
t10=(*a=C_CLOSURE_TYPE|5,a[1]=(C_word)f_1059,a[2]=t9,a[3]=t7,a[4]=t6,a[5]=t8,tmp=(C_word)a,a+=6,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:265: g26");
((C_proc3)C_retrieve2_symbol_proc(lf[2],"sdl2-image#g26"))(3,lf[2],t10,t2);}

/* k1028 in sdl2-image#load-typed-rw in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_1030(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word *a;
t2=((C_word*)t0)[2];
if(C_truep(t1)){
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:216: set-finalizer!");
((C_proc4)C_fast_retrieve_symbol_proc(lf[24]))(4,*((C_word*)lf[24]+1),t2,t1,C_fast_retrieve(lf[25]));}
else{
t3=t2;
((C_proc2)(void*)(*((C_word*)t3+1)))(2,t3,t1);}}

/* k773 in k769 in a759 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_775(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_775,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_779,a[2]=((C_word*)t0)[2],a[3]=((C_word*)t0)[3],a[4]=t2,tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:183: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t3,((C_word*)t0)[4]);}

/* k777 in k773 in k769 in a759 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_779(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word ab[9],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_779,2,t0,t1);}
t2=((C_word*)t0)[2];
((C_proc2)(void*)(*((C_word*)t2+1)))(2,t2,C_a_i_list3(&a,3,((C_word*)t0)[3],((C_word*)t0)[4],t1));}

/* k769 in a759 in k753 in k750 in k747 in sdl2-image#current-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_771(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_771,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_775,a[2]=((C_word*)t0)[2],a[3]=t2,a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:182: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t3,((C_word*)t0)[4]);}

/* k844 in a834 in k828 in k825 in k822 in sdl2-image#compiled-version in k555 in k552 in k549 in k546 in k543 in k540 in k537 */
static void C_ccall f_846(C_word c,C_word t0,C_word t1){
C_word tmp;
C_word t2;
C_word t3;
C_word t4;
C_word ab[5],*a=ab;
C_check_for_interrupt;
if(!C_stack_probe(&a)){
C_save_and_reclaim((void*)tr2,(void*)f_846,2,t0,t1);}
t2=t1;
t3=(*a=C_CLOSURE_TYPE|4,a[1]=(C_word)f_850,a[2]=((C_word*)t0)[2],a[3]=t2,a[4]=((C_word*)t0)[3],tmp=(C_word)a,a+=5,tmp);
C_trace("libs/chicken-sdl2-image/sdl2-image.scm:201: pointer-u8-ref");
((C_proc3)C_fast_retrieve_proc(*((C_word*)lf[19]+1)))(3,*((C_word*)lf[19]+1),t3,((C_word*)t0)[4]);}

#ifdef C_ENABLE_PTABLES
static C_PTABLE_ENTRY ptable[68] = {
{"f_760:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_760},
{"f_871:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_871},
{"f_1014:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1014},
{"f_712:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_712},
{"f_827:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_827},
{"f_824:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_824},
{"f_954:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_954},
{"f_1006:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1006},
{"f_641:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_641},
{"f_785:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_785},
{"f_788:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_788},
{"f_781:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_781},
{"f_989:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_989},
{"f_981:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_981},
{"f_647:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_647},
{"f_644:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_644},
{"f_704:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_704},
{"f_1067:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1067},
{"f_721:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_721},
{"f_835:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_835},
{"f_830:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_830},
{"f_901:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_901},
{"f_682:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_682},
{"f_919:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_919},
{"f_916:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_916},
{"f_749:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_749},
{"f_602:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_602},
{"f_600:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_600},
{"f_935:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_935},
{"f_933:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_933},
{"f_615:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_615},
{"f_557:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_557},
{"f_554:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_554},
{"f_796:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_796},
{"f_962:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_962},
{"f_791:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_791},
{"f_551:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_551},
{"f_631:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_631},
{"f_1084:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1084},
{"f_545:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_545},
{"f_548:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_548},
{"f_854:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_854},
{"f_542:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_542},
{"f_856:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_856},
{"f_850:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_850},
{"f_1070:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1070},
{"f_1077:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1077},
{"f_889:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_889},
{"f_887:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_887},
{"f_539:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_539},
{"f_1059:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1059},
{"f_1048:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1048},
{"toplevel:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)C_sdl2_2dimage_toplevel},
{"f_752:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_752},
{"f_755:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_755},
{"f_926:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_926},
{"f_863:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_863},
{"f_866:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_866},
{"f_999:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_999},
{"f_860:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_860},
{"f_992:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_992},
{"f_1032:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1032},
{"f_1030:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_1030},
{"f_775:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_775},
{"f_779:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_779},
{"f_771:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_771},
{"f_846:libs_2fchicken_2dsdl2_2dimage_2fsdl2_2dimage_2escm",(void*)f_846},
{NULL,NULL}};
#endif

static C_PTABLE_ENTRY *create_ptable(void){
#ifdef C_ENABLE_PTABLES
return ptable;
#else
return NULL;
#endif
}

/*
o|hiding nonexported module bindings: sdl2-image#g21 
o|hiding nonexported module bindings: sdl2-image#g22 
o|hiding nonexported module bindings: sdl2-image#g26 
o|hiding nonexported module bindings: sdl2-image#g27 
o|hiding nonexported module bindings: sdl2-image#with-temp-mem 
o|hiding nonexported module bindings: sdl2-image#IMG_INIT_JPG 
o|hiding nonexported module bindings: sdl2-image#IMG_INIT_PNG 
o|hiding nonexported module bindings: sdl2-image#IMG_INIT_TIF 
o|hiding nonexported module bindings: sdl2-image#%pack-init-flags 
o|hiding nonexported module bindings: sdl2-image#%unpack-init-flags 
S|applied compiler syntax:
S|  map		1
o|eliminated procedure checks: 16 
o|removed side-effect free assignment to unused variable: sdl2-image#g21 
o|removed side-effect free assignment to unused variable: sdl2-image#g27 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:155) sdl2-image#%unpack-init-flags" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:156) IMG_Init155" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:156) sdl2-image#%pack-init-flags" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:162) IMG_Quit165" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:180) foreign-getter177" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:199) foreign-getter209" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:223) g235236" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:231) g250251" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:231) IMG_Load242" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:239) g268269" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:250) g294295" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:250) IMG_Load_RW286" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:258) g303304" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:271) g324325" 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:271) IMG_LoadTyped_RW312" 
o|replaced variables: 98 
o|removed binding forms: 61 
o|substituted constant variable: fn-name101 
o|replaced variables: 17 
o|removed binding forms: 96 
o|contracted procedure: "(libs/chicken-sdl2-image/sdl2-image.scm:130) g110119" 
o|replaced variables: 12 
o|removed binding forms: 11 
o|removed binding forms: 6 
o|simplifications: ((if . 12) (##core#call . 48)) 
o|  call simplifications:
o|    ##sys#foreign-string-argument	2
o|    not	3
o|    ##sys#call-with-values	2
o|    ##sys#foreign-pointer-argument	8
o|    list	5
o|    null?	3
o|    car	3
o|    ##sys#check-list
o|    pair?
o|    eqv?	3
o|    ##sys#setslot
o|    ##sys#slot	2
o|    apply	3
o|    ##sys#foreign-fixnum-argument
o|    bitwise-and	3
o|    zero?	3
o|    cons	4
o|contracted procedure: k705 
o|contracted procedure: k684 
o|contracted procedure: k656 
o|contracted procedure: k648 
o|contracted procedure: k652 
o|contracted procedure: k667 
o|contracted procedure: k659 
o|contracted procedure: k663 
o|contracted procedure: k678 
o|contracted procedure: k670 
o|contracted procedure: k674 
o|contracted procedure: k691 
o|contracted procedure: k595 
o|contracted procedure: k607 
o|contracted procedure: k610 
o|contracted procedure: k621 
o|contracted procedure: k633 
o|contracted procedure: k577 
o|contracted procedure: k583 
o|contracted procedure: k589 
o|contracted procedure: k727 
o|contracted procedure: k731 
o|contracted procedure: k735 
o|contracted procedure: k802 
o|contracted procedure: k806 
o|contracted procedure: k810 
o|contracted procedure: k906 
o|contracted procedure: k955 
o|contracted procedure: k937 
o|contracted procedure: k1007 
o|contracted procedure: k964 
o|contracted procedure: k975 
o|contracted procedure: k1042 
o|contracted procedure: k1053 
o|contracted procedure: k1086 
o|contracted procedure: k1090 
o|contracted procedure: k1094 
o|simplifications: ((let . 4)) 
o|removed binding forms: 37 
o|substituted constant variable: r1087 
o|substituted constant variable: r1091 
o|substituted constant variable: r1087 
o|substituted constant variable: r1091 
o|substituted constant variable: r1095 
o|replaced variables: 33 
o|removed binding forms: 24 
o|contracted procedure: k698 
o|contracted procedure: k762 
o|contracted procedure: k837 
o|removed binding forms: 3 
o|customizable procedures: (k1065 k987 k914 k613 map-loop104128 k639 k642 k645) 
o|calls to known targets: 21 
o|fast box initializations: 2 
o|fast global references: 11 
o|fast global assignments: 5 
*/
/* end of file */
