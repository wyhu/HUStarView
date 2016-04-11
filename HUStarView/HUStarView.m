//
//  HUStarView.m
//  HUStarView
//
//  Created by huweiya on 16/4/11.
//  Copyright © 2016年 bj_5i5j. All rights reserved.
//

#import "HUStarView.h"

#define ForegroundStarImage @"b27_icon_star_yellow"
#define BackgroundStarImage @"b27_icon_star_gray"

//#define ForegroundStarImage @"yellow"
//#define BackgroundStarImage @"dark"


typedef void(^completeBlock)(CGFloat currentScore);

@interface HUStarView()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;


@property (nonatomic,strong)completeBlock complete;

@end




@implementation HUStarView

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars stars:(CGFloat)stars
{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        
        _currentScore = stars;
        [self createStarView];
        
        self.userInteractionEnabled = NO;
        
        [self layoutSubviews];
        
    }
    return self;
    
}





#pragma mark - 代理方式
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _delegate = delegate;
        [self createStarView];
    }
    return self;
}

#pragma mark - block方式
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = 5;
        _rateStyle = WholeStar;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        _rateStyle = rateStyle;
        _isAnimation = isAnimation;
        _complete = ^(CGFloat currentScore){
            finish(currentScore);
        };
        [self createStarView];
    }
    return self;
}

#pragma mark - private Method
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    
    
    
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak HUStarView *weakSelf = self;
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
    }];
}


-(void)setCurrentScore:(CGFloat)currentScore {
    if (_currentScore == currentScore) {
        return;
    }
    if (currentScore < 0) {
        _currentScore = 0;
    } else if (currentScore > _numberOfStars) {
        _currentScore = _numberOfStars;
    } else {
        _currentScore = currentScore;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        [self.delegate starRateView:self currentScore:_currentScore];
    }
    
    if (self.complete) {
        _complete(_currentScore);
    }
    
    [self setNeedsLayout];
}

//滑动评分
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    
    
    
    CGFloat x = currentLocation.x;
    
    CGFloat y = currentLocation.y;
    
    CGFloat selfWidth = self.frame.size.width;
    
    CGFloat selfHeight = self.frame.size.width;
    
    if (x < 0) {
        x =0;
        return;
    }else if (x > selfWidth){
        x = selfWidth;
        
        return;
    }
    
    
    if (y < 0) {
        y = 0;
        
        return;
    }else if (y > selfHeight)
    {
        y = selfHeight;
        return;
    }
    
    
    
    CGFloat realStarScore = x / self.frame.size.width * self.numberOfStars;
    
    switch (_rateStyle) {
        case WholeStar:
        {
            self.currentScore = ceilf(realStarScore);
            break;
        }
        case HalfStar:
            
            if (realStarScore > self.numberOfStars - 0.5) {
                self.currentScore = self.numberOfStars;
            }else{
                self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
                
            }
            
            break;
        case IncompleteStar:
            self.currentScore = realStarScore;
            break;
        default:
            break;
    }
    
    
    
    [self layoutSubviews];
}


@end
