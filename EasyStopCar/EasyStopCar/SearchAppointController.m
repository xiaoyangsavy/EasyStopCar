//
//  SearchAppointController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchAppointController.h"
#import "SearchAppointCell.h"
#import "SearchAppointSelectController.h"
#import "SearchPartController.h"
#import "CommonTools.h"
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

@property(nonatomic,strong)UIView *seleceView;      //时间和日期选择视图
@property (nonatomic, strong) UIButton *pickCancel;
@property (nonatomic, strong) UIButton *pickSubmit;
@property (nonatomic, strong) UIPickerView *myPickView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *hourArray;
@property (nonatomic, strong)NSMutableArray *minuteArray;

@end

@implementation SearchAppointController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [super initNavBarItems:@"预约车位"];
    [super addRightTitle:@"预订说明" selector:@selector(showAppointInfo)];
//    self.view.backgroundColor = [UIColor whiteColor];

    [self initPickerData];//初始化时间日期选择器数据
    
    
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
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(marginSize, 20, 65, 50)];
    self.topImageView.image = [UIImage imageNamed:@"ico_appoint_complete"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.topView addSubview:self.topImageView];
    
    self.topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.topImageView.frame.origin.x+self.topImageView.frame.size.width+10, self.topImageView.frame.origin.y+10, 150, 15)];
    self.topTitleLabel.font = [UIFont systemFontOfSize:15];
    self.topTitleLabel.textColor = fontColorBlack;
    self.topTitleLabel.text = @"提前预约车位无忧";
    [self.topView addSubview:self.topTitleLabel];
    
    self.topContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.topTitleLabel.frame.origin.x, self.topTitleLabel.frame.origin.y+self.topTitleLabel.frame.size.height+5, 200, 15)];
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
    
    
    self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginSize, 0, 15, 50)];
    self.searchImageView.image = [UIImage imageNamed:@"ico_home_cell_flag"];
    self.searchImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.searchSwitchView addSubview:self.searchImageView];
    
    
    self.searchName = [[UILabel alloc] initWithFrame:CGRectMake(self.searchImageView.frame.origin.x+self.searchImageView.frame.size.width+15, 0, 200, 50)];
    self.searchName.font = [UIFont systemFontOfSize:15];
    self.searchName.textColor = fontColorBlack;
    self.searchName.text = @"是否可以充电";
    [self.searchSwitchView addSubview:self.searchName];
    
    self.searchSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-60,10,0,0)];
     [self.searchSwitch setOn:YES animated:YES];
    [self.searchSwitchView addSubview:self.searchSwitch];
    
    
    //时间日期选择视图
    self.seleceView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-255-64, ScreenWidth, 255)];
    self.seleceView.backgroundColor = [UIColor whiteColor];
    self.seleceView.hidden = YES;
    [self.view addSubview:self.seleceView];
    
    CALayer *seleceViewTopBorder=[[CALayer alloc]init];
    seleceViewTopBorder.frame=CGRectMake(0, 0, self.seleceView.frame.size.width, 0.5);
    seleceViewTopBorder.backgroundColor=lineColorGray.CGColor;
    [self.seleceView.layer addSublayer:seleceViewTopBorder ];
    
 
    
    self.pickCancel = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 80, 40)];
    [self.pickCancel setTitle:@"取消" forState:UIControlStateNormal];
    self.pickCancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.pickCancel setTitleColor:fontColorBlack forState:UIControlStateNormal];
    [self.pickCancel addTarget:self action:@selector(selectPick:) forControlEvents:UIControlEventTouchUpInside];
    self.pickCancel.tag = 198801;
    [self.seleceView addSubview:self.pickCancel];
    
    self.pickSubmit = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-80,0, 80, 40)];
    [self.pickSubmit setTitle:@"确定" forState:UIControlStateNormal];
    self.pickSubmit.titleLabel.font = [UIFont systemFontOfSize:15];
      [self.pickSubmit setTitleColor:fontColorBlack forState:UIControlStateNormal];
    [self.pickSubmit addTarget:self action:@selector(selectPick:) forControlEvents:UIControlEventTouchUpInside];
    self.pickSubmit.tag = 198802;
    [self.seleceView addSubview:self.pickSubmit];

    //日期和时间选择器
    self.myPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40 ,ScreenWidth, 215)];
    self.myPickView.backgroundColor = [UIColor whiteColor];
    self.myPickView.delegate = self;
    self.myPickView.dataSource = self;
    [self.seleceView addSubview:self.myPickView];
    
    CALayer *myPickViewTopBorder=[[CALayer alloc]init];
    myPickViewTopBorder.frame=CGRectMake(0, 0,  self.myPickView.frame.size.width, 0.5);
    myPickViewTopBorder.backgroundColor=lineColorGray.CGColor;
    [ self.myPickView.layer addSublayer:myPickViewTopBorder ];
    
 }


//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"选择目的地" forKey:@"title"];
    [myDictionary setValue:[UIImage imageNamed:@"ico_home_cell_location"] forKey:@"image"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"停车时间" forKey:@"title"];
    [myDictionary setValue:[UIImage imageNamed:@"ico_time"] forKey:@"image"];
    [self.myArray addObject:myDictionary];
    
    
}

//初始化时间日期选择器数据
-(void)initPickerData{
 
    
     self.dataArray = [[NSMutableArray alloc]init];
     NSString *myString = nil;
    
    CommonTools *commonTools = [[CommonTools alloc]init];
    NSInteger month = [commonTools getDataAndTime:2];
    NSInteger day = [commonTools getDataAndTime:3];
    
    
    for(int i=1;i<7;i++){
        NSInteger nextMonth = month;
        NSInteger nextDay = day+i;
        
           NSInteger limitDay = 0;
            //修改天数
            if (month==2) {
                limitDay=28;
            }else if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
             limitDay=31;
            }else{
            limitDay=30;
            }
            
        if (day+i > limitDay) {
            if (month == 12) {
                nextMonth = 1;
            }else{
                nextMonth++;
            }
            nextDay = 1;
        }
        
        myString = [NSString stringWithFormat:@"%ld月%ld日",(long)nextMonth,(long)nextDay];
        [self.dataArray addObject:myString];
    }
    
 
 
    self.hourArray = [[NSMutableArray alloc]init];
    for (int i=0; i<24; i++) {
        myString = [NSString stringWithFormat:@"%02d",i];
        [self.hourArray addObject:myString];
    }
    
    self.minuteArray = [[NSMutableArray alloc]init];
    for (int i=0; i<60; i++) {
        myString = [NSString stringWithFormat:@"%02d",i];
        [self.minuteArray addObject:myString];
    }
    
}


-(void)selectPick:(UIButton *)myButton{
    if (myButton.tag == 198801) {
        self.seleceView.hidden = YES;
    }else{
        self.seleceView.hidden = YES;
        NSInteger selectedOneIndex = [self.myPickView selectedRowInComponent:0];
        NSInteger selectedTwoIndex = [self.myPickView selectedRowInComponent:1];
          NSInteger selectedThreeIndex = [self.myPickView selectedRowInComponent:2];
        
        NSLog(@"选择的时间为%@；%@；%@!!!!",self.dataArray[selectedOneIndex],self.hourArray[selectedTwoIndex],self.minuteArray[selectedThreeIndex]);
        
        
        
    }

}

//提交按钮点击事件
-(void)submitClick{
    
    SearchPartController *myController = [[SearchPartController alloc]init];
    myController.searchedLocation = @"北京";
    myController.searchedData = @"0月0日 00:00";
    myController.styleType = 1;
    [self.navigationController pushViewController:myController animated:YES];
    
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
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        SearchAppointSelectController *myController = [[SearchAppointSelectController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else{
        self.seleceView.hidden = NO;
    }
}

#pragma mark 时间和日期选择代理
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {//第一个轮子内item数量
        return [self.dataArray count];
    } else if (component == 1) {//第二个轮子内item数量
        return [self.hourArray count];
    }else{//第三个轮子内item数量
        return [self.minuteArray count];
    }
}

//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//确定每个轮子的每一项显示什么内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0) {
        return [self.dataArray objectAtIndex:row];
    }else if(component == 1) {
        return [self.hourArray objectAtIndex:row];
    }else{
        return [self.minuteArray objectAtIndex:row];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
