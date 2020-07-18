//
//  ASTimeSelectorPopoView.h
//  ASTimeSelectorPopoView
//
//  Created by Mac on 2020/6/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTimeSelectorPopoView : UIView

+ (instancetype)showTimeSelectorPopoViewWithSelectedTimeOperation:(void(^)(NSString *selectedTime))selectedTimeOperation;

@end

NS_ASSUME_NONNULL_END
