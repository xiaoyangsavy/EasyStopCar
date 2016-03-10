//
//  MemberAccountCell.m
//  EasyStopCar
//  会员充值记录cell
//  Created by savvy on 16/3/8.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "MemberAccountCell.h"
#import "Define.h"

@implementation MemberAccountCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.memberIco = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 12, 12)];
        self.memberIco.image = [UIImage imageNamed:@"ico_home_cell_location"];
        self.memberIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.memberIco];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.memberIco.frame.origin.x+self.memberIco.frame.size.width+5, 15, 300, 15)];
        self.nameLabel.textColor = fontColorGray;
        self.nameLabel.text = @"暂无";
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, 63-15-15, ScreenWidth-40, 15)];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.text = @"0000/00/00";
        self.contentLabel.textColor = fontColorGray;
        [self.contentView addSubview:self.contentLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame: CGRectMake(ScreenWidth-150-30, 0, 150, 63)];
        self.numberLabel.font = [UIFont systemFontOfSize:14];
        self.numberLabel.text = @"0.00";
        self.numberLabel.textAlignment = NSTextAlignmentRight;
        self.numberLabel.textColor = fontColorGray;
        [self.numberLabel setUserInteractionEnabled:NO];
        [self.contentView addSubview:self.numberLabel];
        
        
        CALayer *changeViewTopBorder=[[CALayer alloc]init];
        changeViewTopBorder.frame=CGRectMake(0, 63-0.5, ScreenWidth, 0.5);
        changeViewTopBorder.backgroundColor=lineColorLightgray.CGColor;
        [self.contentView.layer addSublayer:changeViewTopBorder];
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    NSLog(@"会员流水cell数据：%@!!!!",myDictionary);
    
    self.nameLabel.text = myDictionary[@"name"];
    self.contentLabel.text = myDictionary[@"addtime"];
    self.numberLabel.text =   [NSString stringWithFormat:@"%@%@",myDictionary[@"type"],myDictionary[@"sums"] ];
    
    if ([myDictionary[@"type"] isEqualToString:@"+"]) {
        self.numberLabel.textColor = backageColorYellow;
    }
    
    
    
}


@end
