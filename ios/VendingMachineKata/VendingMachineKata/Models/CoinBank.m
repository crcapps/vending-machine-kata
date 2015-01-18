//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/18/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "CoinBag.h"
#import "CoinData.h"
#import "NSDecimalNumber+Currency.h"
#import "Notifications.h"

@implementation CoinBank

static void *bankedCoinsContext = &bankedCoinsContext;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [CoinBag new];
        [self registerForKeyValueObserving];
        [self registerForNotifications];
    }
    
    return self;
}

- (BOOL)canMakeChangeForAnything {
    BOOL threeNickels = self.bankedCoins.nickels >= 3;
    BOOL oneDimeAndTwoNickels = (self.bankedCoins.dimes >= 1 && self.bankedCoins.nickels >= 2);
    BOOL twoDimesAndOneNickel = (self.bankedCoins.dimes >= 2 && self.bankedCoins.nickels >= 1);
    BOOL canMakeChange = NO;
    
    if (threeNickels || oneDimeAndTwoNickels || twoDimesAndOneNickel) {
        canMakeChange = YES;
    }
    
    return canMakeChange;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == bankedCoinsContext) {
        NSString *notificationName = self.canMakeChangeForAnything ? kNotificationCanMakeChangeForAnything : kNotificationCannotMakeChangeForAnything;
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
    }
}

- (void)registerForKeyValueObserving {
    [self.bankedCoins addObserver:self forKeyPath:@"self.bankedCoins.quarters" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"self.bankedCoins.dimes" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"self.bankedCoins.nickels" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
    [self.bankedCoins addObserver:self forKeyPath:@"self.bankedCoins.pennies" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
}

- (void)unregisterForKeyValueObserving {
    [self.bankedCoins removeObserver:self forKeyPath:@"self.bankedCoins.quarters"];
    [self.bankedCoins removeObserver:self forKeyPath:@"self.bankedCoins.dimes"];
    [self.bankedCoins removeObserver:self forKeyPath:@"self.bankedCoins.nickels"];
    [self.bankedCoins removeObserver:self forKeyPath:@"self.bankedCoins.pennies"];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeChange:) name:kNotificationBankCoinsAndMakeChange object:nil];
}

#pragma mark - Notification Handlers

- (void)sufficientCredit:(NSNotification *)notification {
    NSString *notificationName = self.canMakeChangeForAnything ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChange:(NSNotification *)notification {
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    [insertedCoins emptyInto:self.bankedCoins];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
