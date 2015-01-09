//
//  Inventory.m
//  VendingMachineKata
//
//  Created by Casey Ryan Capps on 1/8/15.
//  Copyright (c) 2015 Casey Ryan Capps. All rights reserved.
//

#import "Inventory.h"
#import "Notifications.h"

@implementation Inventory

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sufficientCredit:) name:kNotificationItemSelectedSufficientCredit object:nil];
    }
    
    return self;
}

- (NSDictionary *)itemPrices {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : [NSDecimalNumber decimalNumberWithDecimal:[@1.00 decimalValue]],
                  @(kInventoryItemChips) : [NSDecimalNumber decimalNumberWithDecimal:[@0.50 decimalValue]],
                  @(kInventoryItemCandy) : [NSDecimalNumber decimalNumberWithDecimal:[@0.65 decimalValue]]
                  };
    });
    
    return items;
}

- (NSDictionary *)itemNames {
    static NSDictionary *items = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        items = @{
                  @(kInventoryItemCola) : @"Cola",
                  @(kInventoryItemChips) : @"Chips",
                  @(kInventoryItemCandy) : @"Candy"
                  };
    });
    
    return items;
}

- (NSDecimalNumber *)selectItem:(InventoryItem)item {
    NSDecimalNumber *itemPrice = [self.itemPrices objectForKey:@(item)];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationItemSelected
     object:self
     userInfo:@{
                kUserInfoKeyPrice : itemPrice,
                kUserInfoKeyItem : @(item)
                }];
    
    return itemPrice;
}

- (void)sufficientCredit:(NSNotification *)notification {
    InventoryItem item = [[notification.userInfo valueForKey:kUserInfoKeyItem] integerValue];
    NSString *itemString = [self.itemNames objectForKey:@(item)];
    NSLog(@"Dispensed a %@", itemString);
}

- (void)dispenseProduct:(InventoryItem)item {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
