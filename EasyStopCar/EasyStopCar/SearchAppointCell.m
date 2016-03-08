//
//  SearchAppointCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchAppointCell.h"
#import "Define.h"

@implementation SearchAppointCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
       
        
        self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginSize, 0, 12, 50)];
        self.searchImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
        self.searchImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.searchImageView];
        
        
        self.searchName = [[UILabel alloc] initWithFrame:CGRectMake(self.searchImageView.frame.origin.x+self.searchImageView.frame.size.width+15, 0, 200, 50)];
        self.searchName.font = [UIFont systemFontOfSize:15];
        self.searchName.textColor = fontColorBlack;
        [self.contentView addSubview:self.searchName];
        
//        self.searchFlag = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-marginSize-7, 0, 7, 50)];
//        self.searchFlag.contentMode = UIViewContentModeScaleAspectFit;
//        [self.searchFlag setImage:[UIImage imageNamed:@"ico_home_select_arrow"]];
//        [self.contentView addSubview:self.searchFlag];
        
        
        self.cutLine = [[UIView alloc]initWithFrame:CGRectMake(0, 50-0.5, ScreenWidth, 0.5)];
        self.cutLine.backgroundColor = lineColorLightgray;
        [self.contentView addSubview:self.cutLine];
 
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
    
    self.searchName.text = myDictionary[@"title"];
   self.searchImageView.image = myDictionary[@"image"];
  
    
    
}


@end
