//
//  UserInfoController.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UserInfoController.h"
#import "UserInfoCell.h"
#import "EditTextController.h"
#import "EditSeleceController.h"

@interface UserInfoController ()

@property(nonatomic,strong) UITableView *userInfoTableView;//列表
@property(nonatomic,strong) NSString *lastChosenMediaType;//拍照方式
@property(nonatomic,strong) UIImage *chosenImage;//取得的头像照片

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super initNavBarItems:@"我的资料"];
    
    
    
    
    
    self.userInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.userInfoTableView.delegate = self;
    self.userInfoTableView.dataSource = self;
    self.userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.userInfoTableView.backgroundColor = [UIColor whiteColor];
    [self.userInfoTableView setTableFooterView:[[UIView alloc]init]];
    [self.view addSubview:self.userInfoTableView];
    
}


//测试数据
-(void) initInfoArray{
    //测试数据
    self.myArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *myDictionary = nil;
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"头像" forKey:@"title"];
    [myDictionary setValue:nil forKey:@"content"];
    [myDictionary setValue:[UIImage imageNamed:@"image_user_head"] forKey:@"image"];
    [myDictionary setValue:@"0" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"姓名" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"车牌号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"手机号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"性别" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"邮箱" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"职业" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
    
    myDictionary = [[NSMutableDictionary alloc] init];
    [myDictionary setValue:@"身份证号" forKey:@"title"];
    [myDictionary setValue:@"未知" forKey:@"content"];
    [myDictionary setValue:nil forKey:@"image"];
    [myDictionary setValue:@"1" forKey:@"type"];
    [self.myArray addObject:myDictionary];
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float rowHeight = 45;
    return rowHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.myArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableIdentifier = @"UserInfoCell";
    
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell)
    {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row != 0) {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setCellInfo:self.myArray[indexPath.row]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"点击了一个cell");
    
    if (indexPath.row == 0) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择图片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [alert show];
        
    }else  if (indexPath.row == 4) {
        EditSeleceController  *myController = [[EditSeleceController alloc]init];
        [self.navigationController pushViewController:myController animated:YES];
    }else{
    EditTextController *myController = [[EditTextController alloc]init];
    myController.editString = self.myArray[indexPath.row][@"content"];
    [self.navigationController pushViewController:myController animated:YES];
    }
}


#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPiicturePrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
    {
        NSLog(@"获取照片成功，开始显示");
        
        self.chosenImage=[info objectForKey:UIImagePickerControllerEditedImage];
        //                     self.photographImageView.image=chosenImage;
  
        self.myArray[0][@"image"] = self.chosenImage;
        [self.userInfoTableView reloadData];//重载列表
   
 
        
    }
    if([self.lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:^{
        }];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
