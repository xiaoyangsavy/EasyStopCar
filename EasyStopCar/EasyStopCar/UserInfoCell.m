//
//  UserInfoCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "UserInfoCell.h"
#import "Define.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 45)];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textColor = fontColorBlack;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, ScreenWidth - 135, 45)];
        self.valueLabel.font = [UIFont systemFontOfSize:15];
        self.valueLabel.textColor = fontColorLightgray;
        self.valueLabel.textAlignment = NSTextAlignmentRight;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.valueLabel];
        
         self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 50-marginSize, 5 , 35, 35)];
        self.myImageView.image = [UIImage imageNamed:@"image_user_head"];
        self.myImageView.hidden = YES;
        self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
         [self.contentView addSubview:self.myImageView];
        
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
    
    self.nameLabel.text = myDictionary[@"title"];
    self.valueLabel.text = myDictionary[@"content"];
    
    if (myDictionary[@"image"] != nil) {
        self.myImageView.hidden = NO;
        self.valueLabel.hidden = YES;
        self.myImageView.image = myDictionary[@"image"];
    }
    
    
}

@end
