//
//  HealthBar.m
//  MathCar
//
//  Created by Mohammad Azam on 5/24/11.
//  Copyright 2011 HighOnCoding. All rights reserved.
//

#import "HealthBar.h"


@implementation HealthBar

@synthesize sprite,progressTimer;

static const ccColor3B ccDARKGREEN={0,100,0};


-(id) init
{
    self = [super init];
    self.progressTimer = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"health.png"]];
    self.progressTimer.type = kCCProgressTimerTypeBar;
    [self.progressTimer setColor:ccDARKGREEN];
    [self.progressTimer setScaleY:0.2];
    [self.progressTimer setScaleX:0.2];
    self.progressTimer.percentage = 100;
    self.progressTimer.midpoint = ccp(0, 0);
    self.progressTimer.barChangeRate = ccp(1, 0);
    
    return self;
}

-(void) update
{
    
}

@end
