//
//  Define.h
//

//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] applicationFrame]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenNavHeight 64


//判断是否是ios7系统
#define kSystemIsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


//背景颜色
#define backageColorYellow [UIColor colorWithRed:252/255.0 green:175/255.0 blue:23/255.0 alpha:1]
#define backageColorRed [UIColor colorWithRed:242/255.0 green:109/255.0 blue:95/255.0 alpha:1]
#define backageColorBlue [UIColor colorWithRed:59/255.0 green:153/255.0 blue:201/255.0 alpha:1]
#define backageColorGreen [UIColor colorWithRed:86/255.0 green:185/255.0 blue:71/255.0 alpha:1]
#define backageColorLightgray [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]

//字体颜色
#define fontColorBlack [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define fontColorGray [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]
#define fontColorLightgray [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]

//分割线颜色
#define lineColorGray [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0]
#define lineColorLightgray [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0]

#define marginSize 15.0f



/* *** DEBUG DEFINE *** */
// 测试用色（正常状态下置0，为透明色）
#if DEBUG
#define TEST_COLOR                                 \
([UIColor colorWithRed:arc4random() % 10 / 10.0f \
green:arc4random() % 10 / 10.0f \
blue:arc4random() % 10 / 10.0f \
alpha:0.8])
#else
#define TEST_COLOR ([UIColor clearColor])
#endif


//网址前缀
#define prefix_url     @"http://www.sjsh8.cn/"    //世纪生活



