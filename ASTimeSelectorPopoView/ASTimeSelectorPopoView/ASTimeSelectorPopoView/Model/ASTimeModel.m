//
//  ASTimeModel.m
//  ASTimeSelectorPopoView
//
//  Created by Mac on 2020/6/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ASTimeModel.h"

@implementation ASTimeModel

- (void)setYearMonthDay:(NSString *)yearMonthDay {
    
    _yearMonthDay = yearMonthDay;
    
    NSInteger year = [[_yearMonthDay componentsSeparatedByString:@"年"].firstObject integerValue];
    NSString *monthDayString = [_yearMonthDay componentsSeparatedByString:@"年"].lastObject;
    NSInteger month = [[monthDayString componentsSeparatedByString:@"月"].firstObject integerValue];
    NSString *dayString = [monthDayString componentsSeparatedByString:@"月"].lastObject;
    NSInteger day = [[dayString componentsSeparatedByString:@"日"].firstObject integerValue];
    
    [self caculateWeekDayWithYear:year month:month day:day];
}

- (void)caculateWeekDayWithYear:(NSInteger) year month:(NSInteger)month day:(NSInteger)day {
    
    if(month == 1 || month == 2) {
        month += 12;
        year--;
    }
    
    NSInteger iWeek = (day + 2 * month + 3 * (month + 1) / 5 + year + year / 4 - year / 100 + year / 400) % 7;
    
    switch (iWeek) {
        case 0:
            NSLog(@"星期一");
            self.weekday = @"周一";
            break;
            
        case 1:
            NSLog(@"星期二");
            self.weekday = @"周二";
            break;
            
        case 2:
            NSLog(@"星期三");
            self.weekday = @"周三";
            break;
            
        case 3:
            NSLog(@"星期四");
            self.weekday = @"周四";
            break;
            
        case 4:
            NSLog(@"星期五");
            self.weekday = @"周五";
            break;
            
        case 5:
            NSLog(@"星期六");
            self.weekday = @"周六";
            break;
            
        case 6:
            NSLog(@"星期日");
            self.weekday = @"周日";
            break;
            
            
        default:
            break;
    }
}



@end
