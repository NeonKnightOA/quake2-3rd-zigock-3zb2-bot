#
# Makefile for 3rd zigock 2 bot
# gcc / Linux-i586
# Mon J�n 21 01:47:58 CET 2002
#

CC=gcc

ARCH=i586

#DEBUG=-g -Wall #-D_DEBUG
OPTIM=-mtune=i586 -march=i586 -O3 -ffast-math -funroll-loops \
	-falign-loops=2 -falign-jumps=2 -falign-functions=2 \
	-fexpensive-optimizations -pipe
	#-fomit-frame-pointer # 2.96 has problems with this one

CFLAGS=$(DEBUG)$(OPTIM) -Dstricmp=strcasecmp

SHLIBEXT=so
SHLIBCFLAGS=-fPIC
SHLIBLDFLAGS=-shared

OBJS=bot.o\
	bot_fire.o\
	bot_func.o\
	bot_za.o\
	g_chase.o\
	g_cmds.o\
	g_combat.o\
	g_ctf.o\
	g_func.o\
	g_items.o\
	g_main.o\
	g_misc.o\
	g_monster.o\
	g_phys.o\
	g_save.o\
	g_spawn.o\
	g_svcmds.o\
	g_target.o\
	g_trigger.o\
	g_turret.o\
	g_utils.o\
	g_weapon.o\
	m_move.o\
	p_client.o\
	p_hud.o\
	p_menu.o\
	p_trail.o\
	p_view.o\
	p_weapon.o\
	q_shared.o

.c.o:
	$(CC) $(CFLAGS) $(SHLIBCFLAGS) -o $@ -c $<

game$(ARCH).$(SHLIBEXT): $(OBJS)
	$(CC) $(CFLAGS) $(SHLIBLDFLAGS) -o $@ $(OBJS)

install: game.so
	cp game.so ..

#
# misc
#

.PHONY : clean tags depend dist
clean :
	-rm -f zwadconv $(OBJS) game$(ARCH).$(SHLIBEXT) *~

tags:
	ctags *.[ch]
	cscope -b
depend:
	gcc -M $(OBJS:.o=.c) >.depend

DISTFILES=Makefile\
	game.def game.dsp\
	bot.c\
	bot.h\
	bot_fire.c\
	bot_func.c\
	botstr.h\
	bot_za.c\
	game.h\
	g_chase.c\
	g_cmds.c\
	g_combat.c\
	g_ctf.c\
	g_ctf.h\
	g_func.h\
	g_items.c\
	g_local.h\
	g_main.c\
	g_misc.c\
	g_monster.c\
	g_phys.c\
	g_save.c\
	g_spawn.c\
	g_svcmds.c\
	g_target.c\
	g_trigger.c\
	g_turret.c\
	g_utils.c\
	g_weapon.c\
	m_move.c\
	m_player.h\
	p_client.c\
	p_hud.c\
	p_menu.c\
	p_menu.h\
	p_trail.c\
	p_view.c\
	p_weapon.c\
	q_shared.c\
	q_shared.h

DATE=`date +%y%m%d`

dist:
	@( cd .. && echo $(DISTFILES) | \
	sed -e "s: : src/:g" -e "s:^:src/:" | \
	xargs tar cvfj crbot-src-$(DATE).tar.bz2 )
	@zip -r ../crbot-src-$(DATE).zip $(DISTFILES)
