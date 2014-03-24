//
//  Home.h
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 2/8/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIView
- (IBAction)NewGame:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *MineLabel;


@property (nonatomic, assign) CGFloat dw, dh;  // width and height of cell
@property (nonatomic, assign) CGFloat x, y;    // touch point coordinates
@property (nonatomic, assign) int row, col;    // selected cell in cell grid
@property (nonatomic, assign) BOOL inMotion;   // YES iff in process of dragging
@property (nonatomic, strong) NSString *s;     // item to drag around grid

@property (strong, nonatomic) IBOutlet UILabel *Best_Time;
@property (strong, nonatomic) IBOutlet UILabel *Time;
@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic, assign) int no_of_Rows, no_of_Columns;

-(void) FillRandomMines:(int) mines;


@property (nonatomic, assign) int mineCount;
@end
