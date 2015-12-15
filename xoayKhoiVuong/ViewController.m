//
//  ViewController.m
//  xoayKhoiVuong
//
//  Created by student on 15/12/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic, strong) AVAudioPlayer *backgroundMusic;
@end

@implementation ViewController
{
    int index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self drawSquares];
    index = 5;
    
   // [self performSelector:@selector() withObject:nil afterDelay:1];
    [self rotateAllSquares];
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(rotateAllSquares)
                                   userInfo:nil
                                    repeats:YES];
    
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"Faded" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.backgroundMusic.numberOfLoops = -1; //infinite
    
    [self.backgroundMusic play];
    self.backgroundMusic.currentTime = 0;
}

- (void)drawSquares{
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat margin = 20;
    CGFloat recWidth = mainViewSize.width - margin * 2.0;
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    CGPoint center = CGPointMake(mainViewSize.width * 0.5,
                                 (mainViewSize.height + statusNavigationBarHeight) * 0.5);
    for (int i = 0; i < 20; i++) {
        UIView* square;
        if (i % 2 == 0) {
            square = [self drawSquareby:recWidth and:false and:center];
        } else  {
            square = [self drawSquareby:recWidth and:true and:center];
        }
        [self.view addSubview:square];
        
        recWidth = recWidth * 0.707;
    }
}

- (UIView*)drawSquareby: (CGFloat)width
                     and: (BOOL) rotate
                     and: (CGPoint) center{
    UIView* square= [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    square.center = center;
    square.backgroundColor = rotate ? [UIColor whiteColor] : [UIColor darkGrayColor];
    square.transform = rotate ? CGAffineTransformMakeRotation(M_PI_4) : CGAffineTransformIdentity;
    return square;
    

}
- (void)rotateAllSquares{
    if (index == 1) {
        index = 5;
    }
    index--;
    [UIView animateWithDuration:4.0
                     animations:^{
                         for (int i=0; i<self.view.subviews.count; i++) {
                             if (i%2 == 0) {
                                 ((UIView*)self.view.subviews[i]).transform= CGAffineTransformMakeRotation(M_PI/index);
                             }else{
                                 ((UIView*)self.view.subviews[i]).transform= CGAffineTransformIdentity;
                             }
                         }
    }
                     completion:NULL];

    }
@end
