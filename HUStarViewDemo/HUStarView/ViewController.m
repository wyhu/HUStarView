//
//  ViewController.m
//  HUStarView
//
//  Created by huweiya on 16/4/11.
//  Copyright © 2016年 bj_5i5j. All rights reserved.
//

#import "ViewController.h"
#import "HUStarView.h"

@interface ViewController ()<XHStarRateViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUStarView *starRateView = [[HUStarView alloc] initWithFrame:CGRectMake(20, 60, 200, 30)];
    starRateView.isAnimation = YES;
    starRateView.rateStyle = IncompleteStar;
    starRateView.tag = 1;
    starRateView.delegate = self;
    
    [self.view addSubview:starRateView];
    
    HUStarView *starRateView2 = [[HUStarView alloc] initWithFrame:CGRectMake(20, 100, 300, 30) numberOfStars:10 rateStyle:HalfStar isAnination:YES delegate:self];
    starRateView2.tag = 2;
    [self.view addSubview:starRateView2];
    
    
    
    HUStarView *starRateView3 = [[HUStarView alloc] initWithFrame:CGRectMake(20, 140, 200, 30) finish:^(CGFloat currentScore) {
        NSLog(@"3----  %f",currentScore);
    }];
    
    
    [self.view addSubview:starRateView3];
    
    
    
    
    HUStarView *starRateView4 = [[HUStarView alloc] initWithFrame:CGRectMake(20, 180, 200, 30) numberOfStars:5 rateStyle:HalfStar isAnination:YES finish:^(CGFloat currentScore) {
        NSLog(@"4----  %f",currentScore);
    }];
    [self.view addSubview:starRateView4];
    
    
    
    HUStarView *he = [[HUStarView alloc] initWithFrame:CGRectMake(20, 300, 400, 60) numberOfStars:5 stars:3.6];
    
    [self.view addSubview:he];
    
    
    
}

-(void)starRateView:(HUStarView *)starRateView currentScore:(CGFloat)currentScore{
    NSLog(@"%ld----代理  %f",starRateView.tag,currentScore);
}
@end
