//
//  ASCommonTipPopoView.h
//  ASCommonTipPopoView
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASCommonTipPopoView : UIView

/// 纯文本提示信息
/// @param message 提示信息
+ (instancetype)showCommonTipPopoViewWithMessage:(NSString *)message;

/// 有显示图标的提示信息
/// @param message 提示信息
+ (instancetype)showCommonTipPopoViewWithTipMessage:(NSString *)message;

/// 有显示错误提示图标的提示信息
/// @param message 提示信息
+ (instancetype)showCommonTipPopoViewWithErrorMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
