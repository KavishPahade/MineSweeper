//
//  SecondViewController.h
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 3/1/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *RowLabel;
@property (strong, nonatomic) IBOutlet UILabel *ColumnLabel;
- (IBAction)RowAction:(UIStepper *)sender;
- (IBAction)ColumnAction:(UIStepper *)sender;

@property (strong, nonatomic) IBOutlet UIStepper *ColumnIncrement;
@property (strong, nonatomic) IBOutlet UIStepper *RowIncrement;

@property (strong, nonatomic) IBOutlet UISlider *RedSlider;

@property (strong, nonatomic) IBOutlet UISlider *GreenSlider;
@property (strong, nonatomic) IBOutlet UISlider *BlueSlider;

@property (strong, nonatomic) IBOutlet UIView *ColorView;
- (IBAction)ChangeColor:(UISlider *)sender;

@end
