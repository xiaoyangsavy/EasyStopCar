//
//  EditSelectCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/3.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "EditSelectCell.h"
#import "Define.h"
@implementation EditSelectCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.selectFlag = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-marginSize-20, 0, 20, 50)];
        self.selectFlag.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.selectFlag];
        
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
    self.nameLabel.text = myDictionary[@"title"];
    
    if ([myDictionary[@"type"] isEqualToString:@"0"]) {
          self.selectFlag.backgroundColor = [UIColor greenColor];
    }else{
     self.selectFlag.backgroundColor = [UIColor redColor];
    }
 
    
    
    
    
}

@end
