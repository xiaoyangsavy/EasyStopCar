//
//  CommonTools.m
//  EasyStopCar
//
//  Created by savvy on 16/3/1.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "CommonTools.h"
 
@implementation CommonTools




//UIView转UIImage
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//获取年月日时分秒1：年；2：月；3：日；4：时；5：分；6：秒
-(NSInteger)getDataAndTime:(int)type{
    //获取当前时间
    NSInteger returnVaule = 0;
        NSDate *now = [NSDate date];
       NSLog(@"now date is: %@", now);
    
       NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
      NSInteger year = [dateComponent year];
         NSInteger month = [dateComponent month];
        NSInteger day = [dateComponent day];
        NSInteger hour = [dateComponent hour];
        NSInteger minute = [dateComponent minute];
      NSInteger second = [dateComponent second];
    
       NSLog(@"year is: %ld", (long)year);
        NSLog(@"month is: %ld", (long)month);
        NSLog(@"day is: %ld", (long)day);
       NSLog(@"hour is: %ld", (long)hour);
        NSLog(@"minute is: %ld", (long)minute);
        NSLog(@"second i%ld", (long) second);
    
    switch (type) {
        case 1:
             returnVaule = year;
            break;
        case 2:
            returnVaule = month;
            break;
        case 3:
            returnVaule = day;
            break;
        case 4:
            returnVaule = hour;
            break;
        case 5:
            returnVaule = minute;
            break;
        case 6:
            returnVaule = second;
            break;
        default:
            break;
    }
    return returnVaule;

    
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"dateString:%@",dateString);
}

@end
