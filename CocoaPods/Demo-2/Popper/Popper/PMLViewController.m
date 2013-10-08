//
//  PMLViewController.m
//  Popper
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import "PMLViewController.h"
#import "PMLPopper.h"
@interface PMLViewController ()

@property(nonatomic,strong) PMLPopper *popper;

@end

@implementation PMLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.popper = [[PMLPopper alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap:(id)sender {
    [self.popper pop];
}

@end
