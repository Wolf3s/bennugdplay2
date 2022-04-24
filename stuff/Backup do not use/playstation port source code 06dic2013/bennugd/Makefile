EE_BIN = bennugd.elf
EE_OBJS = core/bgdi/src/main.o \
core/bgdrtm/src/copy.o core/bgdrtm/src/dcbr.o core/bgdrtm/src/dirs.o core/bgdrtm/src/instance.o \
core/bgdrtm/src/interpreter.o core/bgdrtm/src/misc.o core/bgdrtm/src/strings.o \
core/bgdrtm/src/sysprocs.o core/bgdrtm/src/varspace_file.o \
core/common/debug.o core/common/files.o core/common/xctype.o \
modules/libblit/g_blit.o modules/libblit/g_pixel.o modules/libblit/libblit.o  \
modules/libdraw/libdraw.o \
modules/libfont/libfont.o \
modules/libgrbase/g_bitmap.o modules/libgrbase/g_blendop.o  modules/libgrbase/g_clear.o  \
modules/libgrbase/g_conversion.o modules/libgrbase/g_grlib.o  modules/libgrbase/g_pal.o \
modules/libgrbase/libgrbase.o \
modules/libjoy/libjoy.o \
modules/libkey/libkey.o \
modules/libmouse/libmouse.o \
modules/librender/g_fade.o modules/librender/g_frame.o modules/librender/g_instance.o \
modules/librender/g_object.o modules/librender/g_rects.o modules/librender/g_screen.o \
modules/librender/librender.o modules/librender/scaler_hq2x.o modules/librender/scaler_normal.o \
modules/librender/scaler_scale2x.o modules/librender/scaler_scanline.o \
modules/libscroll/libscroll.o \
modules/libsdlhandler/libsdlhandler.o  \
modules/libtext/libtext.o \
modules/libvideo/g_regions.o modules/libvideo/g_video.o \
modules/libwm/libwm.o \
modules/mod_blendop/mod_blendop.o \
modules/mod_cd/mod_cd.o \
modules/mod_debug/mod_debug.o modules/mod_debug/systexts.o \
modules/mod_dir/mod_dir.o \
modules/mod_draw/mod_draw.o \
modules/mod_effects/mod_effects.o \
modules/mod_file/mod_file.o \
modules/mod_flic/mod_flic.o \
modules/mod_grproc/mod_grproc.o \
modules/mod_joy/mod_joy.o \
modules/mod_key/mod_key.o \
modules/mod_m7/mod_m7.o \
modules/mod_map/file_fnt.o \
modules/mod_map/file_fpg.o \
modules/mod_map/file_map.o \
modules/mod_map/file_pal.o \
modules/mod_map/file_pcx.o \
modules/mod_map/file_png.o \
modules/mod_map/mod_map.o \
modules/mod_math/mod_math.o \
modules/mod_mathi/mod_mathi.o \
modules/mod_mem/mod_mem.o \
modules/mod_path/mod_path.o \
modules/mod_proc/mod_proc.o \
modules/mod_rand/mod_rand.o \
modules/mod_regex/mod_regex.o modules/mod_regex/regex.o \
modules/mod_say/mod_say.o \
modules/mod_screen/mod_screen.o \
modules/mod_scroll/mod_scroll.o \
modules/mod_sort/mod_sort.o \
modules/mod_sound/mod_sound.o \
modules/mod_string/mod_string.o \
modules/mod_sys/mod_sys.o \
modules/mod_text/mod_text.o \
modules/mod_time/mod_time.o \
modules/mod_timers/mod_timers.o \
modules/mod_video/mod_video.o \
modules/mod_wm/mod_wm.o \
yeti3d/source/main.o \
yeti3d/source/game/entities.o \
yeti3d/source/game/game.o \
yeti3d/source/game/maps.o \
yeti3d/source/game/models.o \
yeti3d/source/game/screens.o \
yeti3d/source/game/ai/boost.o \
yeti3d/source/game/ai/bullet.o \
yeti3d/source/game/ai/death.o \
yeti3d/source/game/ai/explode.o \
yeti3d/source/game/ai/pickup.o \
yeti3d/source/game/ai/quad.o \
yeti3d/source/game/ai/sheba.o \
yeti3d/source/game/ai/static_model.o \
yeti3d/source/game/ai/static_sprite.o \
yeti3d/source/game/ai/teleporter.o \
yeti3d/source/game/ai/torch.o \
yeti3d/source/y3d/y3d_animation.o \
yeti3d/source/y3d/y3d_ansic.o \
yeti3d/source/y3d/y3d_cell.o \
yeti3d/source/y3d/y3d_draw.o \
yeti3d/source/y3d/y3d_engine.o \
yeti3d/source/y3d/y3d_entity.o \
yeti3d/source/y3d/y3d_file.o \
yeti3d/source/y3d/y3d_fixed.o \
yeti3d/source/y3d/y3d_fruity.o \
yeti3d/source/y3d/y3d_image.o \
yeti3d/source/y3d/y3d_keyboard.o \
yeti3d/source/y3d/y3d_map.o \
yeti3d/source/y3d/y3d_matrix.o \
yeti3d/source/y3d/y3d_pixel.o \
yeti3d/source/y3d/y3d_record.o \
yeti3d/source/y3d/y3d_sound.o \
yeti3d/source/y3d/y3d_spanner.o \
yeti3d/source/y3d/y3d_surface.o \
yeti3d/source/y3d/y3d_vertex.o \
yeti3d/source/y3d/y3d_yeti.o \
mod_ps2/main.o \
usbd.s  usbhdfsd.s


EE_LIBS = -lc  -audsrv -lmc -lm -lpatches -lcdvd  -lz  -lsdlmixer -lpng -lsdlmain -lsdl
EE_INCS = -I$(PS2DEV)/common/include -I$(PS2LIB)/ee/include

all: $(EE_BIN)

#usbd.s : usbd.irx
#	bin2s usbd.irx usbd.s usbd

#usbhdfsd.s : usbhdfsd.irx
#	bin2s usbhdfsd.irx usbhdfsd.s usbhdfsd


clean:
	rm -f *.elf *.o *.s

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal


