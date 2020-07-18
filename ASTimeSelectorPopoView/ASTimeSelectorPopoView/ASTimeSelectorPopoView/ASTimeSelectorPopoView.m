//
//  ASTimeSelectorPopoView.m
//  ASTimeSelectorPopoView
//
//  Created by Mac on 2020/6/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ASTimeSelectorPopoView.h"
#import <Masonry.h>
#import "ASMonthAndDayCollectionViewCell.h"
#import "ASTimeModel.h"
#import "ASCommonTipPopoView.h"


#define KShowYearsCount 100

@interface ASTimeSelectorPopoView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * monthAndDayCollectionView;

@property (nonatomic, strong) UIView * mainBGView;
@property (nonatomic, strong) UIButton * closeButton;
@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UIView * courseBGView;
@property (nonatomic, strong) UIImageView * iconImgView;
@property (nonatomic, strong) UILabel * corseTimeLabel;

@property (nonatomic, strong) UIView * topBGView;

@property (nonatomic, strong) UIView * bottomBGView;

@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) NSString * monthDayString;
@property (nonatomic, strong) NSString * timeString;


/// 星期数组
@property (nonatomic, strong) NSArray *weekArray;
/// 时间数组
@property (nonatomic, strong) NSArray *timeArray;
/// 年份数组
@property (nonatomic, strong) NSArray *yearArray;
/// 月份数组
@property (nonatomic, strong) NSArray *monthArray;

/// 用于存放月份和日的数组
@property (nonatomic, strong) NSMutableArray * monthAndDayArray;


/// 小时
@property (nonatomic, assign) NSInteger hour;
/// 分钟
@property (nonatomic, assign) NSInteger minute;
/// 年
@property (nonatomic, assign) NSInteger year;
/// 月
@property (nonatomic, assign) NSInteger month;
/// 日
@property (nonatomic, assign) NSInteger day;

/// 当前年份
@property (nonatomic, assign) NSInteger currentYear;
/// 当前月份
@property (nonatomic, assign) NSInteger currentMonth;
/// 当前日期
@property (nonatomic, assign) NSInteger currentDay;
/// 当前小时
@property (nonatomic, assign) NSInteger currentHour;
/// 当前分钟
@property (nonatomic, assign) NSInteger currentMinute;

@property (nonatomic, copy) void (^selectedTimeOperation)(NSString *selectedTime) ;


@end

static ASTimeSelectorPopoView *_timeSelectorPopoViewManager = nil;

@implementation ASTimeSelectorPopoView

- (instancetype)showTimeSelectorPopoView {
    
    if (self == [super init]) {
        
        // 获取当前时间
        [self getCurrentDate];
        
        [self setupUI];
    }
    return self;
}

+ (instancetype)showTimeSelectorPopoViewWithSelectedTimeOperation:(void(^)(NSString *selectedTime))selectedTimeOperation {
    
    if (_timeSelectorPopoViewManager == nil) {
        
        _timeSelectorPopoViewManager = [[self alloc] showTimeSelectorPopoView];
        _timeSelectorPopoViewManager.frame = [UIScreen mainScreen].bounds;
        _timeSelectorPopoViewManager.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _timeSelectorPopoViewManager.selectedTimeOperation = selectedTimeOperation;
        
        UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
        [mainWindow addSubview:_timeSelectorPopoViewManager];
    }
    return _timeSelectorPopoViewManager;
}

/// 获取当前时间
- (void)getCurrentDate {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    self.year = [components year];
    self.month = [components month];
    self.day = [components day];
    self.hour = [components hour];
    self.minute = [components minute];
    
    self.currentYear = self.year;
    self.currentMonth = self.month;
    self.currentDay = self.day;
    self.currentHour = self.hour;
    self.currentMinute = self.minute;
    
    self.monthDayString = [NSString stringWithFormat:@"%ld月%ld日", self.currentMonth, self.currentDay];
//    self.timeString = [NSString stringWithFormat:@""]
}

- (void)setupUI {
    
    [self addSubview:self.mainBGView];
    [self.mainBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(600, 595));
    }];
    
    [self.mainBGView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self.mainBGView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.mainBGView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainBGView);
        make.top.mas_equalTo(self.mainBGView).offset(60);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    CGFloat viewMargin = 40;
    
    [self.mainBGView addSubview:self.courseBGView];
    [self.courseBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(viewMargin);
        make.right.mas_equalTo(self.mainBGView).offset(-viewMargin);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    [self.courseBGView addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.courseBGView).offset(8);
        make.centerY.mas_equalTo(self.courseBGView);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    [self.courseBGView addSubview:self.corseTimeLabel];
    [self.corseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.courseBGView);
        make.right.mas_equalTo(self.courseBGView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    [self.mainBGView addSubview:self.topBGView];
    [self.topBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(viewMargin);
        make.top.mas_equalTo(self.corseTimeLabel.mas_bottom).offset(15);
        make.right.mas_equalTo(self.mainBGView).offset(-viewMargin);
        make.height.mas_equalTo(80);
    }];
    
    [self.topBGView addSubview:self.monthAndDayCollectionView];
    [self.monthAndDayCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.topBGView);
    }];
    
    [self.mainBGView addSubview:self.bottomBGView];
    [self.bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(viewMargin);
        make.right.mas_equalTo(self.mainBGView).offset(-viewMargin);
        make.top.mas_equalTo(self.topBGView.mas_bottom);
        make.bottom.mas_equalTo(self.mainBGView);
    }];
    
    CGFloat btnW = 84;
    CGFloat btnH = 30;
    NSInteger col = 4;
    CGFloat marginW = 50;
    CGFloat marginH = 10;
    
    for (NSInteger i = 0; i < self.timeArray.count; i++) {
        
        CGFloat btnX = i % col * (btnW + marginW);
        CGFloat btnY = i / col * (btnH + marginH);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i + 100;
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        NSString *hour = [self.timeArray[i] componentsSeparatedByString:@":"].firstObject;
        NSString *minute = [self.timeArray[i] componentsSeparatedByString:@":"].lastObject;
        if ((self.hour > [hour integerValue]) || (self.hour == [hour integerValue] && self.minute >= [minute integerValue])) {
            
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        } else {
            
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (((self.day > self.currentDay) && (self.month == self.currentMonth)) || (self.month > self.currentMonth)) {
            
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [btn setTitle:self.timeArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selecedCurrentBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bottomBGView addSubview:btn];
    }
    
    [self.mainBGView addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomBGView);
        make.bottom.mas_equalTo(self.bottomBGView).offset(-viewMargin);
        make.size.mas_equalTo(CGSizeMake(230, 60));
    }];
    
}

#pragma mark- function

- (void)selecedCurrentBtn:(UIButton *)sender {
    
    [self refreshTimeButton];
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        sender.backgroundColor = [UIColor blueColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    
    NSString *timeString = self.timeArray[sender.tag - 100];
    self.timeString = timeString;
    
    NSLog(@"timeString:%@", timeString);
}

/// 更新时间按钮的状态
- (void)refreshTimeButton {
    
    for (NSInteger i = 0; i < self.timeArray.count; i++) {
        UIButton *btn = [self.bottomBGView viewWithTag:i + 100];
        btn.selected = NO;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSString *hour = [self.timeArray[i] componentsSeparatedByString:@":"].firstObject;
        NSString *minute = [self.timeArray[i] componentsSeparatedByString:@":"].lastObject;
        if ((self.hour > [hour integerValue]) || (self.hour == [hour integerValue] && self.minute >= [minute integerValue])) {
            
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        } else {
            
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (((self.day > self.currentDay) && (self.month == self.currentMonth)) || (self.month > self.currentMonth)) {
            
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

+ (void)hiddenTimeSelectorPopoView {
    
    [_timeSelectorPopoViewManager removeFromSuperview];
    _timeSelectorPopoViewManager = nil;
}

- (void)hiddenTimeSelectorPopoView {
    
    [_timeSelectorPopoViewManager removeFromSuperview];
    _timeSelectorPopoViewManager = nil;
}

- (void)closeButtonAction {
    
    [self hiddenTimeSelectorPopoView];
}

- (void)sureButtonAction {
    
    if (!self.timeString.length) {
        
        [ASCommonTipPopoView showCommonTipPopoViewWithTipMessage:@"请选择上课时间！"];
        return;
    }
    
    NSString *selectedTime = [NSString stringWithFormat:@"%@ %@", self.monthDayString, self.timeString];
    if (self.selectedTimeOperation) {
        self.selectedTimeOperation(selectedTime);
    }
    
    [self hiddenTimeSelectorPopoView];
}

#pragma mark-  将当前时间（NSDate）转化成年月日

/// 将当前时间（NSDate）转化成年月日
- (NSString *)getCurrentDateStringWithFormatter:(NSString *)formatter withCurrentDate:(NSDate *)currentDate {
    
    // 实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        // 设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // @"yyyy/MM/dd"
        [dateFormatter setDateFormat:formatter];
        
        // 设置时区
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [dateFormatter setTimeZone:timeZone];
        
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    return currentDateString;
}

#pragma mark- lazzying

- (UIView *)mainBGView {
    if (!_mainBGView) {
        _mainBGView = [[UIView alloc] init];
        _mainBGView.backgroundColor = [UIColor whiteColor];
        _mainBGView.layer.cornerRadius = 35;
    }
    return _mainBGView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"live_room_popoview_close_img"] forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 22;
        _closeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _closeButton.layer.borderWidth = 2;
        [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:24];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"选择上课时间";
    }
    return _titleLabel;
}

- (UIView *)courseBGView {
    if (!_courseBGView) {
        _courseBGView = [[UIView alloc] init];
        _courseBGView.backgroundColor = [UIColor magentaColor];
        _courseBGView.layer.cornerRadius = 15;
        _courseBGView.clipsToBounds = YES;
    }
    return _courseBGView;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.image = [UIImage imageNamed:@"common_tip_popo_view_icon"];
    }
    return _iconImgView;
}

- (UILabel *)corseTimeLabel {
    if (!_corseTimeLabel) {
        _corseTimeLabel = [[UILabel alloc] init];
        _corseTimeLabel.text = @"一节课时长25分钟";
        _corseTimeLabel.font = [UIFont systemFontOfSize:14];
        _corseTimeLabel.textColor = [UIColor whiteColor];
    }
    return _corseTimeLabel;
}

- (UIView *)topBGView {
    if (!_topBGView) {
        _topBGView = [[UIView alloc] init];
    }
    return _topBGView;
}

- (UIView *)bottomBGView {
    if (!_bottomBGView) {
        _bottomBGView = [[UIView alloc] init];
    }
    return _bottomBGView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.backgroundColor = [UIColor yellowColor];
        _sureButton.layer.cornerRadius = 30;
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (NSArray *)timeArray {
    if (!_timeArray) {
        _timeArray = @[@"09:00", @"09:30", @"10:00", @"10:30", @"11:00", @"11:30", @"12:00", @"12:30", @"13:00", @"13:30", @"14:00", @"14:30", @"15:00", @"15:30", @"16:00", @"16:30", @"17:00", @"17:30", @"18:00", @"18:30", @"19:00", @"19:30", @"20:00", @"20:30", @"21:00"];
    }
    return _timeArray;
}

- (NSArray *)weekArray {
    if (!_weekArray) {
        _weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    }
    return _weekArray;
}

- (NSArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [[NSArray alloc] init];
        NSInteger firstYear = self.year - KShowYearsCount / 2;
        NSMutableArray *yearArray = [NSMutableArray array];
        for (int i = 0; i < KShowYearsCount; i++) {
            [yearArray addObject:[NSString stringWithFormat:@"%ld", firstYear + i]];
        }
        _yearArray = yearArray;
    }
    return _yearArray;
}

- (NSArray *)monthArray {
    if (!_monthArray) {
        _monthArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    }
    return _monthArray;
}

/// 用于存放月份和日的数组
- (NSMutableArray *)monthAndDayArray {
    if (!_monthAndDayArray) {
        _monthAndDayArray = [[NSMutableArray alloc] init];
        
        NSTimeInterval oneDay = 24 * 60 * 60;  // 一天一共有多少秒
        NSInteger showDays = 4;    // 需要显示的总天数
        
        // 1.获取当前日期
        NSDate *currentDate = [NSDate date];
        
        for (NSInteger i = 0; i < showDays; i++) {
            
            NSDate *appointDate = [currentDate initWithTimeIntervalSinceNow: oneDay * i];
            
            NSString *currentDate = [self getCurrentDateStringWithFormatter:@"yyyy-MM-dd" withCurrentDate:appointDate];
            
            NSInteger year = [[currentDate substringToIndex:4] integerValue];
            NSInteger month = [[currentDate substringWithRange:NSMakeRange(5, 2)] integerValue];
            NSInteger day = [[currentDate substringFromIndex:8] integerValue];
            
            NSString *mandd = [NSString stringWithFormat:@"%ld月%ld日", (long)month, (long)day];
            
            ASTimeModel *timeModel = [[ASTimeModel alloc] init];
            timeModel.monthAndDay = mandd;
            timeModel.year = year;
            timeModel.month = month;
            timeModel.day = day;
            timeModel.yearMonthDay = [NSString stringWithFormat:@"%ld年%@", (long)year, mandd];
            
            if (i == 0) {
                timeModel.weekday = @"今天";
            }
            
            // 添加最终处理好的数据，将他们作为模型封装到数组中
            [_monthAndDayArray addObject:timeModel];
            
        }
        
    }
    return _monthAndDayArray;
}

- (UICollectionView *)monthAndDayCollectionView {
    if (!_monthAndDayCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 20;
        _monthAndDayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _monthAndDayCollectionView.delegate = self;
        _monthAndDayCollectionView.dataSource = self;
        _monthAndDayCollectionView.bounces = YES;
        _monthAndDayCollectionView.showsVerticalScrollIndicator = NO;
        _monthAndDayCollectionView.showsHorizontalScrollIndicator = NO;
        _monthAndDayCollectionView.userInteractionEnabled = YES;
        _monthAndDayCollectionView.backgroundColor = [UIColor clearColor];
        
        // 默认选中第一个元素
        [_monthAndDayCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];

        
        [_monthAndDayCollectionView registerClass:[ASMonthAndDayCollectionViewCell class] forCellWithReuseIdentifier:[ASMonthAndDayCollectionViewCell cellIdentifier]];
//        [_monthAndDayCollectionView registerNib:[UINib nibWithNibName:[ASMonthAndDayCollectionViewCell cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[ASMonthAndDayCollectionViewCell cellIdentifier]];
    }
    return _monthAndDayCollectionView;
}

#pragma mark- UIColloctionViewDelegate

// 返回每组当中所有的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.monthAndDayArray.count;
}

// 返回每个元素所使用的UICollectionViewCell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ASMonthAndDayCollectionViewCell *cell = [ASMonthAndDayCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    ASTimeModel *timeModel = self.monthAndDayArray[indexPath.row];
    
    cell.timeModel = timeModel;
    
    
    return cell;
}

// 修改每一个item的宽度和高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(110, 54);
}

// 返回每一组元素跟屏幕4个边界的距离(上，左，下，右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    //创建一个UIEdgeInsets的结构体
    return UIEdgeInsetsMake(10, -5, 10, 10);
    
}

// 选中某一个item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ASMonthAndDayCollectionViewCell *cell = [ASMonthAndDayCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    [cell setSelected:YES];
    
    ASTimeModel *timeModel = self.monthAndDayArray[indexPath.row];
    
    self.monthDayString = timeModel.monthAndDay;
    
    NSInteger month = [[timeModel.monthAndDay componentsSeparatedByString:@"月"].firstObject integerValue];
    NSString *dayString = [timeModel.monthAndDay componentsSeparatedByString:@"月"].lastObject;
    NSInteger day = [[dayString componentsSeparatedByString:@"日"].firstObject integerValue];
    
    self.month = month;
    self.day = day;
    
    [self refreshTimeButton];
    
    NSLog(@"month = %ld, day = %ld", month, day);
    NSLog(@"currentMonth = %ld, currentDay = %ld", self.currentMonth, self.currentDay);
    
//    cell.timeModel = timeModel;
    NSLog(@"第%ld组第%ld个",indexPath.section,indexPath.item);
    NSLog(@"timeModel.monthAndDay:%@", timeModel.monthAndDay);
    
}


@end
