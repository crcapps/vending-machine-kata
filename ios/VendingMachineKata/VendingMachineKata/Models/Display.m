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
    kDisplayModeExactChangeOnly = 1 << 1
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insufficientCredit:) name:kNotificationItemSelectedInsufficientCredit object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionInStock:) name:kNotificationItemSelectedInStock object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionOutOfStock:) name:kNotificationItemSelectedOutOfStock object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinsEmptied:) name:kNotificationChangeDispensed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinsWereReturned:) name:kNotificationCoinsReturned object:nil];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDisplayUpdated object:self userInfo:@{kUserInfoKeyText : text}];
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

- (void)insufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *price = [notification.userInfo valueForKey:kUserInfoKeyPrice];
    NSDecimalNumber *credit = [notification.userInfo valueForKey:kUserInfoKeyCredit];
    self.credit = credit.localizedCurrencyString;
    NSComparisonResult compare = [credit compare:@0.00];
    NSString *priceText = price.localizedCurrencyString;
    NSString *text;
    NSInteger quantity = [[notification.userInfo objectForKey:kUserInfoKeyQuantity] integerValue];
    if (quantity > 0) {
        text = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, priceText];
    } else {
        text = kDisplayTextSoldOut;
    }
    if (compare == NSOrderedDescending) {
        self.displayMode |= kDisplayModeShowCredit;
    }
    _text = text;
}

- (void)selectionInStock:(NSNotification *)notification {
    _text = kDisplayTextThankYou;
    self.credit = nil;
    self.displayMode &= ~kDisplayModeShowCredit;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPurchaseCompleted object:self userInfo:notification.userInfo];
}

- (void)coinsEmptied:(NSNotification *)notification {
    self.credit = nil;
    self.displayMode &= ~kDisplayModeShowCredit;
}

- (void)selectionOutOfStock:(NSNotification *)notification {
    NSDecimalNumber *credit = [notification.userInfo valueForKey:kUserInfoKeyCredit];
    NSComparisonResult compare = [credit compare:@0.00];
    if (NSOrderedDescending == compare) {
        self.displayMode |= kDisplayModeShowCredit;
    }
    self.credit = credit.localizedCurrencyString;
    _text = kDisplayTextSoldOut;
}

- (void)coinsWereReturned:(NSNotification *)notification {
    self.credit = nil;
    self.displayMode &= ~kDisplayModeShowCredit;
    [self resetText];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
