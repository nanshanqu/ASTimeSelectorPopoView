//
//  ASCommonTipPopoView.m
//  ASCommonTipPopoView
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "ASCommonTipPopoView.h"
#import <Masonry.h>

@interface ASCommonTipPopoView ()

@property (nonatomic, strong) UIView * mainBGView;

@property (nonatomic, strong) UIImageView * iconImgView;

@property (nonatomic, strong) UILabel * messageLabel;

@end

static ASCommonTipPopoView *_commonTipPopoViewManager = nil;

@implementation ASCommonTipPopoView

- (instancetype)initCommonTipPopoViewWithMessage:(NSString *)message {
    
    if (self = [super init]) {
        
        [self setupUIWithMessage:message];
    }
    return self;
}

+ (instancetype)showCommonTipPopoViewWithMessage:(NSString *)message {
    
    if (_commonTipPopoViewManager == nil) {
        _commonTipPopoViewManager = [[self alloc] initCommonTipPopoViewWithMessage:message];
        
        _commonTipPopoViewManager.frame = [UIScreen mainScreen].bounds;
//        _commonTipPopoViewManager.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        [mainWindow addSubview:_commonTipPopoViewManager];
    }
    return _commonTipPopoViewManager;
}

- (instancetype)initCommonTipPopoViewWithTipMessage:(NSString *)message {
    
    if (self = [super init]) {
        
        [self setupUIWithTipMessage:message];
    }
    return self;
}

+ (instancetype)showCommonTipPopoViewWithTipMessage:(NSString *)message {
    
    if (_commonTipPopoViewManager == nil) {
        _commonTipPopoViewManager = [[self alloc] initCommonTipPopoViewWithTipMessage:message];
        
        _commonTipPopoViewManager.frame = [UIScreen mainScreen].bounds;
//        _commonTipPopoViewManager.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        [mainWindow addSubview:_commonTipPopoViewManager];
    }
    return _commonTipPopoViewManager;
}

- (instancetype)initCommonTipPopoViewWithErrorMessage:(NSString *)message {
    
    if (self = [super init]) {
        
        [self setupUIWithErrorMessage:message];
    }
    return self;
}

+ (instancetype)showCommonTipPopoViewWithErrorMessage:(NSString *)message {
    
    if (_commonTipPopoViewManager == nil) {
        _commonTipPopoViewManager = [[self alloc] initCommonTipPopoViewWithErrorMessage:message];
        
        _commonTipPopoViewManager.frame = [UIScreen mainScreen].bounds;
//        _commonTipPopoViewManager.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
        [mainWindow addSubview:_commonTipPopoViewManager];
    }
    return _commonTipPopoViewManager;
}

/**
 计算文字尺寸
 
 @param text 需要计算文字的尺寸
 @param font 文字的字体
 @param maxSize 文字的最大尺寸
 @return 返回文字尺寸
 */
- (CGSize)sizeWithText: (NSString *)text font: (UIFont *)font maxSize:   (CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (void)hiddenCommonTipPopoView {
    
    [_commonTipPopoViewManager removeFromSuperview];
    _commonTipPopoViewManager = nil;
}

- (void)setupUIWithMessage:(NSString *)message {
    
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 60;
    
    CGSize messageSize = [self sizeWithText:message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(viewW - 2 * margin , MAXFLOAT)];
    
    CGFloat mainBGViewH = 55;
    if (messageSize.height > mainBGViewH) {
        mainBGViewH = messageSize.height;
    }
    
    [self addSubview:self.mainBGView];
    [self.mainBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80 + messageSize.width, mainBGViewH));
    }];
    
    [self.mainBGView addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(20);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.mainBGView addSubview:self.messageLabel];
    self.messageLabel.text = message;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(messageSize.width + 20, messageSize.height));
    }];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf hiddenCommonTipPopoView];
    });
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCommonTipPopoView)]];
}

- (void)setupUIWithTipMessage:(NSString *)message {
    
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 60;
    
    CGSize messageSize = [self sizeWithText:message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(viewW - 2 * margin , MAXFLOAT)];
    
    CGFloat mainBGViewH = 55;
    if (messageSize.height > mainBGViewH) {
        mainBGViewH = messageSize.height;
    }
    
    [self addSubview:self.mainBGView];
    [self.mainBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80 + messageSize.width, mainBGViewH));
    }];
    
    [self.mainBGView addSubview:self.iconImgView];
    [self.iconImgView setImage:[UIImage imageNamed:@"common_tip_popo_view_icon"]];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(20);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.mainBGView addSubview:self.messageLabel];
    self.messageLabel.text = message;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(messageSize.width + 20, messageSize.height));
    }];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf hiddenCommonTipPopoView];
    });
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCommonTipPopoView)]];
}


- (void)setupUIWithErrorMessage:(NSString *)message {
    
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 60;
    
    CGSize messageSize = [self sizeWithText:message font:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(viewW - 2 * margin , MAXFLOAT)];
    
    CGFloat mainBGViewH = 55;
    if (messageSize.height > mainBGViewH) {
        mainBGViewH = messageSize.height;
    }
    
    [self addSubview:self.mainBGView];
    [self.mainBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80 + messageSize.width, mainBGViewH));
    }];
    
    [self.mainBGView addSubview:self.iconImgView];
    [self.iconImgView setImage:[UIImage imageNamed:@"common_error_popo_view_icon"]];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(20);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.mainBGView addSubview:self.messageLabel];
    self.messageLabel.text = message;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(messageSize.width + 20, messageSize.height));
    }];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf hiddenCommonTipPopoView];
    });
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenCommonTipPopoView)]];
}

- (UIView *)mainBGView {
    if (!_mainBGView) {
        _mainBGView = [[UIView alloc] init];
        _mainBGView.backgroundColor = [UIColor blackColor];
        _mainBGView.layer.cornerRadius = 27.5;
    }
    return _mainBGView;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
//        _iconImgView.image = [UIImage imageNamed:@"common_tip_popo_view_icon"];
    }
    return _iconImgView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:13];
    }
    return _messageLabel;
}



@end
