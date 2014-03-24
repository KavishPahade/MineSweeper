//
//  SecondViewController.m
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 3/1/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize RowLabel=_RowLabel;
@synthesize ColumnLabel=_ColumnLabel;
@synthesize RowIncrement=_RowIncrement;
@synthesize ColumnIncrement=_ColumnIncrement;
@synthesize ColorView=_ColorView;
@synthesize RedSlider,BlueSlider,GreenSlider;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _RowIncrement.minimumValue = 5;
    _RowIncrement.maximumValue = 16;
    _RowIncrement.stepValue = 1;
    _RowIncrement.wraps = YES;
    _RowIncrement.autorepeat = YES;
    _RowIncrement.continuous = YES;
    _RowLabel.text = [NSString stringWithFormat:@"%.d", (int) _RowIncrement.value];
    
    _ColumnIncrement.minimumValue = 5;
    _ColumnIncrement.maximumValue = 16;
    _ColumnIncrement.stepValue = 1;
    _ColumnIncrement.wraps = YES;
    _ColumnIncrement.autorepeat = YES;
    _ColumnIncrement.continuous = YES;
    _ColumnLabel.text = [NSString stringWithFormat:@"%.d", (int) _ColumnIncrement.value];
    
    RedSlider.minimumValue=0;RedSlider.maximumValue=255;
    GreenSlider.minimumValue=0;GreenSlider.maximumValue=255;
    BlueSlider.minimumValue=0;BlueSlider.maximumValue=255;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RowAction:(UIStepper *)sender {
    
    
    NSUInteger value = sender.value;
    _RowLabel.text = [NSString stringWithFormat:@"%02d", value];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"%02d", value]
                forKey:@"No_of_Rows"];
     [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)ColumnAction:(UIStepper *)sender {
    NSUInteger value = sender.value;
    _ColumnLabel.text = [NSString stringWithFormat:@"%02d", value];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"%02d", value]
                forKey:@"No_of_Columns"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (IBAction)ChangeColor:(UISlider *)sender
{
    UIColor * color = [UIColor colorWithRed:RedSlider.value/255 green:GreenSlider.value/255 blue:BlueSlider.value/255 alpha:1];
    _ColorView.backgroundColor=color;
    //UIColor *color = value;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    [defaults setValue:colorAsString
                forKey:@"BackGroundColour"];
     [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
