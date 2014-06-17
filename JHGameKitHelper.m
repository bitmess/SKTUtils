//
//  JHGameKitHelper.m
//  inline
//
//  Created by LIJIAHAN on 14-5-30.
//  Copyright (c) 2014年 codingcoder. All rights reserved.
//

#import "JHGameKitHelper.h"

NSString *const NTF_PresentAuthenticationViewController = @"NTF_PresentAuthenticationViewController";
NSString *const NTF_GameCenterViewControllerDidAppear = @"NTF_GameCenterViewControllerDidAppear";
NSString *const NTF_GameCenterViewControllerDidDisappear = @"NTF_GameCenterViewControllerDidDisappear";



@implementation JHGameKitHelper
{
    BOOL _enableGameCenter;
}

+ (instancetype)sharedInstance
{
    static JHGameKitHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[JHGameKitHelper alloc] init];
    });
    return helper;
}

- (instancetype)init
{
    if (self = [super init]) {
        _enableGameCenter = YES;
    }
    return self;
}

- (void)authLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer setAuthenticateHandler:^(UIViewController *viewController, NSError *error) {
        self->_lastError = error;
        if (error) {
            NSLog(@"auth error = %@", error.description);
        }
        
        if (viewController) {
            self->_authViewController = viewController;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NTF_PresentAuthenticationViewController object:self];
            });
        } else {
            if ([GKLocalPlayer localPlayer].isAuthenticated) {
                self->_enableGameCenter = YES;
            } else {
                self->_enableGameCenter = NO;
            }
        }
        
    }];
}

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)leaderboardID
{
    if (!_enableGameCenter) {
        NSLog(@"not enable game center");
    } else {
        GKScore *gkScore = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardID];
        gkScore.value = score;
        
        [GKScore reportScores:@[gkScore] withCompletionHandler:^(NSError *error) {
            self->_lastError = error;
            if (error) {
                NSLog(@"report scores error = %@", error.description);
            }
        }];
    }
}

- (void)showGameCenterViewControllerWithTopViewController:(UIViewController *)topViewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NTF_GameCenterViewControllerDidAppear object:self];
    });
    
    GKGameCenterViewController *gameCenterViewController = [[GKGameCenterViewController alloc] init];
    gameCenterViewController.gameCenterDelegate = self;
    gameCenterViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    
    [topViewController presentViewController:gameCenterViewController animated:YES completion:nil];
}

#pragma mark - 
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NTF_GameCenterViewControllerDidDisappear object:self];
    });
}

@end
