//
//  FirstViewController.m
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 3/1/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import "FirstViewController.h"
#import "Home.h"
@interface FirstViewController ()
//@property (strong,nonatomic) Home *HomeObj;
@end

@implementation FirstViewController
//@synthesize HomeObj=_HomeObj;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.HomeObj FillRandomMines:40];
        UIView *tapView = self.view;
    UITapGestureRecognizer *tapDoubleGR = [[UITapGestureRecognizer alloc]
                                           initWithTarget:tapView action:@selector(tapDoubleHandler:)];
    tapDoubleGR.numberOfTapsRequired = 2;         // set appropriate GR attributes
    [tapView addGestureRecognizer:tapDoubleGR];   // add GR to view
    
    UITapGestureRecognizer *tapSingleGR = [[UITapGestureRecognizer alloc]
                                           initWithTarget:tapView action:@selector(tapSingleHandler:)];
    tapSingleGR.numberOfTapsRequired = 1;         // set appropriate GR attributes
    [tapSingleGR requireGestureRecognizerToFail: tapDoubleGR];  // prevent single tap recognition on double-tap
    [tapView addGestureRecognizer:tapSingleGR];   // add GR to view
    //[tapSingleGR release];
}


- (IBAction) showActionSheet:(UIButton *)sender
{
    UIActionSheet *myAS = [[UIActionSheet alloc]
                           initWithTitle:@"Game Over"
                           delegate:self
                           cancelButtonTitle:@"Cancel"       // nil to suppress this button
                           destructiveButtonTitle:@"Destroy" // nil to suppress this button
                           otherButtonTitles:@"Start New Game",@"Kick Dog",nil];
    
    [myAS showInView:self.view];
}


@end