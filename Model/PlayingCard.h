//
//  PlayingCard.h
//  Matchismo
//
//  Created by Lexor on 01.04.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit; // масть карты
@property (nonatomic) NSUInteger rank; // "рейтинг"

+(NSArray *)validSuits;
+(NSUInteger)maxRank;
-(NSString *)content;

@end
