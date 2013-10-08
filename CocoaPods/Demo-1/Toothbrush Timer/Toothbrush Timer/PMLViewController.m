//
//  PMLViewController.m
//  Toothbrush Timer
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLViewController.h"

static NSUInteger const kEndSeconds = 120;
static NSUInteger const kIntervalSeconds = 30;

@interface PMLViewController ()

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSUInteger seconds;

@end

@implementation PMLViewController

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.progressView.progressTintColor = self.view.tintColor;
    [self.singleTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reset:animated];
}

#pragma mark - Actions

- (IBAction)tap:(UITapGestureRecognizer*)recognizer
{
    [self.timer invalidate];
    self.seconds = 0;
    [self.progressView setProgress:0.0f animated:YES];
    self.brushLabel.hidden = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (IBAction)doubleTap:(UITapGestureRecognizer*)recognizer
{
    [self reset:YES];
}

- (void)reset:(BOOL)animated
{
    [self.timer invalidate];
    self.secondsLabel.text = nil;
    self.seconds = 0;
    [self.progressView setProgress:1.0f animated:animated];
    self.progressView.thicknessRatio = 0.01f;
    self.brushLabel.hidden = NO;
}

- (void)update:(NSTimer*)aTimer
{
    self.seconds += 1;
    self.secondsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.seconds];
    [self.progressView setProgress:((CGFloat)self.seconds / (CGFloat)kEndSeconds) animated:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (self.seconds % kIntervalSeconds == 0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressView.thicknessRatio *= 2.0f;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.progressView.transform = CGAffineTransformScale(self.progressView.transform, 1.2f, 1.2f);
                                     self.secondsLabel.transform = CGAffineTransformScale(self.secondsLabel.transform, 1.2f, 1.2f);
                                 }
                                 completion:^(BOOL finished) {
                                     self.progressView.transform = CGAffineTransformIdentity;
                                     self.secondsLabel.transform = CGAffineTransformIdentity;
                                 }];
            });
        }
        if (self.seconds == kEndSeconds)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reset:YES];
            });
        }
    });
}

@end
