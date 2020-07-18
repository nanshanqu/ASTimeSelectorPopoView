//
//  ASMonthAndDayCollectionViewCell.m
//  ASLive
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 Andy. All rights reserved.
//

#import "ASMonthAndDayCollectionViewCell.h"
#import <Masonry.h>

@interface ASMonthAndDayCollectionViewCell ()

/// 月日
@property (nonatomic, strong) UILabel * monthAndDayLabel;

/// 星期
@property (nonatomic, strong) UILabel * weekdayLabel;

@end

@implementation ASMonthAndDayCollectionViewCell

/**
 视图的缓存池标示
 */
+ (NSString *)cellIdentifier {
    
    static NSString *cellIdentifier = @"ASMonthAndDayCollectionViewCell";
    return cellIdentifier;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.monthAndDayLabel];
    [self.monthAndDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(22);
    }];
    
    [self.contentView addSubview:self.weekdayLabel];
    [self.weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.monthAndDayLabel.mas_bottom);
    }];
}

/**
 获取视图对象
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    
    ASMonthAndDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ASMonthAndDayCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    if (!cell) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"ASMonthAndDayCollectionViewCell" owner:nil options:nil].firstObject;
        cell = [[ASMonthAndDayCollectionViewCell alloc] initWithFrame:CGRectZero];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTimeModel:(ASTimeModel *)timeModel {
    
    _timeModel = timeModel;
    
    self.monthAndDayLabel.text = timeModel.monthAndDay;
    self.weekdayLabel.text = timeModel.weekday;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    if (selected) {
        
        self.monthAndDayLabel.textColor = [UIColor blueColor];
        self.weekdayLabel.textColor = [UIColor blueColor];
    } else {
        
        self.monthAndDayLabel.textColor = [UIColor blackColor];
        self.weekdayLabel.textColor = [UIColor blackColor];
    }
}

- (UILabel *)monthAndDayLabel {
    if (!_monthAndDayLabel) {
        _monthAndDayLabel = [[UILabel alloc] init];
        _monthAndDayLabel.font = [UIFont systemFontOfSize:15];
        _monthAndDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthAndDayLabel;
}

- (UILabel *)weekdayLabel {
    if (!_weekdayLabel) {
        _weekdayLabel = [[UILabel alloc] init];
        _weekdayLabel.font = [UIFont systemFontOfSize:15];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weekdayLabel;
}



@end
