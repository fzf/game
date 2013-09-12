//
//  Character.h
//  game
//
//  Created by Fletcher Fowler on 9/11/13.
//  Copyright (c) 2013 ZamboniDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HealthBar.h"

@interface Character : NSObject
{
    CCSprite *sprite;
    float currentHealth;
    float maxHealth;
    HealthBar *healthBar;
    CCLayer *layer;

}

@property (nonatomic,retain) CCSprite *sprite;
@property (nonatomic,assign) float currentHealth;
@property (nonatomic,assign) float maxHealth;
@property (nonatomic,retain) CCLayer *layer;
@property (nonatomic,assign) int speed;

- (id)initInLayer:(CCLayer *)l;
- (void)attack:(Character *)character;
- (void)loseLife:(NSInteger *)life;
- (CCAnimate *)attackAction;
- (void)counterAttack;

@end
