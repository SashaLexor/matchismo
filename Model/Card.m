//
//  Card.m
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards)
    {
        if ([card.content isEqualToString: self.content])
        {
            score = 1;
        }
    }
    return score;
}
@end
