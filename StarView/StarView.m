//
//  StarView.m
//  MyMovie
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"
#import "Single.h"
#define starWidth 17.5
#define starHeight 17.0


@implementation StarView
{
    Single *rating1;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //...
        [self _initStarView];
    }
    return self;
}


- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self _initStarView];
}


#pragma mark  _initStarView
- (void)_initStarView{
    rating1 = [Single useSingle];
    
    //构建两层视图
    _garyView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, starWidth*5, starHeight)];
    _yelloeView=[[UIView alloc] initWithFrame:_garyView.frame];
    
    _garyView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray"]];
    _yelloeView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]];
    
    
    //对视图进行缩放操作
    _garyView.transform=CGAffineTransformMakeScale(self.width/_garyView.width, self.height/starHeight);
    
    _yelloeView.transform=_garyView.transform;
    
    //设置坐标点
    _garyView.origin=CGPointZero;
    _yelloeView.origin=CGPointZero;
    
    //将两个视图添加到主视图上
    [self addSubview:_garyView];
    [self addSubview:_yelloeView];
    
    
    //为其添加手势
    _yelloeView.userInteractionEnabled=NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_garyView addGestureRecognizer:tap];
    
    
}
//复写set方法
- (void)setRating:(NSNumber *)rating{
    if (_rating!=rating) {
        _rating=rating;
        [self setNeedsLayout];
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat rating=[_rating floatValue];
    _yelloeView.width=(rating / 10) * _garyView.width;

}
#pragma mark  tapClick:

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    
    if (_isChange) {
        //可以评分
        CGFloat newRaing=[tap locationInView:self].x / _garyView.width;
        
        _yelloeView.width=0;
        
        if (_isWhole) {
            //只允许整个星星
            if (newRaing >=0 && newRaing <= 0.2) {
                newRaing = 0.2;
            }else if (newRaing >0.2 && newRaing <= 0.4){
                newRaing = 0.4;
            }else if (newRaing >0.4 && newRaing <= 0.6){
                newRaing = 0.6;
            }else if (newRaing >0.6 && newRaing <= 0.8){
                newRaing = 0.8;
            }else if (newRaing >0.8 && newRaing <= 1.0){
                newRaing = 1.0;
            }

        }

        NSNumber *rating=[NSNumber numberWithFloat:newRaing * 10];
//        _rating = rating;
        self.rating = rating;
        rating1.num = rating;
        NSLog(@"%@",self.rating);
    }
    
    
    
    
    
    
    }





@end
