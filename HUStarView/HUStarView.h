//
//  HUStarView.h
//  HUStarView
//
//  Created by huweiya on 16/4/11.
//  Copyright © 2016年 bj_5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HUStarView;

typedef void(^finishBlock)(CGFloat currentScore);


/**
 *  枚举值
 */
typedef NS_ENUM(NSInteger, RateStyle) {
    /**
     * 整星
     */
    WholeStar = 0,
    /**
     *  半星
     */
    HalfStar = 1,
    /**
     *  任何分数
     */
    IncompleteStar = 2
};

@protocol XHStarRateViewDelegate <NSObject>


/**
 * 代理回调
 *
 *  @param starRateView tag
 *  @param currentScore 分数
 */
-(void)starRateView:(HUStarView *)starRateView currentScore:(CGFloat)currentScore;

@end


@interface HUStarView : UIView


@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0



/**
 *  是否动画显示，默认NO
 */
@property (nonatomic,assign)BOOL isAnimation;

/**
 *      //评分样式    默认是WholeStar
 */
@property (nonatomic,assign)RateStyle rateStyle;

@property (nonatomic, weak) id<XHStarRateViewDelegate>delegate;


//代理方法
-(instancetype)initWithFrame:(CGRect)frame;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;




//block方法创建
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;


-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;


/**
 *  构造展示星星 不能评价 只能看
 *
 *  @param frame         frame
 *  @param numberOfStars 星星个数
 *  @param stars         评分
 *
 *  @return id
 */
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars stars:(CGFloat)stars;









@end
