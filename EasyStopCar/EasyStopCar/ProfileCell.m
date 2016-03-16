//
//  ProfileCell.m
//  BeautyMakeup
//
//  Created by hers on 13-11-14.
//  Copyright (c) 2013年 hers. All rights reserved.
//
#import "Define.h"
#import "ProfileCell.h"

@implementation ProfileCell

 

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 0, 20.0f, 45)];
        self.userImageView.backgroundColor = [UIColor clearColor];
        self.userImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.userImageView];
       
        self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userImageView.frame.origin.x+self.userImageView.frame.size.width+12, 0, 130.0f, 45)];
        self.userNameLabel.font = [UIFont systemFontOfSize:15];
        self.userNameLabel.textAlignment = NSTextAlignmentLeft;
//        titleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
        self.userNameLabel.textColor = fontColorBlack;
//        self.userNameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.userNameLabel];
       
        self.userContentLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.userNameLabel.frame.origin.x+60, 0, 150.0f, 45)];
        self.userContentLabel.font = [UIFont systemFontOfSize:15];
//        self.userContentLabel.textAlignment = NSTextAlignmentRight;
        //        titleLabel.textColor = [UIColor colorWithRed:0x64/255.0f green:0x64/255.0f blue:0x64/255.0f alpha:1.0f];
        self.userContentLabel.textColor = backageColorRed;
        self.userContentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.userContentLabel];
        
 
        self.userPayButton = [[UIButton alloc] initWithFrame:CGRectMake( ScreenWidth-marginSize-60, (45-30)*0.5, 60, 30)];
        [self.userPayButton setTitle:@"充值" forState:UIControlStateNormal];
        self.userPayButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.userPayButton.backgroundColor = backageColorYellow;
        self.userPayButton.layer.cornerRadius = 5;
        self.userPayButton.layer.masksToBounds = YES;
        self.userPayButton.userInteractionEnabled = NO;
        self.userPayButton.hidden = YES;
        [self addSubview:self.userPayButton];
        
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
    [self.userImageView setImage:myDictionary[@"image"]];
    [self.userNameLabel setText:myDictionary[@"name"]];
    [self.userContentLabel setText:myDictionary[@"content"]];
    
    if ([myDictionary[@"name"] isEqualToString:@"我的钱包"]) {
        self.userPayButton.hidden = NO;
    }
    
    
    
    
}
@end
