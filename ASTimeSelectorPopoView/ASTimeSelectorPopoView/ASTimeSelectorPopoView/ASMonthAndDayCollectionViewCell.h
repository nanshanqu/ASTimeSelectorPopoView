//
//  ASMonthAndDayCollectionViewCell.h
//  ASLive
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASMonthAndDayCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ASTimeModel * timeModel;

/**
 视图的缓存池标示
 */
+ (NSString *)cellIdentifier;

/**
 获取视图对象
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
