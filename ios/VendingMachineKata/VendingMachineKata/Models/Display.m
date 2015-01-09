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
NSString * const kDisplayTextThankYou = @"THANK YOU";
NSString * const kDisplayTextPrice = @"PRICE";
NSString * const kDisplayTextSoldOut = @"SOLD OUT";

@interface Display ()

/** If the display should display the total value of inserted coins */
@property (nonatomic)           BOOL        shouldDisplayCredit;

/** The credit to be displayed */
@property (nonatomic, strong)   NSString    *credit;

@end

@implementation Display

@synthesize text = _text;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resetText];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinWasAccepted:) name:kNotificationCoinAccepted object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionInStock:) name:kNotificationItemSelectedInStock object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insufficientCredit:) name:kNotificationItemSelectedInsufficientCredit object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionOutOfStock:) name:kNotificationItemSelectedOutOfStock object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coinsWereReturned:) name:kNotificationCoinsReturned object:nil];
    }
    
    return self;
}

- (NSString *)text {
    NSString *text = _text;
    if (self.shouldDisplayCredit) {
        self.shouldDisplayCredit = NO;
        _text = self.credit;
    } else {
        [self resetText];
    }
    return text;
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

- (void)selectionInStock:(NSNotification *)notification {
    _text = kDisplayTextThankYou;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPurchaseCompleted object:self userInfo:notification.userInfo];
}

- (void)selectionOutOfStock:(NSNotification *)notification {
    // noop, for now.
}

- (void)insufficientCredit:(NSNotification *)notification {
    NSDecimalNumber *price = [notification.userInfo valueForKey:kUserInfoKeyPrice];
    NSDecimalNumber *credit = [notification.userInfo valueForKey:kUserInfoKeyCredit];
    self.credit = [NSNumberFormatter
                   localizedStringFromNumber:credit
                   numberStyle:NSNumberFormatterCurrencyStyle];
    NSComparisonResult compare = [credit compare:@0.00];
    NSString *priceText = [NSNumberFormatter
                           localizedStringFromNumber:price
                           numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *text = [NSString stringWithFormat:@"%@ %@", kDisplayTextPrice, priceText];
    if (compare == NSOrderedDescending) {
        self.shouldDisplayCredit = YES;
    }
    _text = text;
}

- (void)coinsWereReturned:(NSNotification *)notification {
    [self resetText];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
