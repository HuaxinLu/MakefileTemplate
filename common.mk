# 通用的Makefile模板
# 抽取的公共文件

.PHONY:all
# 根据LIB和DLL确定目标文件存放位置
# 判断是否生成静态库
OBJ_DIR=$(LINK_OBJ_DIR)
ifneq ("$(LIB)","")
OBJ_DIR=$(LIB_OBJ_DIR)
endif
# 判断是否生成动态库
# 确定生成目标文件时是否使用-fPIC
ifneq ("$(DLL)","")
OBJ_DIR=$(LIB_OBJ_DIR)
PIC_FLAG=-fPIC
endif
# 创建目录
$(shell mkdir -p $(OBJ_DIR))

# 搜索目录下的.c文件
SRCS=$(wildcard *.c)
# 需要生成的目标文件，添加目录前缀
OBJS:=$(addprefix $(OBJ_DIR)/,$(SRCS:.c=.o))
# 需要生成的依赖关系文件
DEPS:=$(addprefix $(DEP_DIR)/,$(SRCS:.c=.d))
# 需要生成的静态库文件
ifneq ("$(LIB)","")
LIB:=$(addprefix $(LIB_DIR)/,$(LIB))
endif
# 需要生成的动态库文件
ifneq ("$(DLL)","")
DLL:=$(addprefix $(LIB_DIR)/,$(DLL))
endif
# 需要生成的BIN文件
ifneq ("$(BIN)","")
BIN:=$(addprefix $(BIN_DIR)/,$(BIN))
$(shell mkdir -p $(BIN_DIR))
endif
# 全部依赖的库文件
LIB_DEP=$(wildcard $(LIB_DIR)/*.a) $(wildcard $(LIB_DIR)/*.so) $(wildcard $(EXT_LIB_DIR)/*.a) $(wildcard $(EXT_LIB_DIR)/*.so)
# 提取库名，转化为编译参数
LINK_LIB_FLAG=$(patsubst lib%,-l%,$(basename $(notdir $(LIB_DEP))))
# 需要链接的目标文件，不能立即展开，会有重复
LINK_OBJS:=$(wildcard $(LINK_OBJ_DIR)/*.o)
LINK_OBJS+=$(OBJS)
# 伪目标
all:$(OBJS) $(BIN) $(DEPS) $(LIB) $(DLL)
# 添加依赖，同时去掉第一次执行的提示信息
ifneq ("$(wildcard $(DEPS))","")
include $(DEPS)
endif
# bin文件规则
$(BIN):$(LINK_OBJS) $(LIB_DEP)
	$(CC) -o $@ $(filter %.o,$^) -L$(LIB_DIR) -L$(EXT_LIB_DIR) $(LINK_LIB_FLAG)
# 静态库文件规则
$(LIB):$(OBJS)
	ar rcs $@ $^
# 动态库文件规则
$(DLL):$(OBJS)
	$(CC) -shared -o $@ $^
# 目标文件规则，因为后面还会添加对.h文件的依赖，因此需要过滤出.c文件
$(OBJ_DIR)/%.o:%.c
	$(CC) $(PIC_FLAG) -I$(INCLUDE_DIR)/ -o $@ -c $(filter %.c,$^) $(CFLAGS)
# 依赖关系文件规则
# 给依赖关系中的目标文件加上前缀
# 同时添加.d文件自身对.c文件和.h文件的依赖
# 这样可以保证改变头文件时更新.d文件
$(DEP_DIR)/%.d:%.c
	$(CC) -I$(INCLUDE_DIR)/ -MM $(filter %.c,$^) | sed 's,\(.*\)\.o[ :]*,$(OBJ_DIR)/\1.o $@:,g' > $@
