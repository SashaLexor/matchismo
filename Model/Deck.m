//
//  Deck.m
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong,nonatomic) NSMutableArray *cards; //Массив с объектами Card (колода)
@end

@implementation Deck

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init]; // "ленивая" инициализация
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop)
    {
        [self.cards insertObject:card atIndex:0]; // self.cards не может возвращать nil, т.к. в массив не может быть записан nil. nil - означает конец массива. Необходимо реализовать "лениую" инициализацию см. выше
    }
     else
    {
        [self.cards addObject:card];
    }
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count) // проверка на пустой массив
    {
        unsigned index = arc4random()%self.cards.count; // генерируем случайный индекс
        randomCard = self.cards[index]; // в случае попытки получить объект из пустого массиа получим CRASH, необходима проверка на наличие элементов в массиве см. выше
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
