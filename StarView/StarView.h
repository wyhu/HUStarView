//
//  StarView.h
//  MyMovie
//
//  Created by imac on 15/8/21.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(id result);

@interface StarView : UIView

{
    UIView *_garyView;//灰色星星视图
    UIView *_yelloeView;//黄色星星视图
    
//    BOOL isChange;//是否可以平分
//    BOOL isWhole;//是否整星星
    
    
}

@property (nonatomic,retain) NSNumber *rating;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL isWhole;
- (instancetype)initWithFrame:(CGRect)frame;

@end
