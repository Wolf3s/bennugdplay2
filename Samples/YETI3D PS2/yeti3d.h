/*
 YETI3D ENGINE

  y
  ^     z
  !   /
  ! /
  *------->x

  (c) Derek John Evans





  New YETI3D previews..
  http://code.google.com/p/yeti3dplusplus/

  Bennu Wrapper by - Colombian Developers - Team
  http://coldev.blogspot.com/
  http://coldev.cjb.net

*/
import "yeti3d";

/******************************************************************************/
//fix math

#define FIXONE  0x100
#define FIXHALF 0x80
#define FIXCEIL 0xFF

#define f2i(A) ((A)>>8)
#define i2f(A) ((A)<<8)
#define r2i(A) ((A)>>16)
#define i2fdiv2(A) ((A)<<7)
#define f2fl(A) ((A)/256.0)
#define fl2f(A) ((A)*256.0)
#define fixtrunc(A) i2f(f2i(A))
#define fixfrac(A) ((A)&FIXCEIL)
#define FIXLERP(A,B,C) ((A)+fixmul((B)-(A),(C)))
#define FIXSQR(A) fixmul(A,A)
#define fixup(A) f2i((A)+FIXCEIL)
#define fixinv(A) fixdiv(FIXUNIT,(A))
#define intdiv(A,B) ((A)/(B))
#define intmul(A,B) ((A)*(B))
#define muldiv(A,B,C) intdiv(intmul(A,B),(C))
#define fixmul(A,B) f2i(intmul(A,B))
#define fixmul2(A,B) intmul((A)>>4,(B)>>4)
#define fixdiv(A,B) intdiv(i2f((A)),(B))
#define fixdiv64(A,B) fixdiv((s64)(A),B)
#define FIXDIVXX(A,B) ((u32)(((s32)(A)>>23)+1)<2?fixdiv(A,B):fixdiv64(A,B))
#define FIXDOT(A,B) f2i((A)[0]*(B)[0]+(A)[1]*(B)[1]+(A)[2]*(B)[2])

#define YETI_FIXPOW(A)    (A * A)
#define YETI_GETDISTANCE(A,B)   (  YETI_FIXSQRT(  YETI_FIXPOW( F2I(B.x - A.x) )  +  YETI_FIXPOW( F2I(B.y - A.y)  )  )    )
#define YETI_GETDISTANCE_POINT(X1,Y1,X2,Y2)   (  YETI_FIXSQRT(  YETI_FIXPOW(  F2I( X2 - X1)   )  +  YETI_FIXPOW(  F2I( Y2 - Y1)  )  )    )



#define YETI_RECIPROCAL_MIN 0
#define YETI_RECIPROCAL_MAX 16384
#define YETI_SINTABLE_MAX 2048


#define DEG_1   i2f(1)
#define DEG_45  i2f(32)
#define DEG_90  i2f(64)
#define DEG_180 i2f(128)
#define DEG_270 i2f(192)
#define DEG_360 i2f(256)


/******************************************************************************/



//MD2 ANIMATION
#define LOOP_ONCE     1
#define LOOP_FOREVER  100

//RENDER EFFECTS
#define PIXEL_FILTER_NORMAL     0
#define PIXEL_FILTER_GOLDEN     1
#define PIXEL_FILTER_MURKY      2
#define PIXEL_FILTER_BROWN      3
#define PIXEL_FILTER_HORROR     4
#define PIXEL_FILTER_GRAYSCALE  5


//DRAW MODES
#define DRAW_MODE_COLORKEY        (0)
#define DRAW_MODE_COLORKEY_BLEND  (1)
#define DRAW_MODE_BLEND           (2)
#define DRAW_MODE_BLEND_DITHER    (3)
#define DRAW_MODE_COPY            (4)
#define DRAW_MODE_COPY_DITHER     (5)
#define DRAW_MODE_COPY_HALFBRIGHT (6)


//MD2 ANIMATIONS
/*
    {  0, 40},    //MD2_ANIM_STAND
    { 40,  6},    //MD2_ANIM_RUN
    { 46,  8},    //MD2_ANIM_ATTACK
    { 54,  4},    //MD2_ANIM_PAIN1
    { 58,  4},    //MD2_ANIM_PAIN2
    { 62,  4},    //MD2_ANIM_PAIN3
    { 66,  6},    //MD2_ANIM_JUMP
    { 72, 12},    //MD2_ANIM_FLIPOFF
    { 84, 11},    //MD2_ANIM_SALUTE
    { 95, 17},    //MD2_ANIM_TAUNT
    {112, 11},    //MD2_ANIM_WAVE
    {123, 12},    //MD2_ANIM_POINT
    {135, 19},    //MD2_ANIM_CROUCH_STAND
    {154,  6},    //MD2_ANIM_CROUCH_WALK
    {160,  9},    //MD2_ANIM_CROUCH_ATTACK
    {169,  4},    //MD2_ANIM_CROUCH_PAIN
    {173,  5},    //MD2_ANIM_CROUCH_DEATH
    {178,  6},    //MD2_ANIM_DEATH1
    {184,  6},    //MD2_ANIM_DEATH2
    {190,  8}     //MD2_ANIM_DEATH3
*/



//ENTITY TYPES
#define TYPE_SPRITE3D  		0
#define TYPE_MODEL3D   		1








type TYPE_ENTITY_3D
  int   radius;         // 8:8 entity radius.
  int   x, xx;          // 8:8 X position and velocity.
  int   y, yy;          // 8:8 Y position and velocity.
  int   z, zz;          // 8:8 Z position and velocity.
  int   p, pp;          // Pitch and pitch velocity.
  int   r, rr;          // Roll and roll velocity.
  int   t, tt;          // Turn and turn velocity.
  int   rx;             // View space X position.
  int   ry;             // View space Y position
  int   rz;             // View space Z position

  int    emitlight;    // Entity emits light.
  int    castshadow;
  int    nocollision;   //fisica de colisiones
  int    alwaysvisible;
  int    alwaysontop;

  int DetectedCollisionWithEntity;//Ent-Ent Cols
  int DetectedCollisionWithEntityId;// id entity collided
  int DetectedCollisionWithWall; // Cells

  int Msg;
  int Fixz;
  int nocollisionwall;   //no colision con paredes
  float ScaleModel;  //escalar modelo 3d

  int yetient;//internal use
end;


type TYPE_CELL_3D
  int  swi;  // Cell flags.
  int  ent;  // Entity Id. Used for setting start locations for entities.
  int top;  // 8:8 fixed point cell top value.
  int bot;  // 8:8 fixed point cell bot value.
  int eos;  // Entity offset.
  int hos;  // Height offset.
  int  tos;  // Top offset. Used for caves.
  int  bos;  // Bottom offset. Used for terrains.
  int bots[4];
  int tops[4];

  int  wtb;  // Cell wall bot texture id.
  int  sw2;
  int lit;  // Cell light setting.
  int  wtt;  // Cell wall top texture id.
  int  ttx;  // Cell top texture id.
  int  btx;  // Cell bot texture id.
  int  wwi;  // Wall warp index.

  int  xlod;
  int  ylod;
  int mark;

  int pcell; //internal use only
end;




// These cell flags are stored in both the engine and yeti maps.
#define CELL_SWI_LIGHT      1
#define CELL_SWI_SOLID      2
#define CELL_SWI_TERRAIN    4
#define CELL_SWI_WARPED     8
#define CELL_SWI_LUA_0      0
#define CELL_SWI_LUA_1      16
#define CELL_SWI_LUA_2      32
#define CELL_SWI_LUA_3      48
#define CELL_SWI_LUA_MASK   48
#define CELL_SWI_CAVE       64
#define CELL_SWI_SELECTED   128

// These switchs are for the new extra switchs in cell.ext.swi
#define CELL_SW2_LIGHT0       0
#define CELL_SW2_LIGHT1       1
#define CELL_SW2_LIGHT2       2
#define CELL_SW2_LIGHT3       3
#define CELL_SW2_LIGHT_MASK   3
#define CELL_SW2_OVERPASS     4
#define CELL_SW2_HALFBRIGHT   128

/******************************************************************************/

#define CELL_IS_SOLID(A)      ((A).swi & CELL_SWI_SOLID)
#define CELL_IS_WARPED(A)     ((A).swi & CELL_SWI_WARPED)
#define CELL_IS_SELECTED(A)   ((A).swi & CELL_SWI_SELECTED)
#define CELL_IS_TERRAIN(A)    ((A).swi & CELL_SWI_TERRAIN)
#define CELL_IS_CAVE(A)       ((A).swi & CELL_SWI_CAVE)
#define CELL_IS_OVERPASS(A)   ((A).sw2 & CELL_SW2_OVERPASS)
#define CELL_IS_OUTSIDE(A)    ((A).ttx == TEXTURE_SKY && !CELL_IS_SOLID(A))
#define CELL_IS_OPAQUE(A)     (CELL_IS_SOLID(A) && !CELL_IS_WARPED(A))

/******************************************************************************/

#define CELL_LUA(A) (((A).swi & CELL_SWI_LUA_MASK) >> 4)

#define CELL_VCACHE_MAX 3
#define CELL_LIGHT_MIN i2f(2)
#define CELL_LIGHT_MAX i2f(63)
#define CELL_LIGHT_SKY i2f(32)

/******************************************************************************/

//textures codes
#define TEXTURE_BOT      5
#define TEXTURE_TOP      35
#define TEXTURE_WALL     11
#define TEXTURE_WATER    32
#define TEXTURE_LAVA     33
#define TEXTURE_SKY      35
#define TEXTURE_LIGHT1   96
#define TEXTURE_LIGHT2   109

/******************************************************************************/

#define TEXTURE_IS_SKY(A) ((A) == TEXTURE_SKY)
#define TEXTURE_IS_LAVA(A) ((A) == TEXTURE_LAVA)
#define TEXTURE_IS_WATER(A) ((A) == TEXTURE_WATER)


#define TEXTURE_IS_BRIGHT(A) (\
  (A) == TEXTURE_SKY     ||\
  (A) == TEXTURE_WATER   ||\
  (A) == TEXTURE_LAVA    ||\
  (A) == TEXTURE_LIGHT1  ||\
  (A) == TEXTURE_LIGHT2)

#define TEXTURE_IS_LIQUID(A) (\
  (A) == TEXTURE_WATER || \
  (A) == TEXTURE_LAVA )

// The maxium number of textures allowed.
#define TEXTURE_MAX     128
// The default texture size.
#define TEXTURE_WIDTH   64
#define TEXTURE_HEIGHT  64
/******************************************************************************/
