//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"
#import "NSCountedSet+CoinValue.h"
#import "Notifications.h"

@implementation CoinBank

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [NSCountedSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    }
    
    return self;
}

- (BOOL)canMakeChangeForAmount:(NSDecimalNumber *)amount {
    BOOL canMakeChange = NO;
    if ([amount compare:[NSDecimalNumber zero]] == NSOrderedSame) {
        canMakeChange = YES;
    }
    if ([amount compare:self.bankedCoins.value] != NSOrderedDescending) {
        
    }
    return canMakeChange;
}

- (void)sufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *amount = [notification.userInfo objectForKey:kUserInfoKeyChange];
    BOOL canMakeChange = [self canMakeChangeForAmount:amount];
    NSString *notificationName = canMakeChange ? kNotificationCanMakeChangeForSelection : kNotificationCannotMakeChangeForSelection;
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:notification.userInfo];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
