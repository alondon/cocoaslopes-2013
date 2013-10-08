//
//  PMLViewController.h
//  Toothbrush Timer
//
//  Created by Aaron London on 10/1/13.
//  Copyright (c) 2013 postmechanical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMLViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;

- (IBAction)tap:(UITapGestureRecognizer*)recognizer;

@end
