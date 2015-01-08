//
//  Display.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/7/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Display.h"
#import "Notifications.h"

NSString * const kDisplayTextInsertCoin = @"INSERT COIN";

@implementation Display

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetText];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinWasAccepted:) name:kNotificationCoinAccepted object:nil];
    }
    
    return self;
}

- (void)resetText {
    _text = kDisplayTextInsertCoin;
}

- (void)coinWasAccepted:(NSNotification *)notification {
    NSString *text = [notification.userInfo valueForKey:@"text"];
    if (text) {
        _text = text;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
