//
//  InputItemModel.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/18.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "InputItemModel.h"

@implementation InputItemModel

- (id)initWithFrame:(CGRect)frame iconImage:(NSString *)imageName text:(NSString *)text placeHolderText:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        
        //设置圆角边框
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        //设置边框及边框颜色
        self.layer.borderWidth = 0.5;
        self.layer.borderColor =[[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0] CGColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(14,(self.frame.size.height-20)/2, 20, 20)];
        icon.image = [UIImage imageNamed:imageName];
        [self addSubview:icon];
        self.iconImageView = icon;
        
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(icon.frame.origin.x+icon.frame.size.width+10, 0, 211, self.frame.size.height)];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        textField.delegate = self;
        textField.placeholder = placeholder;
        textField.text = text;
        self.textField = textField;
        [self addSubview:textField];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.layer.borderColor =[[UIColor colorWithRed:252/255.0 green:175/255.0 blue:23/255.0 alpha:1] CGColor];
    [self.delegate textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length==0) {
         self.layer.borderColor =[[UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0] CGColor];
    }
     [self.delegate textFieldDidEndEditing:textField];
}
 

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [self.delegate textFieldShouldReturn:textField];
}
@end
