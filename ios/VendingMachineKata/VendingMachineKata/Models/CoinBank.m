//
//  CoinBank.m
//  VendingMachineKata
//
//  Created by the Heatherness on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "CoinBank.h"

@implementation CoinBank

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _bankedCoins = [NSCountedSet new];
    }
    
    return self;
}

@end
