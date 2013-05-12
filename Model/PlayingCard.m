//
//  PlayingCard.m
//  Matchismo
//
//  Created by Lexor on 01.04.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // необходимо @synthesize т.к. мы собственноручно реализовали getter & setter св-ва "suit"

- (NSString *) content // getter свойства описанного в суперклассе Card.h
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}
+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

-(NSString*)description
{
    return self.content;
}

-(NSString *)suit
{
  return _suit ? _suit : @"?";
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

-(int)match:(NSArray *)otherCards // переопределяем метод сравнения суперкласса
{
    int score = 0;
    if (otherCards.count == 1) // проверка на сравнение только с 1й картой. т.е. в массиве должен быть только 1н элемент
    {
        PlayingCard *otherCard = [otherCards lastObject]; //
        if ([otherCard.suit isEqualToString:self.suit]) // сравнение по масти
        {
            score = 1;
        } else if (otherCard.rank == self.rank) // сравнение по рейтингу
        {
            score = 4;
        }
    }
    return score;
}
@end
