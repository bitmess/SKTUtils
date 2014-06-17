//
//  JHGameKitHelper.h
//  inline
//
//  Created by LIJIAHAN on 14-5-30.
//  Copyright (c) 2014年 codingcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;

@interface JHGameKitHelper : NSObject <GKGameCenterControllerDelegate>
@property (nonatomic, strong, readonly) UIViewController *authViewController;
@property (nonatomic, strong, readonly) NSError *lastError;

+ (instancetype)sharedInstance;

- (void)authLocalPlayer;

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)leaderboardID;
- (void)showGameCenterViewControllerWithTopViewController:(UIViewController *)topViewController;

@end
