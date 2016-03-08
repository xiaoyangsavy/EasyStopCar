//
//  SearchAppointSelectController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/4.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchAppointSelectController.h"

@interface SearchAppointSelectController ()
{
    UITextField *currentTextField;
}

@property(nonatomic,strong) UITableView *serachTableView;//列表
@property(nonatomic,strong) UIView *searchView;//搜索视图
@property(nonatomic,strong) UILabel *cityLabel;//城市
@property(nonatomic,strong) UIImageView *cityFlag;//城市标记
@property(nonatomic,strong) UITextField *locationTextField;//搜索框

@property(nonatomic,strong)NSMutableArray *serachViewArray;
@end

@implementation SearchAppointSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [super initNavBarItems:@"选择目的地"];
    
    self.serachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.serachTableView.delegate = self;
    self.serachTableView.dataSource = self;
    self.serachTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.serachTableView.backgroundColor = [UIColor whiteColor];
    [self.serachTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.serachTableView];
    
    
    //设置表头部个人信息
    self.serachTableView.tableHeaderView = ({
        
        UIView *myTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 60)];
        myTableHeadView.backgroundColor = backageColorLightgray;
        
        
        //列表区域
        self.searchView = [[UIView alloc]initWithFrame:CGRectMake(marginSize, 10, ScreenWidth-marginSize*2, 40)];
        self.searchView.backgroundColor = [UIColor whiteColor];
        self.searchView.layer.cornerRadius = 5;
        self.searchView.layer.masksToBounds = YES;
        //设置边框及边框颜色
        self.searchView.layer.borderWidth = 0.5;
        self.searchView.layer.borderColor =[lineColorGray CGColor];
        [myTableHeadView addSubview:self.searchView];
        
       
        
        self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(marginSize, 0, 30, self.searchView.frame.size.height)];
        self.cityLabel.text = @"北京";
        self.cityLabel.textColor = fontColorBlack;
        self.cityLabel.font = [UIFont systemFontOfSize:14];
        [self.searchView addSubview:self.cityLabel];
        
        self.cityFlag = [[UIImageView alloc]initWithFrame:CGRectMake(self.cityLabel.frame.origin.x+self.cityLabel.frame.size.width+3, 0,10, self.searchView.frame.size.height)];
        self.cityFlag.image = [UIImage imageNamed:@"ico_arrow_down"];
        self.cityFlag.contentMode = UIViewContentModeScaleAspectFit;
        [self.searchView addSubview:self.cityFlag];
        
        self.locationTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.cityFlag.frame.origin.x+self.cityFlag.frame.size.width+10, 0, 150, self.searchView.frame.size.height)];
        self.locationTextField.placeholder = @"请输入地址";
        self.locationTextField.font = [UIFont systemFontOfSize:12];
        [self.searchView addSubview:self.locationTextField];
        
        
        
        
        myTableHeadView;
    });

    
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 40;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=self.myArray[indexPath.row][@"testText"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"点击了一个cell");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"reloadLocationInfo"
     object:self.myArray[indexPath.row][@"testText"]];
    
    [self toReturn];
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
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
