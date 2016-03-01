//
//  SearchPartController.m
//  EasyStopCar
//  
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartController.h"
#import "SearchPartMapController.h"
#import "HomeCell.h"

@interface SearchPartController ()

@property(nonatomic,strong) UITableView *serachTableView;//列表


@property(nonatomic,strong)UIView *categoryView;//类别区域
@property(nonatomic,strong)UIButton *categoryOneLabel;
@property(nonatomic,strong)UIView *categoryOneBackage;
@property(nonatomic,strong)UIButton *categoryTwoLabel;
@property(nonatomic,strong)UIView *categoryTwoBackage;
@property(nonatomic,strong)UIButton *categoryThreeLabel;
@property(nonatomic,strong)UIView *categoryThreeBackage;
@property(nonatomic,strong)UIButton *categoryFourLabel;
@property(nonatomic,strong)UIView *categoryFourBackage;


@property(nonatomic,strong)NSMutableArray *categoryViewArray;
@property(nonatomic,strong)NSMutableArray *categoryBackageArray;
@end

@implementation SearchPartController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
     [super initTestArray];//加载测试数据
    self.categoryViewArray = [[NSMutableArray alloc]init];
    self.categoryBackageArray = [[NSMutableArray alloc]init];
    
    [super addRightButton:@"ico_navigation_map" lightedImage:@"ico_navigation_map" selector:@selector(goSearchMap)];
    
    self.serachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.serachTableView.delegate = self;
    self.serachTableView.dataSource = self;
    self.serachTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.serachTableView.backgroundColor = [UIColor whiteColor];
    [self.serachTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.serachTableView];

    //设置表头部个人信息
    self.serachTableView.tableHeaderView = ({
        
        UIView *myTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 40.0f)];
        myTableHeadView.backgroundColor = [UIColor whiteColor];
        
        
        //列表区域
        self.categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        self.categoryView.backgroundColor = [UIColor whiteColor];
        [myTableHeadView addSubview:self.categoryView];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, self.categoryView.frame.size.height-0.5, self.categoryView.frame.size.width, 0.5);
        bottomBorder.backgroundColor=lineColorGray.CGColor;
        [self.categoryView.layer addSublayer:bottomBorder ];
        
        //类别1
        self.categoryOneLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*0, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryOneLabel.tag = 198820;
        [self.categoryOneLabel setTitle:@"药品知识" forState:UIControlStateNormal];
        self.categoryOneLabel.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.categoryOneLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryOneLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryOneLabel];
        
        self.categoryOneBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryOneBackage.backgroundColor = [UIColor blackColor];
        [self.categoryOneLabel addSubview:self.categoryOneBackage];
        
        [self.categoryViewArray addObject:self.categoryOneLabel];
        [self.categoryBackageArray addObject:self.categoryOneBackage];
        
        //类别2
        self.categoryTwoLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*1, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryTwoLabel.tag = 198821;
        [self.categoryTwoLabel setTitle:@"疾病常识" forState:UIControlStateNormal];
        self.categoryTwoLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryTwoLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryTwoLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryTwoLabel];
        
        self.categoryTwoBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryTwoBackage.backgroundColor = [UIColor blackColor];
        self.categoryTwoBackage.hidden = YES;
        [self.categoryTwoLabel addSubview:self.categoryTwoBackage];
        
        [self.categoryViewArray addObject:self.categoryTwoLabel];
        [self.categoryBackageArray addObject:self.categoryTwoBackage];
        
        //类别3
        self.categoryThreeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*2, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryThreeLabel.tag = 198822;
        [self.categoryThreeLabel setTitle:@"生活百科" forState:UIControlStateNormal];
        self.categoryThreeLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryThreeLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryThreeLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryThreeLabel];
        
        self.categoryThreeBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryThreeBackage.backgroundColor = [UIColor blackColor];
        self.categoryThreeBackage.hidden = YES;
        [self.categoryThreeLabel addSubview:self.categoryThreeBackage];
        
        [self.categoryViewArray addObject:self.categoryThreeLabel];
        [self.categoryBackageArray addObject:self.categoryThreeBackage];
        
        //类别4
        self.categoryFourLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/4*3, 0, ScreenWidth/4, self.categoryView.frame.size.height)];
        self.categoryFourLabel.tag = 198823;
        [self.categoryFourLabel setTitle:@"日常保健" forState:UIControlStateNormal];
        self.categoryFourLabel.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.categoryFourLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryFourLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryFourLabel];
        
        self.categoryFourBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/4-50)/2, self.categoryView.frame.size.height-1, 50, 1)];
        self.categoryFourBackage.backgroundColor = [UIColor blackColor];
        self.categoryFourBackage.hidden = YES;
        [self.categoryFourLabel addSubview:self.categoryFourBackage];
        
        [self.categoryViewArray addObject:self.categoryFourLabel];
        [self.categoryBackageArray addObject:self.categoryFourBackage];
        
        myTableHeadView;
    });
        
        
        
}


//类别点击事件
- (void)clickWithCategory:(UIButton *)myButton
{
    //    NSLog(@"点击了类别切换%ld,%lu",myButton.tag,(unsigned long)self.categoryBackageArray.count);
    
    
    for (int i=0; i<self.categoryBackageArray.count; i++) {
        UIView *myBackage =  self.categoryBackageArray[i];
        if (myButton.tag-198820 == i) {
            //            NSLog(@"修改为选中%ld",myButton.tag);
            myBackage.hidden = NO;
            UIButton *myLabel = self.categoryViewArray[i];
            myLabel.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        }else{
            //             NSLog(@"修改为未选中%ld",myButton.tag);
            UIButton *myLabel = self.categoryViewArray[i];
            myLabel.titleLabel.font = [UIFont systemFontOfSize:13];
            myBackage.hidden = YES;
        }
    }
    
    
}


//跳转到搜索地图页面
-(void)goSearchMap{
    SearchPartMapController *searchPartMapController = [[SearchPartMapController alloc]init];
    [self.navigationController pushViewController:searchPartMapController animated:YES];

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
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
