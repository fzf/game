//
//  HelloWorldLayer.h
//  game
//
//  Created by Fletcher Fowler on 9/5/13.
//  Copyright ZamboniDev 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Character.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CGSize windowSize;
    Character *character;
    Character *opponent;

}

@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) Character *opponent;
@property (nonatomic, strong) CCSprite *human;

@property (nonatomic, strong) CCAction *walkAction;
@property (nonatomic, strong) CCAction *moveAction;
@property (nonatomic, strong) CCProgressTimer *progressTimer;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
