//
//  Character.m
//  game
//
//  Created by Fletcher Fowler on 9/11/13.
//  Copyright (c) 2013 ZamboniDev. All rights reserved.
//

#import "Character.h"

@implementation Character

- (id)initInLayer:(CCLayer *)l {
    self = [super init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"human.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"human.png"];
    [self.layer addChild:spriteSheet];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=4; i<=6; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"human-%d.png",i]]];
    }
    
    self.sprite = [CCSprite spriteWithSpriteFrameName:@"human-4.png"];
    self.layer = l;
    self.maxHealth = 100;
    self.currentHealth = self.maxHealth; // start with max health
    // attach the health bar
    healthBar = [[HealthBar alloc] initWithProgressTimerSprite:@"green_health_bar.png"];
    healthBar.progressTimer.position = ccp(self.sprite.contentSize.width/2,-5);
    [self.sprite addChild:healthBar.progressTimer z:1];
    
    return self;
}

- (void)attack:(Character *)character {
    NSInteger randomNumber = arc4random() % 16;
    [character loseLife:randomNumber];
}

- (void)loseLife:(NSInteger *)life {
    self.currentHealth = (int)self.currentHealth - (int)life;
    healthBar.progressTimer.percentage = 100 * (self.currentHealth/self.maxHealth);
}

@end
