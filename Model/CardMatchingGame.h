//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Lexor on 02.04.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id)initWhitCardCount:(NSUInteger) cardCount // кастомная инициализация
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger) index; // переворачивает карту, тут же основная логика игры (сравнение и score)

-(Card *)cardAtIndex:(NSUInteger) index; // возвращает карту по индексу

@property (nonatomic, readonly) int score;

@property (nonatomic, strong) NSMutableArray *story;
@property (nonatomic, strong) NSString *storyString;
@property (nonatomic) BOOL endOfTheGame;
@property BOOL threeCardMode;

@end
