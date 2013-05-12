//
//  PlayingDeck.m
//  Matchismo
//
//  Created by Lexor on 01.04.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "PlayingDeck.h"
#import "PlayingCard.h"

@implementation PlayingDeck

-(id)init // инициализация колоды карт 4 масти по 13 рейтингов =  52 карты
          // возвращаемый тип id - тип любого объекта objective C
{
    self = [super init]; // обязательно вызвать инициализацию суперкласса
    if (self)
    {
        for (NSString *suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
        
    }
    
    return self;
}


@end
