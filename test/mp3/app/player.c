#include <stdio.h>
#include "lcd.h"
#include "usb.h"
#include "media.h"
#include "math.h"
#include "gif.h"
#include "rmvb.h"
void main()
{
    lcd_init();
    usb_init();
    media_init();
    math_dll_init();
    gif_init();
    rmvb_init();
    printf("mp3 player!\n");
}
