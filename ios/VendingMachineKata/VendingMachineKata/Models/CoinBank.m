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
        [self.bankedCoins addObserver:self forKeyPath:@"quarters" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
        [self.bankedCoins addObserver:self forKeyPath:@"dimes" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
        [self.bankedCoins addObserver:self forKeyPath:@"nickels" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
        [self.bankedCoins addObserver:self forKeyPath:@"pennies" options:NSKeyValueObservingOptionNew context:bankedCoinsContext];
    }
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == bankedCoinsContext) {
        
    }
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeChange:) name:kNotificationBankCoinsAndMakeChange object:nil];
}

#pragma mark - Notification Handlers

- (void)sufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *purchasePrice = [notification.userInfo objectForKey:kUserInfoKeyPrice];
    NSDecimalNumber *changeDue = [notification.userInfo objectForKey:kUserInfoKeyChange];
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    BOOL canMakeChange = [self canMakeChangeForAmount:changeDue onPrice:purchasePrice withCoinsInserted:insertedCoins];
    
    
    NSString *notificationName = canMakeChange ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)makeChange:(NSNotification *)notification {
    CoinBag *insertedCoins = [notification.userInfo objectForKey:kUserInfoKeyCoins];
    [insertedCoins emptyInto:self.bankedCoins];
}



@end
