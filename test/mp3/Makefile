.PHONY:all clean
include config.mk

# 进入子目录下递归执行make
all:
	@for dir in $(BUILD_DIR);\
	do \
		make -C $$dir; \
	done
# clean命令，删除中间文件
clean:
	rm -rf $(BUILD_TEMP)
	rm -f mp3
install:
	/bin/cp -f mp3 /usr/bin
	/bin/cp -f $(LIB_DIR)/*.so /usr/lib
	/bin/cp -f $(EXT_LIB_DIR)/*.so /usr/lib
uninstall:
	rm -f /usr/bin/mp3
	rm -f /usr/lib/libmath.so
	rm -f /usr/lib/librmvb.so
