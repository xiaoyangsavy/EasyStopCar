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


//定义项目红，绿 两种主基调颜色
//#define kRedColor [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f]
#define kRedColor [UIColor colorWithRed:51/255. green:204/255. blue:204/255. alpha:1]
#define hhRedColor [UIColor colorWithRed:250.0f/255.0f green:99.0f/255.0f blue:56.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:86.0f/255.0f green:193.0f/255.0f blue:61.0f/255.0f alpha:1.0f]
#define kDarkGreenColor [UIColor colorWithRed:113.0f/255.0f green:138.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define kGrayColor  [UIColor colorWithRed:186.0f/255.0f green:189.0f/255.0f blue:196.0f/255.0f alpha:1]
//背景色淡灰色
#define dilutedGrayColor [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]
//字体颜色
#define fontGrayColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]

//字体颜色,淡灰
#define fontDilutedGrayColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
//分割线颜色
#define lineGrayColor [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]



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

//#define prefix_url     @"http://www.sjsh8.cn/"    //世纪生活
#define prefix_url     @"http://sjsh.weplays.cn/"   //淮海生活



