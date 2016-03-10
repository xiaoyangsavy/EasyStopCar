//
//  CouponCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/9.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "CouponCell.h"
#import "Define.h"

@implementation CouponCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = backageColorLightgray;
//         self.myTableView.backgroundColor = backageColorLightgray;
        self.backageView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-10*2, 120)];
        //设置圆角边框
        self.backageView.layer.cornerRadius = 8;
        self.backageView.layer.masksToBounds = YES;
        //设置边框及边框颜色
        self.backageView.layer.borderWidth = 0.5;
        self.backageView.layer.borderColor =[lineColorLightgray CGColor];
        self.backageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backageView];
        
        self.couponPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 82)];
        self.couponPriceLabel.font = [UIFont systemFontOfSize:60];
        self.couponPriceLabel.text = @"￥0";
        self.couponPriceLabel.textColor = backageColorYellow;
        [self.backageView addSubview:self.couponPriceLabel];
        
        self.couponNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, self.backageView.frame.size.width-140-15, 30)];
        self.couponNameLabel.font = [UIFont systemFontOfSize:12];
        self.couponNameLabel.text = @"暂无名称";
        self.couponNameLabel.textColor = fontColorGray;
        self.couponNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.couponNameLabel.numberOfLines = 2;//上面两行设置多行显示
        [self.backageView addSubview:self.couponNameLabel];
        
        self.couponContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.couponNameLabel.frame.origin.x, self.couponNameLabel.frame.size.height+20, 100, 20)];
        self.couponContentLabel.font = [UIFont systemFontOfSize:16];
        self.couponContentLabel.text = @"首单使用";
        self.couponContentLabel.textColor = fontColorGray;
        [self.backageView addSubview:self.couponContentLabel];
        
        self.couponDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.backageView.frame.size.height-28, self.backageView.frame.size.width-15, 28)];
        self.couponDateLabel.font = [UIFont systemFontOfSize:12];
        self.couponDateLabel.text = @"使用期限";
        self.couponDateLabel.textColor = fontColorGray;
        self.couponDateLabel.textAlignment = NSTextAlignmentRight;
        [self.backageView addSubview:self.couponDateLabel];
        
        self.couponFlagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-80, 0, 80, 80)];
        self.couponFlagImageView.image = [UIImage imageNamed:@"image_coupon_flag_invalid"];
        self.couponFlagImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.couponFlagImageView];
        
        
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(self.backageView.frame.origin.x, self.backageView.frame.origin.y+self.backageView.frame.size.height-40, self.backageView.frame.size.width, 10)];
        self.lineView.image = [UIImage imageNamed:@"backage_coupon_line"];
        self.lineView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.lineView];
        
       
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
 
    NSLog(@"优惠券cell信息%@!!!!!!!",myDictionary);
    
    NSString *moneyString = myDictionary[@"money"];
 
    NSMutableAttributedString *orderStateAttributedString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@元",moneyString]];
    [orderStateAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(moneyString.length, 1)];
    self.couponPriceLabel.attributedText = orderStateAttributedString;
    
    if ([myDictionary[@"type"] integerValue]==0) {
        self.couponPriceLabel.textColor = backageColorYellow;
        self.couponNameLabel.textColor = fontColorBlack;
        self.couponContentLabel.textColor = fontColorBlack;
        self.couponDateLabel.textColor = fontColorBlack;
        self.couponFlagImageView.hidden = YES;
        //        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backage_coupon_usable"]];
//        self.backageView.image = [UIImage imageNamed:@"backage_coupon_usable"];
    }else{
        self.couponPriceLabel.textColor = fontColorLightgray;
        self.couponNameLabel.textColor = fontColorLightgray;
        self.couponContentLabel.textColor = fontColorLightgray;
        self.couponDateLabel.textColor = fontColorLightgray;
        self.couponFlagImageView.hidden = NO;
        
        if ([myDictionary[@"type"] integerValue]==1) {
            self.couponFlagImageView.image = [UIImage imageNamed:@"image_coupon_flag_invalid"];
        }else if ([myDictionary[@"type"] integerValue]==2) {
            self.couponFlagImageView.image = [UIImage imageNamed:@"image_coupon_flag_use"];
        }

    }
    
    
    
    
    self.couponNameLabel.text = [NSString stringWithFormat:@"%@\n",myDictionary[@"name"]];
    self.couponDateLabel.text = [NSString stringWithFormat:@"使用期限 %@",myDictionary[@"userTime"]];
    self.couponContentLabel = myDictionary[@"condition"];
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
