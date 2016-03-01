//
//  SearchPartController.m
//  EasyStopCar
//  
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartController.h"
#import "SearchPartMapController.h"
#import "SearchPartCell.h"
#import "SearchPartDetailController.h"

@interface SearchPartController ()
{
 UITextField *currentTextField;
}

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

@property (nonatomic, strong) NSString *searchedContent;//输入完成的搜索内容
@end

@implementation SearchPartController

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
     [super initTestArray];//加载测试数据
    self.categoryViewArray = [[NSMutableArray alloc]init];
    self.categoryBackageArray = [[NSMutableArray alloc]init];
    
    [super addRightButton:@"ico_navigation_map" lightedImage:@"ico_navigation_map" selector:@selector(goSearchMap)];
    
    //搜索框
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [self.navigationItem setTitleView:searchView];
    
//    UIImageView *serachBackageView = [[UIImageView alloc]initWithFrame:CGRectMake(-20, searchView.frame.size.height-15, searchView.frame.size.width+40, 5)];
//    serachBackageView.image = [UIImage imageNamed:@"hh_backage_serach"];
//    serachBackageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchView addSubview:serachBackageView];
    
    UIImageView *serachIcoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 40)];
    serachIcoView.image = [UIImage imageNamed:@"ico_navigation_search"];
    serachIcoView.contentMode = UIViewContentModeScaleAspectFit;
    [searchView addSubview:serachIcoView];
    
    UITextField *serachTextField = [[UITextField alloc]initWithFrame:CGRectMake(serachIcoView.frame.origin.x+serachIcoView.frame.size.width+2, 0, searchView.frame.size.width-10, 40)];
    //    [serachTextField setPlaceholder:@"请搜索商品"];
    serachTextField.font = [UIFont systemFontOfSize:13];
    serachTextField.delegate = self;
    serachTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索停车场" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]}];
    serachTextField.textColor = [UIColor whiteColor];
    [searchView addSubview:serachTextField];

    
    
    
    
    
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
        int categoryCount = 3;
        
        self.categoryOneLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/categoryCount*0, 0, ScreenWidth/categoryCount, self.categoryView.frame.size.height)];
        self.categoryOneLabel.tag = 198820;
        [self.categoryOneLabel setTitle:@"全部车位" forState:UIControlStateNormal];
        self.categoryOneLabel.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [self.categoryOneLabel setTitleColor:fontColorBlack forState:UIControlStateNormal];
        [self.categoryOneLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self.categoryView addSubview:self.categoryOneLabel];
        
        self.categoryOneBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/categoryCount-50)/2, self.categoryView.frame.size.height-2, 50, 2)];
        self.categoryOneBackage.backgroundColor = [UIColor blackColor];
        [self.categoryOneLabel addSubview:self.categoryOneBackage];
        
        [self.categoryViewArray addObject:self.categoryOneLabel];
        [self.categoryBackageArray addObject:self.categoryOneBackage];
        
        //类别2
        self.categoryTwoLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/categoryCount*1, 0, ScreenWidth/categoryCount, self.categoryView.frame.size.height)];
        self.categoryTwoLabel.tag = 198821;
        [self.categoryTwoLabel setTitle:@"价格最低" forState:UIControlStateNormal];
        self.categoryTwoLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.categoryTwoLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryTwoLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryTwoLabel];
        
        self.categoryTwoBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/categoryCount-50)/2, self.categoryView.frame.size.height-2, 50, 2)];
        self.categoryTwoBackage.backgroundColor = [UIColor blackColor];
        self.categoryTwoBackage.hidden = YES;
        [self.categoryTwoLabel addSubview:self.categoryTwoBackage];
        
        [self.categoryViewArray addObject:self.categoryTwoLabel];
        [self.categoryBackageArray addObject:self.categoryTwoBackage];
        
        //类别3
        self.categoryThreeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/categoryCount*2, 0, ScreenWidth/categoryCount, self.categoryView.frame.size.height)];
        self.categoryThreeLabel.tag = 198822;
        [self.categoryThreeLabel setTitle:@"充电车位" forState:UIControlStateNormal];
        self.categoryThreeLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.categoryThreeLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
        [self.categoryThreeLabel addTarget:self action:@selector(clickWithCategory:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryView addSubview:self.categoryThreeLabel];
        
        self.categoryThreeBackage = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/categoryCount-50)/2, self.categoryView.frame.size.height-2, 50, 2)];
        self.categoryThreeBackage.backgroundColor = [UIColor blackColor];
        self.categoryThreeBackage.hidden = YES;
        [self.categoryThreeLabel addSubview:self.categoryThreeBackage];
        
        [self.categoryViewArray addObject:self.categoryThreeLabel];
        [self.categoryBackageArray addObject:self.categoryThreeBackage];
        
        
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
            myLabel.titleLabel.font = [UIFont boldSystemFontOfSize:12];
             [myLabel setTitleColor:fontColorBlack forState:UIControlStateNormal];
        }else{
            //             NSLog(@"修改为未选中%ld",myButton.tag);
            UIButton *myLabel = self.categoryViewArray[i];
            myLabel.titleLabel.font = [UIFont systemFontOfSize:12];
            myBackage.hidden = YES;
             [myLabel setTitleColor:fontColorLightgray forState:UIControlStateNormal];
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
    float rowHeight = 100;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"SearchPartCell";
    
    SearchPartCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[SearchPartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"点击了一个cell");
    
    SearchPartDetailController *searchPartDetailController = [[SearchPartDetailController alloc]init];
    [self.navigationController pushViewController:searchPartDetailController animated:YES];
}


#pragma mark - textFile代理
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    currentTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [currentTextField resignFirstResponder];
    NSString *searchText = textField.text;
    NSLog(@"搜索框输入的内容为%@！！！！！！！",searchText);
    self.searchedContent = nil;         //开始输入后，清楚之前确认的内容
    self.searchedContent = searchText; //正在输入的内容
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end