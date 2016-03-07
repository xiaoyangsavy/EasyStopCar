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
//        self.cutLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
 
  
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
        
        
        self.searchDistance = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-100, (100-20)/2, 85, 20)];
        self.searchDistance.font = [UIFont systemFontOfSize:9];
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
    
    
    self.searchName.text = myDictionary[@"name"];
//    self.searchPartCount.text = myDictionary[@"parkCount"];
    NSString *parkCountString = [NSString stringWithFormat:@"%@个车位",myDictionary[@"parkCount"]];
     NSString *parkCount =  myDictionary[@"parkCount"];
 
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString:parkCountString];
    [orderStateAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,parkCount.length)];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0,parkCount.length)];
    self.searchPartCount.attributedText = orderStateAttributedString;
    
    
//    self.searchDistance.text = myDictionary[@"distance"];
    
    NSString *distanceString = [NSString stringWithFormat:@"%@km",myDictionary[@"distance"]];
    NSString *distance =  myDictionary[@"distance"];
    
    NSMutableAttributedString *distanceAttributedString = [[NSMutableAttributedString alloc] initWithString:distanceString];
    [distanceAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,distance.length)];
    [distanceAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0,distance.length)];
    self.searchDistance.attributedText = distanceAttributedString;
    
 
    self.searchPrice.text = [NSString stringWithFormat:@"￥%@/小时",myDictionary[@"price"]];
    self.searchBusinessHours.text = myDictionary[@"time"];
    
  
}

@end
