//
//  PayDetailCell.m
//  EasyStopCar
//
//  Created by savvy on 16/3/4.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "PayDetailCell.h"
#import "Define.h"

@implementation PayDetailCell

- (void)awakeFromNib {
    // Initialization code
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.payDetailIco = [[UIImageView alloc] initWithFrame:CGRectMake(marginSize, 12, 15, 15)];
        self.payDetailIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.payDetailIco];
        
        
        self.payDetailTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.payDetailIco.frame.origin.x+self.payDetailIco.frame.size.width+15, self.payDetailIco.frame.origin.y,80, 15)];
        self.payDetailTitle.font = [UIFont systemFontOfSize:14];
        self.payDetailTitle.textColor = fontColorBlack;
        [self.contentView addSubview:self.payDetailTitle];
        
        self.payDetailTime = [[UILabel alloc] initWithFrame:CGRectMake(self.payDetailTitle.frame.origin.x+self.payDetailTitle.frame.size.width, self.payDetailIco.frame.origin.y,100, 15)];
        self.payDetailTime.font = [UIFont systemFontOfSize:12];
        self.payDetailTime.textColor = fontColorLightgray;
        [self.contentView addSubview:self.payDetailTime];
        
        
        self.payDetailValue = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-40-80-30, self.payDetailIco.frame.origin.y,80, 15)];
        self.payDetailValue.font = [UIFont systemFontOfSize:14];
        self.payDetailValue.textColor = backageColorRed;
        self.payDetailValue.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.payDetailValue];
        
        
        self.payDetailContent = [[UILabel alloc] initWithFrame:CGRectMake(self.payDetailTitle.frame.origin.x, self.payDetailTitle.frame.origin.y+self.payDetailTitle.frame.size.height+5,self.contentView.frame.size.width-80, 30)];
        self.payDetailContent.font = [UIFont systemFontOfSize:12];
        self.payDetailContent.textColor = fontColorLightgray;
        self.payDetailContent.lineBreakMode = NSLineBreakByWordWrapping;
        self.payDetailContent.numberOfLines = 0;//上面两行设置多行显示
        [self.contentView addSubview:self.payDetailContent];
        
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    
     self.payDetailIco.image = [UIImage imageNamed:myDictionary[@"image"]];
    self.payDetailTitle.text = myDictionary[@"title"];
    self.payDetailTime.text = myDictionary[@"time"];
     self.payDetailValue.text = myDictionary[@"value"];
     self.payDetailContent.text = myDictionary[@"content"];
    
    if ([myDictionary[@"type"] isEqualToString:@"1"]) {
        self.payDetailValue.textColor = backageColorBlue;
    }else{
        self.payDetailValue.textColor = backageColorRed;
    }
 
    
    
}

@end
