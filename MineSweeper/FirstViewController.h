//
//  FirstViewController.h
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 3/1/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) UIColor * color;
- (IBAction)showActionSheet:(UIButton *)sender;

@end
