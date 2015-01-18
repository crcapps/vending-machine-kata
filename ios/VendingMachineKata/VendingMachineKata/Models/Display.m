//
//  Display.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/17/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Display.h"
#import "Notifications.h"
#import "NSDecimalNumber+Currency.h"

typedef NS_OPTIONS(NSInteger, DisplayMode) {
    kDisplayModeReady = 0x00,
    kDisplayModeShowCredit = 1 << 0,
    kDisplayModeShouldResetToCredit = 1 << 1,
    kDisplayModeExactChangeOnly = 1 << 2
};

NSString * const kDisplayTextInsertCoin = @"INSERT COIN";
NSString * const kDisplayTextThankYou = @"THANK YOU";
NSString * const kDisplayTextPrice = @"PRICE";
NSString * const kDisplayTextSoldOut = @"SOLD OUT";
NSString * const kDisplayTextExactChangeOnly = @"EXACT CHANGE ONLY";

@interface Display ()

@property (nonatomic) DisplayMode displayMode;

@property (nonatomic, strong) NSString *credit;

@end

@implementation Display

@synthesize text = _text;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.displayMode = kDisplayModeReady;
        [self registerForNotifications];
        [self resetText];
    }
    
    return self;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinWasAccepted:) name:kNotificationCoinAccepted object:nil];
}

- (NSString *)text {
    NSString *text = _text;
    if (self.displayMode & kDisplayModeShowCredit) {
        _text = self.credit;
    } else {
        [self resetText];
    }
    return text;
}

- (void)setText:(NSString *)text {
    _text = text;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDisplayUpdated object:self userInfo:@{kUserInfoKeyDisplayText : text}];
}

- (void)resetText {
    if (self.displayMode & kDisplayModeExactChangeOnly) {
        _text = kDisplayTextExactChangeOnly;
    } else {
        _text = kDisplayTextInsertCoin;
    }
}

#pragma mark - Notification Handlers

- (void)coinWasAccepted:(NSNotification *)notification {
    self.displayMode |= kDisplayModeShowCredit;
    NSDecimalNumber *credit = [notification.userInfo valueForKey:kUserInfoKeyCredit];
    NSString *text = credit.localizedCurrencyString;
    self.credit = text;
    if (text) {
        _text = text;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
