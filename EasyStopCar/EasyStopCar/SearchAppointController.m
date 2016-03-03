//
//  SearchAppointController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchAppointController.h"
#import "SearchAppointCell.h"

@interface SearchAppointController ()

@property(nonatomic,strong)UIButton *submitButoon;      //提交按钮
@property(nonatomic,strong)UIView *topView;      //标题视图
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *topTitleLabel;
@property(nonatomic,strong)UILabel *topContentLabel;

 @property(nonatomic,strong) UITableView *serachTableView;//列表

@property(nonatomic,strong)UIView *searchSwitchView;
@property(nonatomic, strong) UIImageView *searchImageView;
@property(nonatomic, strong) UILabel *searchName;
@property(nonatomic, strong) UISwitch *searchSwitch;
@end

@implementation SearchAppointController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [super initNavBarItems:@"预约车位"];
    [super addRightTitle:@"预订说明" selector:@selector(showAppointInfo)];
//    self.view.backgroundColor = [UIColor whiteColor];

    self.submitButoon = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenHeight-50-64, ScreenWidth, 50)];
    [self.submitButoon setTitle:@"确定" forState:UIControlStateNormal];
    [self.submitButoon addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButoon.backgroundColor = backageColorRed;
    self.submitButoon.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.submitButoon];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
     self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    CALayer *topViewBottomBorder=[[CALayer alloc]init];
    topViewBottomBorder.frame=CGRectMake(0, self.topView.frame.size.height-0.5, self.topView.frame.size.width, 0.5);
    topViewBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.topView.layer addSublayer:topViewBottomBorder ];
    
    //顶部视图
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 30, 50, 50)];
    self.topImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.topView addSubview:self.topImageView];
    
    self.topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.topImageView.frame.origin.x+self.topImageView.frame.size.width+5, self.topImageView.frame.origin.y, 150, 15)];
    self.topTitleLabel.font = [UIFont systemFontOfSize:15];
    self.topTitleLabel.textColor = fontColorBlack;
    self.topTitleLabel.text = @"提前预约车位无忧";
    [self.topView addSubview:self.topTitleLabel];
    
    self.topContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.topTitleLabel.frame.origin.x, self.topTitleLabel.frame.origin.y+self.topTitleLabel.frame.size.height+5, 150, 15)];
    self.topContentLabel.font = [UIFont systemFontOfSize:12];
    self.topContentLabel.textColor = fontColorGray;
    self.topContentLabel.text = @"出行前一天预约，尊享保留车位";
    [self.topView addSubview:self.topContentLabel];
    
    
    
    
    self.serachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.frame.origin.y+self.topView.frame.size.height, ScreenWidth, 100)];
    self.serachTableView.delegate = self;
    self.serachTableView.dataSource = self;
    self.serachTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.serachTableView.backgroundColor = [UIColor whiteColor];
    [self.serachTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.serachTableView];
    
   
    
    
 //充电开关视图
    self.searchSwitchView = [[UIView alloc]initWithFrame:CGRectMake(0, self.serachTableView.frame.origin.y+self.serachTableView.frame.size.height+20, ScreenWidth, 50)];
    self.searchSwitchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchSwitchView];
    
    CALayer *searchSwitchTopBorder=[[CALayer alloc]init];
    searchSwitchTopBorder.frame=CGRectMake(0, 0, self.searchSwitchView.frame.size.width, 0.5);
    searchSwitchTopBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.searchSwitchView.layer addSublayer:searchSwitchTopBorder ];
    
    CALayer *searchSwitchBottomBorder=[[CALayer alloc]init];
    searchSwitchBottomBorder.frame=CGRectMake(0, self.searchSwitchView.frame.size.height-0.5, self.searchSwitchView.frame.size.width, 0.5);
    searchSwitchBottomBorder.backgroundColor=lineColorLightgray.CGColor;
    [self.searchSwitchView.layer addSublayer:searchSwitchBottomBorder ];
    
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginSize, 0, 20, 50)];
    self.searchImageView.image = [UIImage imageNamed:@"ico_home_cell_flag"];
    self.searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.searchSwitchView addSubview:self.searchImageView];
    
    
    self.searchName = [[UILabel alloc] initWithFrame:CGRectMake(self.searchImageView.frame.origin.x+self.searchImageView.frame.size.width+15, 0, 200, 50)];
    self.searchName.font = [UIFont systemFontOfSize:15];
    self.searchName.textColor = fontColorBlack;
    self.searchName.text = @"是否可以充电";
    [self.searchSwitchView addSubview:self.searchName];
    
    self.searchSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-60,5,0,0)];
     [self.searchSwitch setOn:YES animated:YES];
    [self.searchSwitchView addSubview:self.searchSwitch];
    
 }


//提交按钮点击事件
-(void)submitClick{
    
}

//预订说明
-(void)showAppointInfo{
    NSLog(@"预订说明");
    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 50;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"SearchAppointCell";
    
    SearchAppointCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[SearchAppointCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
