//
//  SetCard.h
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic) int color;
@property (nonatomic) int shape;
@property (nonatomic) int amount;
@property (nonatomic) int shade;

+(int) maxAmount;
+(int) maxShade;
+(int) maxColor;
+(int) maxShape;

@end
