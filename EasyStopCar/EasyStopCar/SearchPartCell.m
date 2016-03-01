//
//  SearchPartCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartCell.h"
#import "Define.h"
@implementation SearchPartCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.cutLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
 
  
        self.searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.searchImageView.image = [UIImage imageNamed:@"test_picture.jpg"];
        [self.contentView addSubview:self.searchImageView];
        
        
        self.searchName = [[UILabel alloc] initWithFrame:CGRectMake(self.searchImageView.frame.origin.x+self.searchImageView.frame.size.width+15, 20, 100, 15)];
        self.searchName.font = [UIFont systemFontOfSize:15];
        self.searchName.textColor = fontColorBlack;
        [self.contentView addSubview:self.searchName];
        
        self.searchFlag = [[UIImageView alloc] initWithFrame:CGRectMake(150, self.searchName.frame.origin.y, 15, 15)];
        self.searchFlag.contentMode = UIViewContentModeScaleAspectFit;
        [self.searchFlag setImage:[UIImage imageNamed:@"ico_home_cell_flag"]];
        [self.contentView addSubview:self.searchFlag];
        
        self.searchPartCount = [[UILabel alloc] initWithFrame:CGRectMake(self.searchName.frame.origin.x, self.searchName.frame.origin.y+self.searchName.frame.size.height+5, 100, 15)];
        self.searchPartCount.font = [UIFont systemFontOfSize:12];
        self.searchPartCount.textColor = fontColorGray;
        [self.contentView addSubview:self.searchPartCount];
        
        
        self.searchDistance = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, (100-15)/2, 85, 15)];
        self.searchDistance.font = [UIFont systemFontOfSize:15];
        self.searchDistance.textColor = fontColorGray;
        self.searchDistance.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.searchDistance];
        
        self.searchPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.searchName.frame.origin.x, 100-15-15, 70, 15)];
        self.searchPrice.font = [UIFont systemFontOfSize:14];
        self.searchPrice.textColor = backageColorRed;
        [self.contentView addSubview:self.searchPrice];
        
        self.searchBusinessHours = [[UILabel alloc] initWithFrame:CGRectMake(self.searchPrice.frame.origin.x+self.searchPrice.frame.size.width+5, 100-10-15, 100, 10)];
        self.searchBusinessHours.font = [UIFont systemFontOfSize:9];
        self.searchBusinessHours.textColor = fontColorBlack;
        [self.contentView addSubview:self.searchBusinessHours];
        
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
    
    self.searchName.text = myDictionary[@"testText"];
    self.searchPartCount.text = myDictionary[@"testText"];
    self.searchDistance.text = myDictionary[@"testText"];
    self.searchPrice.text = myDictionary[@"testText"];
    self.searchBusinessHours.text = myDictionary[@"testText"];
    
    
    
   
    
}

@end
