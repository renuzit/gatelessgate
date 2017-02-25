
ACLOCAL_AMFLAGS = -I m4

JANSSON_CPPFLAGS= -I$(top_builddir)/submodules/jansson/src -I$(top_srcdir)/submodules/jansson/src

EXTRA_DIST	= example.conf m4/gnulib-cache.m4 \
		  ADL_SDK/readme.txt api-example.php miner.php	\
		  API.class API.java api-example.c hexdump.c \
		  doc/API doc/FAQ doc/GPU doc/SCRYPT doc/windows-build.txt

SUBDIRS		= lib submodules ccan sph

bin_PROGRAMS     = gatelessgate

gatelessgate_CPPFLAGS = $(PTHREAD_FLAGS) -std=gnu99 $(JANSSON_CPPFLAGS)
gatelessgate_LDFLAGS  = $(PTHREAD_FLAGS)
gatelessgate_LDADD    = $(DLOPEN_FLAGS) @LIBCURL_LIBS@ @JANSSON_LIBS@ @PTHREAD_LIBS@ \
		  @OPENCL_LIBS@ @NCURSES_LIBS@ @PDCURSES_LIBS@ @WS2_LIBS@ \
		  @MM_LIBS@ @RT_LIBS@ @MATH_LIBS@ lib/libgnu.a ccan/libccan.a sph/libsph.a

gatelessgate_CPPFLAGS += -I$(top_builddir)/lib -I$(top_srcdir)/lib @OPENCL_FLAGS@ @LIBCURL_CFLAGS@

if HAVE_WINDOWS
gatelessgate_LDFLAGS += -all-static -Wl,--stack,4194304
endif

gatelessgate_CPPFLAGS += $(ADL_CPPFLAGS)

if USE_GIT_VERSION
GIT_VERSION      := $(shell sh -c 'git describe --abbrev=4 --dirty')
gatelessgate_CPPFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"
endif

if USE_BUILD_NUMBER
gatelessgate_CPPFLAGS += -DBUILD_NUMBER=\"$(BUILD_NUMBER)\"
endif

gatelessgate_SOURCES := gatelessgate.c
gatelessgate_SOURCES	+= api.c api.h
gatelessgate_SOURCES	+= elist.h miner.h compat.h bench_block.h
gatelessgate_SOURCES	+= util.c util.h uthash.h
gatelessgate_SOURCES	+= logging.c logging.h
gatelessgate_SOURCES += driver-opencl.c driver-opencl.h
gatelessgate_SOURCES += ocl.c ocl.h
gatelessgate_SOURCES += findnonce.c findnonce.h
gatelessgate_SOURCES += adl.c adl.h adl_functions.h
gatelessgate_SOURCES += sysfs-gpu-controls.c sysfs-gpu-controls.h
gatelessgate_SOURCES += pool.c pool.h
gatelessgate_SOURCES += algorithm.c algorithm.h
gatelessgate_SOURCES += config_parser.c config_parser.h
gatelessgate_SOURCES += events.c events.h
gatelessgate_SOURCES += ocl/build_kernel.c ocl/build_kernel.h
gatelessgate_SOURCES += ocl/binary_kernel.c ocl/binary_kernel.h

gatelessgate_SOURCES += kernel/*.cl
gatelessgate_SOURCES += algorithm/scrypt.c algorithm/scrypt.h
gatelessgate_SOURCES += algorithm/darkcoin.c algorithm/darkcoin.h
gatelessgate_SOURCES += algorithm/qubitcoin.c algorithm/qubitcoin.h
gatelessgate_SOURCES += algorithm/quarkcoin.c algorithm/quarkcoin.h
gatelessgate_SOURCES += algorithm/myriadcoin-groestl.c algorithm/myriadcoin-groestl.h
gatelessgate_SOURCES += algorithm/fuguecoin.c algorithm/fuguecoin.h
gatelessgate_SOURCES += algorithm/inkcoin.c algorithm/inkcoin.h
gatelessgate_SOURCES += algorithm/animecoin.c algorithm/animecoin.h
gatelessgate_SOURCES += algorithm/groestlcoin.c algorithm/groestlcoin.h
gatelessgate_SOURCES += algorithm/sifcoin.c algorithm/sifcoin.h
gatelessgate_SOURCES += algorithm/twecoin.c algorithm/twecoin.h
gatelessgate_SOURCES += algorithm/marucoin.c algorithm/marucoin.h
gatelessgate_SOURCES += algorithm/maxcoin.c algorithm/maxcoin.h
gatelessgate_SOURCES += algorithm/talkcoin.c algorithm/talkcoin.h
gatelessgate_SOURCES += algorithm/bitblock.c algorithm/bitblock.h
gatelessgate_SOURCES += algorithm/x14.c algorithm/x14.h
gatelessgate_SOURCES += algorithm/fresh.c algorithm/fresh.h
gatelessgate_SOURCES += algorithm/whirlcoin.c algorithm/whirlcoin.h
gatelessgate_SOURCES += algorithm/neoscrypt.c algorithm/neoscrypt.h
gatelessgate_SOURCES += algorithm/whirlpoolx.c algorithm/whirlpoolx.h
gatelessgate_SOURCES += algorithm/lyra2re.c algorithm/lyra2re.h algorithm/lyra2.c algorithm/lyra2.h algorithm/sponge.c algorithm/sponge.h
gatelessgate_SOURCES += algorithm/lyra2rev2.c algorithm/lyra2rev2.h
gatelessgate_SOURCES += algorithm/pluck.c algorithm/pluck.h
gatelessgate_SOURCES += algorithm/credits.c algorithm/credits.h
gatelessgate_SOURCES += algorithm/yescrypt.h algorithm/yescrypt.c algorithm/yescrypt_core.h algorithm/yescrypt-opt.c algorithm/yescryptcommon.c algorithm/sysendian.h
gatelessgate_SOURCES += algorithm/blake256.c algorithm/blake256.h
gatelessgate_SOURCES += algorithm/blakecoin.c algorithm/blakecoin.h
gatelessgate_SOURCES += algorithm/ethash.c algorithm/ethgencache.c algorithm/ethash.h algorithm/eth-sha3.c algorithm/eth-sha3.h
gatelessgate_SOURCES += algorithm/cryptonight.c algorithm/cryptonight.h algorithm/cn-aes-tbls.h
gatelessgate_SOURCES += algorithm/equihash.c algorithm/equihash.h
gatelessgate_SOURCES += algorithm/pascal.c algorithm/pascal.h
gatelessgate_SOURCES += gbt-util.c gbt-util.h

bin_SCRIPTS	= $(top_srcdir)/kernel/*.cl

