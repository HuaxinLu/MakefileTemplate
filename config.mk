# 通用Makefile模板
# 配置文件

# 宏变量
export CC=gcc
export CFLAGS=-w
#工程根目录
export BUILD_ROOT=$(shell pwd)
# 中间文件存放目录
export BUILD_TEMP=$(BUILD_ROOT)/temp
$(shell mkdir -p $(BUILD_TEMP))
# 直接链接的目标文件存放目录
export LINK_OBJ_DIR=$(BUILD_TEMP)/link_obj
# 编译成库的目标文件存放目录
export LIB_OBJ_DIR=$(BUILD_TEMP)/lib_obj
# 依赖关系文件存放目录
export DEP_DIR=$(BUILD_TEMP)/dep
$(shell mkdir -p $(DEP_DIR))
# 头文件存放目录，需预先指定
export INCLUDE_DIR=$(BUILD_ROOT)/inc
# 生成的库文件存放目录
export LIB_DIR=$(BUILD_ROOT)/lib
$(shell mkdir -p $(LIB_DIR))
# 生成的BIN文件存放目录
export BIN_DIR=$(BUILD_ROOT)
# 需要依赖的第三方库文件存放目录，需预先指定
export EXT_LIB_DIR=$(LIB_DIR)/ext_lib
# 源文件目录
export BUILD_DIR=$(BUILD_ROOT)/lcd/ \
		  $(BUILD_ROOT)/usb/ \
		  $(BUILD_ROOT)/media/ \
		  $(BUILD_ROOT)/math/ \
		  $(BUILD_ROOT)/app/
