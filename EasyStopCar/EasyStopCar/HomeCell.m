//
//  HomeCell.m
//  EasyStopCar
//  
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "HomeCell.h"
#import "Define.h"
@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.contentView.backgroundColor = backageColorLightgray;
        
        
        //内容主体视图
        self.myContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 9, ScreenWidth, 108.5)];
        self.myContentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.myContentView];
        
        CALayer *topBorder=[[CALayer alloc]init];
        topBorder.frame=CGRectMake(0, 0, self.myContentView.frame.size.width, 0.5);
        topBorder.backgroundColor=lineColorLightgray.CGColor;
        [self.myContentView.layer addSublayer:topBorder ];
        
        CALayer *bottomBorder=[[CALayer alloc]init];
        bottomBorder.frame=CGRectMake(0, self.myContentView.frame.size.height-0.5, self.myContentView.frame.size.width, 0.5);
        bottomBorder.backgroundColor=lineColorLightgray.CGColor;
        [self.myContentView.layer addSublayer:bottomBorder ];
        
        
        //详细内容视图
        self.homeDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(39, 30, 200, 15)];
        self.homeDataLabel.font = [UIFont systemFontOfSize:12];
        self.homeDataLabel.textColor = fontColorLightgray;
        [self.contentView addSubview:self.homeDataLabel];
        
        self.homeTitle = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-150, 30, 150-marginSize, 15)];
        self.homeTitle.font = [UIFont boldSystemFontOfSize:14];
        self.homeTitle.textAlignment = NSTextAlignmentRight;
        self.homeTitle.textColor = backageColorRed;
        [self.contentView addSubview:self.homeTitle];
        
        //分割线
        self.homeLine = [[UIView alloc] initWithFrame:CGRectMake(marginSize, self.homeDataLabel.frame.origin.y+self.homeDataLabel.frame.size.height+10, ScreenWidth-marginSize, 0.5)];
        self.homeLine.backgroundColor =  lineColorLightgray;
        [self.contentView addSubview:self.homeLine];
        
        //地址视图
        self.homeLocationIco = [[UIImageView alloc] initWithFrame:CGRectMake(marginSize+4, self.homeLine.frame.origin.y+self.homeLine.frame.size.height+10, 9, 12)];
        self.homeLocationIco.contentMode = UIViewContentModeScaleAspectFit;
        [self.homeLocationIco setImage:[UIImage imageNamed:@"ico_home_cell_location"]];
        [self.contentView addSubview:self.homeLocationIco];
        
        self.homeLocationTitle = [[UILabel alloc] initWithFrame:CGRectMake(39, self.homeLocationIco.frame.origin.y-2, 200, 15)];
        self.homeLocationTitle.font = [UIFont systemFontOfSize:14];
        self.homeLocationTitle.textColor = fontColorGray;
        [self.contentView addSubview:self.homeLocationTitle];
        
        self.homeLocationContent = [[UILabel alloc] initWithFrame:CGRectMake(self.homeLocationTitle.frame.origin.x, self.homeLocationTitle.frame.origin.y+self.homeLocationTitle.frame.size.height+5, 200, 15)];
        self.homeLocationContent.font = [UIFont boldSystemFontOfSize:14];
        self.homeLocationContent.textColor = fontColorGray;
        [self.contentView addSubview:self.homeLocationContent];
        
        self.homeLocationFlag = [[UIImageView alloc] initWithFrame:CGRectMake(150, self.homeLocationContent.frame.origin.y, 15, 15)];
        self.homeLocationFlag.contentMode = UIViewContentModeScaleAspectFit;
        [self.homeLocationFlag setImage:[UIImage imageNamed:@"ico_home_cell_flag"]];
        [self.contentView addSubview:self.homeLocationFlag];

        
        self.homeButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-70-marginSize,  self.homeLine.frame.origin.y+(118.5-self.homeLine.frame.origin.y-25)/2, 70, 25)];
        self.homeButton.layer.cornerRadius = 4;
        self.homeButton.layer.masksToBounds = YES;
        self.homeButton.userInteractionEnabled = NO;
        self.homeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.homeButton];
        
    }
    return self;
}


- (void)setCellInfo:(NSDictionary *)myDictionary
{
    
    NSLog(@"cell数据为%@!!!!!!!",myDictionary);
    

    self.homeDataLabel.text = [NSString stringWithFormat:@"预约时间：%@",myDictionary[@"testText"]];
     self.homeTitle.text = myDictionary[@"testText"];
     self.homeLocationTitle.text = myDictionary[@"testText"];
     self.homeLocationContent.text = myDictionary[@"testText"];
    
   
    
    if ([myDictionary[@"testFlag"] isEqualToString:@"0"]) {
//        self.homeButton.image = [UIImage imageNamed:@"button_home_state_appoint"];
//        [self.homeButton  setImage:[UIImage imageNamed:@"button_home_state_appoint"] forState:UIControlStateNormal];
        self.homeButton.backgroundColor = backageColorBlue;
        [self.homeButton setTitle:@"已预约" forState:UIControlStateNormal];
        
    }else if ([myDictionary[@"testFlag"] isEqualToString:@"1"]) {
        self.homeButton.backgroundColor = backageColorGreen;
        [self.homeButton setTitle:@"停车" forState:UIControlStateNormal];
    
    }else if ([myDictionary[@"testFlag"] isEqualToString:@"2"]) {
        self.homeButton.backgroundColor = backageColorYellow;
        [self.homeButton setTitle:@"取车" forState:UIControlStateNormal];
        
    }else if ([myDictionary[@"testFlag"] isEqualToString:@"3"]) {
        self.homeButton.backgroundColor = backageColorRed;
        [self.homeButton setTitle:@"去付款" forState:UIControlStateNormal];
        
    }else if ([myDictionary[@"testFlag"] isEqualToString:@"4"]) {
        self.homeButton.backgroundColor = backageColorLightgray;
        [self.homeButton setTitle:@"已完成" forState:UIControlStateNormal];
        
    }
    
    
    
    
}



@end
