//
//  ASTimeModel.h
//  ASTimeSelectorPopoView
//
//  Created by Mac on 2020/6/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTimeModel : NSObject

/// 年
@property (nonatomic, assign) NSInteger year;

/// 月
@property (nonatomic, assign) NSInteger month;

/// 日
@property (nonatomic, assign) NSInteger day;

/// 年月日
@property (nonatomic, copy) NSString * yearMonthDay;

/// 月日
@property (nonatomic, copy) NSString * monthAndDay;

/// 星期
@property (nonatomic, copy) NSString * weekday;

/// 时间 - 时分
@property (nonatomic, copy) NSString * timeString;


@end

NS_ASSUME_NONNULL_END
