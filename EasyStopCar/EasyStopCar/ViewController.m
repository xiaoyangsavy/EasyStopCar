//
//  ViewController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "ViewController.h"
//#import "SearchPartMapController.h"
#import "YHR_PageControl.h"
#import "SearchPartController.h"
#import "OrderDetailController.h"
#import "OrderPayController.h"
#import "SearchAppointController.h"
#import "UserCenterController.h"

@interface ViewController ()

//@property(nonatomic,strong)UIScrollView *homeScroll;
@property(nonatomic,strong)UIScrollView *bannerScroll;          //广告横幅
@property(nonatomic,strong)YHR_PageControl *myBannerPageControl;//指示器

@property(nonatomic,strong)UIView *enterView;//入口区域
@property(nonatomic,strong)UIButton *aroundView;//周边
@property(nonatomic,strong)UIImageView *aroundImageView;
@property(nonatomic,strong)UILabel *aroundLabel;
@property(nonatomic,strong)UIButton *appointView;//预约
@property(nonatomic,strong)UIImageView *appointImageView;
@property(nonatomic,strong)UILabel *appointLabel;


@property(nonatomic,strong)UIView *selectView;//选择
@property(nonatomic,strong)UIImageView *selectImageView;
@property(nonatomic,strong)UILabel *selectTitleLabel;
@property(nonatomic,strong)UIImageView *selectArrow;


@property(nonatomic,strong)UITableView *listTableView;//数据列表

@property(nonatomic,strong)NSMutableArray *myArray;//列表数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   [super initInfoArray];//加载测试数据
    
    
 [super initNavBarItems:@"易停车"];
  [self addLeftButton:@"ico_navigation_user" lightedImage:@"ico_navigation_user" selector:@selector(goUserCenter)];
    [self addRightButton:@"ico_navigation_phone" lightedImage:@"ico_navigation_phone" selector:@selector(callPhone)];
    
    self.view.backgroundColor = backageColorLightgray;
    
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = TEST_COLOR;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTableView];
    
    //设置表头部个人信息
    self.listTableView.tableHeaderView = ({
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, ScreenWidth*420/640+166+39)];
        headView.backgroundColor = TEST_COLOR;

        //banner*******************************
        self.bannerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*420/640)];
        self.bannerScroll.tag = 198811;
        //    self.bannerScroll.delegate=self;
        self.bannerScroll.pagingEnabled=YES;        //整页滚动
        self.bannerScroll.bounces=NO;
        self.bannerScroll.alwaysBounceVertical=NO;
        self.bannerScroll.alwaysBounceHorizontal=YES;
        self.bannerScroll.showsHorizontalScrollIndicator=NO;
        self.bannerScroll.showsVerticalScrollIndicator=NO;
            self.bannerScroll.backgroundColor=TEST_COLOR;
        [headView addSubview:self.bannerScroll];
        
        self.myBannerPageControl = [[YHR_PageControl alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.464-20, ScreenWidth, 20)];
        self.myBannerPageControl.tag=198812;
        self.myBannerPageControl.numberOfPages = 6-2;//设置pageConteol 的page 和 _scrollView 上的图片一样多
        self.myBannerPageControl.currentPage = 0;
        [headView addSubview:self.myBannerPageControl];
        
        
        //入口区域
        self.enterView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bannerScroll.frame.origin.y+self.bannerScroll.frame.size.height, ScreenWidth, 166.0)];
        self.enterView.backgroundColor = backageColorLightgray;
        [headView addSubview:self.enterView];
        
        
        self.aroundView = [[UIButton alloc]init];
        [self.aroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.aroundView.tag = 198801;
        [self.aroundView addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.enterView addSubview:self.aroundView];
        
        self.aroundImageView = [[UIImageView alloc]init];
        [self.aroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.aroundImageView setImage:[UIImage imageNamed:@"image_home_around"]];
        self.aroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.aroundView addSubview:self.aroundImageView];
        
        self.aroundLabel = [[UILabel alloc]init];
        [self.aroundLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.aroundLabel.font = [UIFont systemFontOfSize:12];
        self.aroundLabel.textColor = fontColorGray;
         self.aroundLabel.text = @"查找附近车位";
         self.aroundLabel.textAlignment = NSTextAlignmentCenter;
        [self.aroundView addSubview:self.aroundLabel];
        
        
        self.appointView = [[UIButton alloc]init];
        [self.appointView setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.appointView.tag = 198802;
        [self.appointView addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.enterView addSubview:self.appointView];
        
        self.appointImageView = [[UIImageView alloc]init];
        [self.appointImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.appointImageView setImage:[UIImage imageNamed:@"image_home_appoint"]];
        self.appointImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.appointView addSubview:self.appointImageView];
        
        self.appointLabel = [[UILabel alloc]init];
        [self.appointLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.appointLabel.font = [UIFont systemFontOfSize:12];
         self.appointLabel.text = @"提前预约车位";
        self.appointLabel.textAlignment = NSTextAlignmentCenter;
        self.appointLabel.textColor = fontColorGray;
        [self.appointView addSubview:self.appointLabel];
        
        
        //选择区域
        self.selectView = [[UIView alloc]initWithFrame:CGRectMake(0, self.enterView.frame.origin.y+self.enterView.frame.size.height, ScreenWidth, 39.0)];
        self.selectView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:self.selectView];
        
        CALayer *topBorder=[[CALayer alloc]init];
        topBorder.frame=CGRectMake(0, 0, self.selectView.frame.size.width, 0.5);
        topBorder.backgroundColor=lineColorGray.CGColor;
        [self.selectView.layer addSublayer:topBorder ];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, self.selectView.frame.size.height-0.5, self.selectView.frame.size.width, 0.5);
        bottomBorder.backgroundColor=lineColorGray.CGColor;
        [self.selectView.layer addSublayer:bottomBorder ];
        
        
        
        self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 0, 20, self.selectView.frame.size.height)];
        [self.selectImageView setImage:[UIImage imageNamed:@"ico_home_menu"]];
        self.selectImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.selectView addSubview:self.selectImageView];
        
        self.selectTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.selectImageView.frame.origin.x+self.selectImageView.frame.size.width+10, 0, 200, self.selectView.frame.size.height)];
        self.selectTitleLabel.font = [UIFont systemFontOfSize:14];
        self.selectTitleLabel.textColor = fontColorGray;
        self.selectTitleLabel.text = @"暂无";
        [self.selectView addSubview:self.selectTitleLabel];
        
        self.selectArrow = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-marginSize-20, 0, 10, self.selectView.frame.size.height)];
        [self.selectArrow setImage:[UIImage imageNamed:@"ico_home_select_arrow"]];
        self.selectArrow.contentMode = UIViewContentModeScaleAspectFit;
        [self.selectView addSubview:self.selectArrow];
        
         headView;
     });
    
    
    
    
    //自动布局
    [self.enterView addConstraint:[NSLayoutConstraint
                               constraintWithItem:self.aroundView
                               attribute:NSLayoutAttributeCenterX
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.enterView
                               attribute:NSLayoutAttributeCenterX
                               multiplier:0.6
                               constant:0]];
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1
                                   constant:0]];

    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeWidth
                                   multiplier:0
                                   constant:100]];
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeHeight
                                   multiplier:0
                                   constant:110]];
    
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.appointView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeCenterX
                                   multiplier:1.4
                                   constant:0]];
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.appointView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1
                                   constant:0]];
    
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.appointView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeWidth
                                   multiplier:0
                                   constant:100]];
    [self.enterView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.appointView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.enterView
                                   attribute:NSLayoutAttributeHeight
                                   multiplier:0
                                   constant:110]];
    
    
    //周边自动布局
    [self.aroundView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundImageView
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.aroundView
                                   attribute:NSLayoutAttributeCenterX
                                   multiplier:1
                                   constant:0]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundImageView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.aroundView
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1
                                   constant:0]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundImageView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.aroundView
                                   attribute:NSLayoutAttributeWidth
                                   multiplier:0
                                   constant:90]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:self.aroundImageView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.aroundView
                                   attribute:NSLayoutAttributeHeight
                                   multiplier:0
                                   constant:90]];
    
    [self.aroundView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.aroundLabel
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.aroundView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:0]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.aroundLabel
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.aroundImageView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:10]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.aroundLabel
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.aroundView
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:0]];
    [self.aroundView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.aroundLabel
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.aroundView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:0]];
    
    
    
    //预约自动布局
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointImageView                                    attribute:NSLayoutAttributeCenterX
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeCenterX
                                    multiplier:1
                                    constant:0]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointImageView
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeTop
                                    multiplier:1
                                    constant:0]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointImageView
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:0
                                    constant:90]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointImageView
                                    attribute:NSLayoutAttributeHeight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeHeight
                                    multiplier:0
                                    constant:90]];
    
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointLabel
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:0]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointLabel
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointImageView
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                    constant:10]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointLabel
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeLeft
                                    multiplier:1
                                    constant:0]];
    [self.appointView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.appointLabel
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.appointView
                                    attribute:NSLayoutAttributeRight
                                    multiplier:1
                                    constant:0]];
  

 
   
}




//快捷入口点击事件
-(void)enterClick:(UIButton *)myButton{

    SearchPartController *searchPartController = [[SearchPartController alloc]init];
    SearchAppointController *searchAppointController = [[SearchAppointController alloc]init];
    switch (myButton.tag) {
        case 198801://搜索周边停车位
            searchPartController.styleType = 0;
            [self.navigationController pushViewController:searchPartController animated:YES];
            break;
        case 198802://提前预约
             [self.navigationController pushViewController:searchAppointController animated:YES];
            break;
        default:
            break;
    }

}

//跳转到个人中心
-(void)goUserCenter{

    UserCenterController *myController = [[UserCenterController alloc]init];
    [self.navigationController pushViewController:myController animated:YES];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 108.5+20.0;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"HomeCell";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.delegate = self;
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;

          }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了一个cell");
    
    
    NSDictionary *myDictionary =  self.myArray[indexPath.row];
    NSString *flag = myDictionary[@"testFlag"];
    if ([flag isEqualToString:@"0"]) {
        OrderDetailController *orderDetailController = [[OrderDetailController alloc]init];
        [self.navigationController pushViewController:orderDetailController animated:YES];
    }else{
    OrderPayController *myController = [[OrderPayController alloc]init];
    [self.navigationController pushViewController:myController animated:YES];
    }
}


#pragma mark cell代理方法
//修改商品信息
- (void)getDictionary:(NSDictionary *)myDictionary {
    NSLog(@"cell的点击代理回调%@！！！！！",myDictionary);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
