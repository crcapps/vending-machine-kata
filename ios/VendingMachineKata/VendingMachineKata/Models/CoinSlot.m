//
//  CoinSlot.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinSlot.h"
#import "CoinData.h"
#import "Notifications.h"
#import "NSCountedSet+CoinValue.h"

@implementation CoinSlot

- (instancetype)init {
    self = [super init];
    if (self) {
        _insertedCoins= [NSCountedSet new];
        _returnedCoins = [NSCountedSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemWasSelected:) name:kNotificationItemSelected object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseWasCompleted:) name:kNotificationPurchaseCompleted object:nil];
    }
    
    return self;
}

- (void)dropCoinWithDiameter:(NSNumber *)diameter mass:(NSNumber *)mass thickness:(NSNumber *)thickness {
    CoinData *coinData = [CoinData identifyCoinForDiameter:diameter mass:mass thickness:thickness];
    if (coinData.isAccepted) {
        [self.insertedCoins addObject:coinData];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCoinAccepted object:self userInfo:@{@"text":self.insertedCoins.valueText}];
    } else {
        [self.returnedCoins addObject:coinData];
    }
}

- (void)itemWasSelected:(NSNotification *)notification {
    NSDecimalNumber *price = [notification.userInfo valueForKey:@"price"];
    NSComparisonResult compare = [price compare:self.insertedCoins.value];
    if (compare == NSOrderedDescending) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationItemSelectedInsufficientCredit
         object:self userInfo:@{
                                @"price" : price,
                                @"credit" : self.insertedCoins.value
                                }];
    } else {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kNotificationItemSelectedSufficientCredit
         object:self userInfo:@{
                                @"price" : price,
                                @"credit" : self.insertedCoins.value
                                }];
    }
}

- (void)purchaseWasCompleted:(NSNotification *)notification {
    //[self.insertedCoins empty];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
