//
//  Home.m
//  MineSweeper
//
//  Created by Kavish Vinod Pahade on 2/8/14.
//  Copyright (c) 2014 Kavish Vinod Pahade. All rights reserved.
//

#import "Home.h"

@implementation Home
int MinePositions[16][16];
BOOL DoubleClickFlag=false;
BOOL SingleClickFlag=false;
bool isStart=true;
bool GAMEFINISHSED=false;
@synthesize dw, dh, row, col, x, y, inMotion, s,mineCount;
@synthesize timer;
int timercount;
@synthesize Time=_Time;
@synthesize Best_Time=_Best_Time;
@synthesize no_of_Rows, no_of_Columns;
@synthesize MineLabel=_MineLabel;
bool highScoreAcheived=false;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) FillRandomMines:(int)mines
{
    
    int randx, randy;
    for(int i=0;i<no_of_Columns ;i++)
    {
        
        for(int j=0;j<no_of_Rows;j++)
        {
            MinePositions[i][j]=0;  //Initialising the array with zero
        }
    }
    for(int i=0;i<mines;i++)  //Initialising the array with -1 randomly to indicate mines
    {
        do {
            randx = arc4random()%no_of_Columns;
            randy = arc4random()%no_of_Rows;
        } while (MinePositions[randx][randy]==-1);
        MinePositions[randx][randy]=-1;
    }
}


-(void) DisplayMines      //Displaying all the mines when the user hits a mine
{
    for(int i=0;i<no_of_Columns;i++)
    {
        for (int j=0;j<no_of_Rows;j++)
        {
            
            if ( MinePositions[i][j]==-1 || MinePositions[i][j]==-4 )
            {
                CGRect imageRect = CGRectMake(i*dw, (j+3)*dh, dw, dh);
                UIImage *img;
                img = [UIImage imageNamed:@"icon"];
                [img drawInRect:imageRect];
                [[UIColor blackColor] set];
                UIRectFrame(imageRect);
            }
        }
    }
    
}
-(void) DisplayFlag //Helper function to display flag images
{
    for(int i=0;i<no_of_Columns;i++)
    {
        for (int j=0;j<no_of_Rows;j++)
        {
            
            if ( MinePositions[i][j]==-3 || MinePositions[i][j]==-4)
            {
                CGRect imageRect = CGRectMake(i*dw, (j+3)*dh, dw-.5, dh-.5);
                UIImage *img;
                img = [UIImage imageNamed:@"flag"];
                [img drawInRect:imageRect];
                [[UIColor blackColor] set];
                UIRectFrame(imageRect);
            }
        }
    }
    
}
-(void) DisplayOpenedValues //Helper function to display opened values
{
    for(int i=0;i<no_of_Columns;i++)
    {
        for (int j=0;j<no_of_Rows;j++)
        {
            CGRect imageRect = CGRectMake(i*dw, (j+3)*dh, dw-.5, dh-.5);

            if(MinePositions[i][j]!=-1 && MinePositions[i][j]!=0 && MinePositions[i][j]!=-2 && MinePositions[i][j]!=-3 && MinePositions[i][j]!=-4)
            {
                UIFont *font = [UIFont systemFontOfSize: .75*self.dh];
                NSString* myNewString = [NSString stringWithFormat:@"%i", MinePositions[i][j]];
                CGPoint xy = { (i+0.1)*self.dw, (j+3)*self.dh };
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *ClosedCellsColor =[defaults valueForKey:@"BackGroundColour"];
                NSArray *components = [ClosedCellsColor componentsSeparatedByString:@","];
                CGFloat r = [[components objectAtIndex:0] floatValue];
                CGFloat g = [[components objectAtIndex:1] floatValue];
                CGFloat b = [[components objectAtIndex:2] floatValue];
                CGFloat a = [[components objectAtIndex:3] floatValue];
                UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGContextSetFillColorWithColor(ctx, color.CGColor); // setting the background colour selected from settings view
                //[[UIColor cyanColor] setFill];
                UIRectFill(imageRect);
               
                [[UIColor yellowColor] setFill];
                [myNewString drawAtPoint: xy withFont: font];
                
            }
            [[UIColor blackColor] set];
            UIRectFrame(imageRect);
            
        }
    }
    
}
-(void) GameOver  //Generating an alert to indicate that game is over
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Game-Over"
                          message: @"Start a new Game!"
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    
     GAMEFINISHSED=TRUE;
    [self setNeedsDisplay];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // the user clicked OK
    if (buttonIndex == 0)
    {
        [self FillRandomMines:mineCount];
        [timer invalidate];
        isStart=true;
        [self setNeedsDisplay];
    }
}
-(void) GameWon  //checking if the game has been won and displaying an alert
{
    int OpenedCount=0;
    int flaggedMines=0;
    for(int i=0;i<no_of_Columns ;i++)
    {
        
        for(int j=0;j<no_of_Rows;j++)
        {
                if(MinePositions[i][j]==0)
                {
                    OpenedCount++;
                }
            if(MinePositions[i][j]==-4)
            {
                flaggedMines++;
            }
        }
    }
    if(OpenedCount==0 || mineCount==0)
    {
        
    NSString *score=_Time.text;
    // get the current high score
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int highScore = [[defaults valueForKey:@"highScore"] intValue];
    
    // if the score of the last game is greater than the high score
    if ([score intValue] < highScore)
    {
        // update the file with the new high score
        
        [defaults setValue:[NSNumber numberWithInt:[score intValue]]
                    forKey:@"highScore"];
         [[NSUserDefaults standardUserDefaults]synchronize];
        highScore=[score intValue];
        highScoreAcheived=true;
    }
    if(highScore!=0)
        _Best_Time.text=[[NSNumber numberWithInt:highScore] stringValue];
    else
    {
        _Best_Time.text=[[NSNumber numberWithInt:[score intValue]] stringValue];
        [defaults setValue:[NSNumber numberWithInt:[score intValue]]
                    forKey:@"highScore"];
         [[NSUserDefaults standardUserDefaults]synchronize];
    }
        NSString *myString = @"Hurray you have acheived a new highscore  :";
        NSString *highScoreString = [myString stringByAppendingString:[NSString stringWithFormat:@"%02d", highScore]];
       // NSString *highScoreString=[NSString stringWithFormat:@"%02d", highScore];
    if(highScoreAcheived)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: highScoreString
                              message: @"Start a new Game!"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        GAMEFINISHSED=TRUE;
        [self setNeedsDisplay];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"You Won the Game"
                              message: @"Start a new Game!"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        GAMEFINISHSED=TRUE;
        [self setNeedsDisplay];
        [alert show];
    }
    }
 

}
- (IBAction)NewGame:(UIButton *)sender
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int highScore = [[defaults valueForKey:@"highScore"] intValue];
    [timer invalidate];
    _Best_Time.text=[[NSNumber numberWithInt:highScore] stringValue];
    isStart=true;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    no_of_Rows = [[defaults valueForKey:@"No_of_Rows"] intValue];
    no_of_Columns = [[defaults valueForKey:@"No_of_Columns"] intValue];
    if(no_of_Columns==0 || no_of_Rows==0)
    {
        no_of_Columns=5;
        no_of_Rows=5;
    }
    NSLog( @"drawRect:" );
    CGContextRef context = UIGraphicsGetCurrentContext();  // obtain graphics context
    CGRect bounds = [self bounds];          // get view's location and size
    CGFloat w = CGRectGetWidth( bounds );   // w = width of view (in points)
    CGFloat h = CGRectGetHeight ( bounds )-120; // h = height of view (in points)
    dw = (w)/no_of_Columns;                           // dw = width of cell (in points)
    dh = (h)/(no_of_Rows+3)+3;                           // dh = height of cell (in points)
   

       if(isStart)
    {
        //[self setBackgroundColor:[UIColor yellowColor]];
        mineCount=no_of_Columns*no_of_Rows*.20;
        _MineLabel.text=[[NSNumber numberWithInt:mineCount] stringValue];;
        [self FillRandomMines:mineCount];
        isStart=false;
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int highScore = [[defaults valueForKey:@"highScore"] intValue];
         _Best_Time.text=[[NSNumber numberWithInt:highScore] stringValue];
        timercount=0;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                               selector:@selector(countDown)
                                               userInfo:NULL
                                               repeats:YES];
        mineCount=no_of_Columns*no_of_Rows*0.20;  //no of mines are 20% of the total cells
    }
    NSLog( @"view (width,height) = (%g,%g)", w, h );
    NSLog( @"cell (width,height) = (%g,%g)", dw, dh );
    
    // draw lines to form a 16x16 cell grid
    CGContextBeginPath( context );               // begin collecting drawing operations
    for ( int i = 3;  i <=no_of_Rows+3;  i++ )
    {
        // draw horizontal grid line
        CGContextMoveToPoint( context, 0, i*dh);
        CGContextAddLineToPoint( context, w, i*dh);
    }
    for ( int i = 1;  i < no_of_Columns;  ++i )
    {
        // draw vertical grid line
        CGContextMoveToPoint( context, i*dw, 3*self.dh);
        CGContextAddLineToPoint( context, i*dw, h + 3*self.dh- no_of_Rows*self.dh);   //
    }
    [[UIColor grayColor] setStroke];             // use gray as stroke color
    
    CGContextDrawPath( context, kCGPathStroke ); // execute collected drawing ops
    
    
    

    if(SingleClickFlag==true)//if single click is detected just display the existing opened tiles
    {
        [self DisplayFlag];
        [self DisplayOpenedValues];
        SingleClickFlag=false;
    }
    
    if(DoubleClickFlag==true) //if a double click is detected cascade, calculate neighbouring mines and display opened tiles
        {
                [self neighbourMines:self.row aroundxy:self.col];
                [self DisplayOpenedValues];
                [self DisplayFlag];
            DoubleClickFlag=false;
        }

    if(!GAMEFINISHSED) //displaying only the opened values other places are covered
    {
        for(int i=0;i<no_of_Columns ;i++)
        {
            
            for(int j=0;j<no_of_Rows;j++)
            {
                if(MinePositions[i][j]==-1 || MinePositions[i][j]==0)
                {
                    CGRect imageRect = CGRectMake(i*dw, (j+3)*dh, dw-1, dh-1);
                    
                    [[UIColor grayColor] setFill];
                    UIRectFill(imageRect);
                    [[UIColor blackColor] set];
                    UIRectFrame(imageRect);
                }
            }
    
        }
    }
    if(GAMEFINISHSED) //if game is finished display all the mines
    {
        [self DisplayMines];
        GAMEFINISHSED=false;//reinitalising for next game
    }

}
- (void) countDown
{
    timercount+=1;
   // _Time.text=[self formattedTime:timercount];
    _Time.text=[NSString stringWithFormat:@"%i", timercount];
}
- (NSString *)formattedTime:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

- (void) neighbourMines:(int) xpos aroundxy:(int) ypos //calculates the neighouring 3*3 grid for no of mines till the termination conditons are met
{
    int minx, miny, maxx, maxy;
    int result = 0;
    if(MinePositions[xpos][ypos]!=-1 && MinePositions[xpos][ypos]!=-2 && MinePositions[xpos][ypos]!=-3 && MinePositions[xpos][ypos]!=-4 ) // termination condition for cascading of the mines
    {
        // Checking the boundary conditions
        minx = (xpos <= 0 ? 0 : xpos - 1);
        miny = (ypos <= 0 ? 0 : ypos - 1);
        maxx = (xpos >= 15 ? 15 : xpos + 2);
        maxy = (ypos >= 15 ? 15 : ypos + 2);
        if(xpos==16)
            maxx=15;
        if(ypos==16)
            maxy=15;
        // Check all immediate neighbours for mines
        for (int i = minx; i < maxx; i++)
        {
            for (int j = miny; j < maxy; j++)
            {
                if (MinePositions[i][j]==-1 || MinePositions[i][j]==-4)
                {
                    result++;
                }
            }
        }
        if(result>0) //&& (MinePositions[xpos][ypos]!=-3 || MinePositions[xpos][ypos]!=-4))
        {
            MinePositions[xpos][ypos]=result;
        }
        else
        {
            //if(MinePositions[xpos][ypos]!=-3 || MinePositions[xpos][ypos]!=-4)
            //{
                MinePositions[xpos][ypos]=-2;   //Blank Position
            //}
            for (int i = minx; i < maxx; i++)
            {
                for (int j = miny; j < maxy; j++)
                {
                 [self neighbourMines:i aroundxy:j];
                    
                }
            }
            
        }
    }
}

- (void) tapSingleHandler: (UITapGestureRecognizer *) sender
{
    NSLog( @"tapSingleHandler" );
    if ( sender.state == UIGestureRecognizerStateEnded )
    {
        SingleClickFlag=true;
        NSLog( @"(single tap recognized)" );
        CGPoint xy;
        xy = [sender locationInView: self];
        NSLog( @"(x,y) = (%f,%f)", xy.x, xy.y );
        NSLog( @"(dw,dh) = (%f,%f)", self.dw, self.dh );
        self.row = xy.x / self.dw;  self.col = xy.y / self.dh;
        NSLog( @"(row,col) = (%d,%d)", self.row, self.col );
        if(self.col-3 < 0 && self.col>no_of_Columns+3)
        {
            
        }
        else
        {
                self.col=self.col-3;
        
        if(MinePositions[self.row][self.col]==-3) //Flag already present at this location then remove the flag
        {
            MinePositions[self.row][self.col]=0;
        }
        else
        {
            if(MinePositions[self.row][self.col]==0)
            {
                MinePositions[self.row][self.col]=-3;
            }
        }
        if(MinePositions[self.row][self.col]==-1)
        {
            MinePositions[self.row][self.col]=-4;//-4 indicates if the flag posn has mines
            _MineLabel.text=[[NSNumber numberWithInt:--mineCount] stringValue];;
            [self setNeedsDisplay];
        }
        else
        {
            if(MinePositions[self.row][self.col]==-4)
            {
                MinePositions[self.row][self.col]=-1;//-4 indicates if the flag posn has mines
                _MineLabel.text=[[NSNumber numberWithInt:++mineCount] stringValue];
                [self setNeedsDisplay];
            }
        }
    }
        [self GameWon]; 
         [self setNeedsDisplay];
    }
}

- (void) tapDoubleHandler: (UITapGestureRecognizer *) sender
{
    NSLog( @"tapDoubleHandler" );
    
    CGPoint xy;
    xy = [sender locationInView: self];
    NSLog( @"(x,y) = (%f,%f)", xy.x, xy.y );
    NSLog( @"(dw,dh) = (%f,%f)", self.dw, self.dh );
    self.row = xy.x / self.dw;  self.col = xy.y / self.dh;
    NSLog( @"(row,col) = (%d,%d)", self.row, self.col );
    if(self.col-3 < 0 && self.col>no_of_Columns+3)
    {
        
    }
    else
    {
            self.col=self.col-3;

    if ( MinePositions[self.row][self.col]==-1 )
    {
        [self GameOver]; //If the hit tile has a mine then game over helper function is called
    }
    if(MinePositions[self.row][self.col]!=-3 && MinePositions[self.row][self.col]!=-4) //Disabling double click on flags
    {
        DoubleClickFlag=true;
        [self GameWon];  //Checking if the game is won
        [self setNeedsDisplay];
    }
    }
}

@end
