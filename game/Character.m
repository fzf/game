//
//  Character.m
//  game
//
//  Created by Fletcher Fowler on 9/11/13.
//  Copyright (c) 2013 ZamboniDev. All rights reserved.
//

#import "Character.h"
#import "Colors.h"

@implementation Character

- (id)initInLayer:(CCLayer *)l {
    self = [super init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"soldier.plist"];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"soldier.png"];
    [self.layer addChild:spriteSheet];
        
    self.sprite = [CCSprite spriteWithSpriteFrameName:@"enemy_soldier_lance_4.gif"];
    self.sprite.scale = 3;
    self.layer = l;
    self.maxHealth = 100;
    self.currentHealth = self.maxHealth; // start with max health
    // attach the health bar
    healthBar = [[HealthBar alloc] init];
    healthBar.progressTimer.position = ccp(self.sprite.contentSize.width/2,self.sprite.contentSize.height + 10);
    [self.sprite addChild:healthBar.progressTimer z:1];
    
    return self;
}

- (void)attack:(Character *)character {
    NSInteger randomNumber = arc4random() % 16;
    [character loseLife:randomNumber];
    [self animateAttack:character];
}

- (CCAnimate *)attackAction {
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"enemy_soldier_lance_%d.gif",i]]];
    }
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.4f];
    
    CCAnimate *animate = [CCAnimate actionWithAnimation:walkAnim];
    
    return animate;
}

- (void)counterAttack {
    CCSequence *seq = [CCSequence actions:[self attackAction], nil];
    [self.sprite runAction:seq];
}

- (void)takeHit {
    
}

- (void)animateAttack:(Character *)character {

    CCSequence *seq = [CCSequence actions:[self attackAction], [CCCallFunc actionWithTarget:character selector:@selector(counterAttack)], nil];
    [self.sprite runAction:seq];
}


- (void)loseLife:(NSInteger *)life {
    self.currentHealth = (int)self.currentHealth - (int)life;
    healthBar.progressTimer.percentage = 100 * (self.currentHealth/self.maxHealth);
    if (healthBar.progressTimer.percentage < 99)
    {
        [healthBar.progressTimer setColor:ccYELLOW];
    }
}

@end
