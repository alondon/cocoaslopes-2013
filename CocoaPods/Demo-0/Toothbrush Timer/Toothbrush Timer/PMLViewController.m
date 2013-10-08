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
    // TODO: setup start UI
    self.secondsLabel.text = nil;
}

#pragma mark - Actions

- (IBAction)tap:(UITapGestureRecognizer*)recognizer
{
    self.seconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(NSTimer*)aTimer
{
    self.seconds += 1;
    self.secondsLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.seconds];
    if (self.seconds % kIntervalSeconds == 0)
    {
        // TODO: flash UI & play audio.
    }
    if (self.seconds == kEndSeconds)
    {
        [self.timer invalidate];
        self.timer = nil;

        // TODO: reset to start UI
        self.secondsLabel.text = nil;
    }
}

@end
