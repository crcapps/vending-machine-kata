//
//  Display.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Display.h"

NSString * const kDisplayTextInsertCoin = @"INSERT COIN";

@implementation Display

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetText];
    }
    
    return self;
}

- (void)resetText {
    _text = kDisplayTextInsertCoin;
}

@end
