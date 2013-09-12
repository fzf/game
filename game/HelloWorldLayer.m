//
//  HelloWorldLayer.m
//  game
//
//  Created by Fletcher Fowler on 9/5/13.
//  Copyright ZamboniDev 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

CCSprite *seeker1;
CCSprite *cocosGuy;

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
    [scene addChild: layer];
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        windowSize = [[CCDirector sharedDirector] winSize];
        
        self.character = [[Character alloc] initInLayer:self];
        self.character.sprite.position = ccp(windowSize.width - (windowSize.width - 60),windowSize.height/2);
        [self addChild:self.character.sprite z:1];

        self.opponent = [[Character alloc] initInLayer:self];
        self.opponent.sprite.flipX = TRUE;
        self.opponent.sprite.position = ccp(windowSize.width - 60,windowSize.height/2);
        [self addChild:self.opponent.sprite z:1];
        
        [self loadMenu];
        self.touchEnabled = YES;
        
	}
	return self;
}

-(void) loadMenu
{
    CCMenuItemImage *menuAttack = [CCMenuItemImage itemWithNormalImage:@"sword.png" selectedImage:@"sword.png" target:self selector:@selector(attack:)];

    CCMenu *menu = [CCMenu menuWithItems:menuAttack, nil];
    [menu alignItemsVerticallyWithPadding:10];
    
    menu.position = ccp(0, 20);
    
    [self addChild:menu];
}

-(void) attack:(id)responder {
    [self.character attack:self.opponent];
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void) nextFrame:(ccTime)dt {
    seeker1.position = ccp( seeker1.position.x + 100*dt, seeker1.position.y );
    if (seeker1.position.x > 480+32) {
        seeker1.position = ccp( -32, seeker1.position.y );
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];
    
	[cocosGuy stopAllActions];
	[cocosGuy runAction: [CCMoveTo actionWithDuration:1 position:location]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
