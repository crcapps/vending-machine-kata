//
//  VendingMachine.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "VendingMachine.h"
#import "CoinSlot.h"
#import "Display.h"
#import "CoinReturn.h"

@implementation VendingMachine

- (instancetype)init {
    self = [super init];
    if (self) {
        _coinSlot = [CoinSlot new];
        _display = [Display new];
        _coinReturn = [CoinReturn new];
    }
    
    return self;
}

@end
