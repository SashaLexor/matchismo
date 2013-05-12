//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Lexor on 02.04.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;

@property (readwrite,nonatomic) int score;



@end

@implementation CardMatchingGame

-(NSMutableArray *)cards // layzy instantiation of array of cards (property)
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

-(NSMutableArray *) story // массив истоии, содержит записи из лейбла истории
{
    if (!_story)
    {
        _story = [[NSMutableArray alloc]init];
    }
    return _story;
}

-(id)initWhitCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck // custon initialization of game obj.
{
    self = [super init];
    if (self)
    {
        for (int i = 0; i < cardCount; i++) // БЛ*ТЬ в цикле << поставил вместо <
        {
            Card *card = [deck drawRandomCard];
            if (!card) // проверка на nil, т.к нельзя помстить в массив nil
            {
                self = nil;
                break;
            }
            else 
            {
                self.cards[i] = card; // need a layzy instantiation
                self.threeCardMode = NO; // по умолчани при 1м запуске игра в режиме 2х кард
            }
        }
    }
    self.storyString = @"A new game was created";
    [self.story addObject:self.storyString];
    self.endOfTheGame = NO;
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    
    return (index < self.cards.count) ? self.cards[index] : nil; // проверка на корректный индекс !! Возвращает null !! т.к. в массив self.cards не попадают объекты
    
}

#define MATCH_BONUS 4 // определяем множители для счета 
#define MISSMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
{
    if (!self.threeCardMode)
    {
        [self twoCardMode:index];
    }
    else
    {
        [self threeCardMode:index];
    }
    
}

- (void)twoCardMode: (NSUInteger)index
{
    Card *card = [self cardAtIndex:index]; // получаем карту по индексу
    BOOL inMatchingMode = NO;
    if (card && !card.isUnPlayable) // проверка на то что верно получили карту и карта нах-ся "в игре" (*1) !
    {
        if (!card.isFaceUp) // не снимаем очни за закрытие карты ??
        {
            for (Card *otherCard in self.cards) // проходим по всему массиву кард
            {
                if (otherCard.isFaceUp && !otherCard.isUnPlayable) // если находим другую открытую карту и она же "в игре" (*2)
                {
                    inMatchingMode = YES;
                    int matchScore = [card match:@[otherCard]]; // то сравниваем карты / метод match: принимает массив, поэтому на ходу создаем массив из 1-го объекта @[otherCard]
                    if (matchScore) // если карты "сравнились" с не 0 результатом
                    {
                        otherCard.unPlayable = YES; // "выводим" карты из игры
                        card.unPlayable = YES;
                        self.score += matchScore * MATCH_BONUS; // и увельчиваем счет, с множителем MATCH_BONUS
                        
                        self.storyString = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.content, otherCard.content, matchScore * MATCH_BONUS];
                        [self.story addObject:self.storyString]; // добавляем запись в массив истории story
                        
                    } else // если карты не "сравнились" т.е. matchScore == 0
                    {
                        otherCard.faceUp = NO; // то оставляем открытой 2-ю карту
                        self.score -= MISSMATCH_PENALTY; // и уменьшаем счет на MISSMATCH_PENALTY
                        self.storyString = [NSString stringWithFormat:@"%@ and %@ don’t match! %d point penalty!",card.content, otherCard.content, MISSMATCH_PENALTY];
                        [self.story addObject:self.storyString];
                    }
                    break; // прерываем цикл если найдена открытая карта "в игре" см. услоние (*2)
                }
                
            }
            self.score -= FLIP_COST;
            if (!inMatchingMode)
            {
                self.storyString =[NSString stringWithFormat:@"Flipped up %@", card.content];
                [self.story addObject:self.storyString];
            }
        }
        card.faceUp = !card.isFaceUp; // непосредственно само переворачивание карты (при соблюдениее условий *1)
    }
    self.endOfTheGame = ![self checkTheEndOfTwoCardModeGame];
}

-(BOOL)checkTheEndOfTwoCardModeGame
{
    BOOL end = YES;
    for (int i=0; i < [self cardsInGame].count-1; i++)
    {
        for (int j = 0; j < [self cardsInGame].count; j++)
        {
            if (i != j)
            {
                int match = [[self cardsInGame][i]match:@[[self cardsInGame][j]]];
                if (match)
                {
                    end = NO;
                }

            }
        }
    }
    return end;
}

-(BOOL)checkTheEndOfThreeCardModeGame
{
    BOOL end = YES;
    for (int i=0; i < [self cardsInGame].count-1; i++)
    {
        for (int j = 0; j < [self cardsInGame].count; j++)
        {
            if (i != j)
            {
                int match = [[self cardsInGame][i]match:@[[self cardsInGame][j]]];
                if (match)
                {
                    for (int k = 0; k < [self cardsInGame].count ; k++)
                    {
                        if (k != i && k!= j)
                        {
                            int match_2 = [[self cardsInGame][i]match:@[[self cardsInGame][k]]];
                            int match_3 = [[self cardsInGame][j]match:@[[self cardsInGame][k]]];
                            if (match_2 || match_3)
                            {
                                end = NO;
                            }
                        }
                    }
                }                
            }
        }
    }
    return end;
    
}

-(NSMutableArray *)cardsInGame
{
    NSMutableArray *cardsInGame = [[NSMutableArray alloc]initWithCapacity:4];
    for (Card *card in self.cards)
    {
        if (!card.isUnPlayable)
        {
            [cardsInGame addObject:card];
        }
    }
    return cardsInGame;
}

-(void)threeCardMode:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index]; // получаем карту по индексу
    BOOL inMatchingMode = NO;
    if (card && !card.isUnPlayable) // проверка на то что верно получили карту и карта нах-ся "в игре" (*1) !
    {
        if (!card.isFaceUp) // не снимаем очни за закрытие карты ??
        {
            for (Card *otherCard in self.cards) // проходим по всему массиву кард
            {
                if (otherCard.isFaceUp && !otherCard.isUnPlayable) // если находим другую открытую карту и она же "в игре" (*2)
                {
                        for (Card *otherCard_2 in self.cards) // проходим по всему массиву кард
                        {
                            if (otherCard_2.isFaceUp && !otherCard_2.isUnPlayable)
                            {
                                if (otherCard_2 != card && otherCard_2 != otherCard)
                                {
                                    inMatchingMode = YES;
                                    int matchScore_1 = [card match:@[otherCard]];
                                    int matchScore_2 = [card match:@[otherCard_2]];
                                    int matchScore_3 = [otherCard match:@[otherCard_2]];
                                    if ((matchScore_1 && matchScore_2) || (matchScore_1 && matchScore_3) || (matchScore_2 && matchScore_3))
                                    {
                                        // сравниваем карты №1 и №2 + добавдяем счет
                                        otherCard_2.unPlayable = YES;
                                        otherCard.unPlayable = YES; // "выводим" карты из игры
                                        card.unPlayable = YES;
                                        
                                        self.score += (matchScore_1 + matchScore_2 + matchScore_3) * MATCH_BONUS; // и увельчиваем счет, с множителем MATCH_BONUS

                                        self.storyString = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points",card.content, otherCard.content,otherCard_2.content,  (matchScore_1 + matchScore_2 + matchScore_3) * MATCH_BONUS];
                                        [self.story addObject:self.storyString]; // добавляем запись в массив истории story   

                                    }
                                    else
                                    {
                                        
                                        otherCard.faceUp = NO; // то оставляем открытой 3-ю карту
                                        otherCard_2.faceUp = NO; // то оставляем открытой 3-ю карту
                                        self.score -= MISSMATCH_PENALTY; // и уменьшаем счет на MISSMATCH_PENALTY
                                        self.storyString = [NSString stringWithFormat:@"%@ and %@ don’t match! %d point penalty!",card.content, otherCard.content, MISSMATCH_PENALTY];
                                        [self.story addObject:self.storyString];

                                    }
                                }
                            }
                        }
                            
                
                    break; // прерываем цикл если найдена открытая карта "в игре" см. услоние (*2)
                }
                
            }
            self.score -= FLIP_COST;
            if (!inMatchingMode)
            {
                self.storyString =[NSString stringWithFormat:@"Flipped up %@", card.content];
                [self.story addObject:self.storyString];
            }
        }
        card.faceUp = !card.isFaceUp; // непосредственно само переворачивание карты (при соблюдениее условий *1)
    }
    self.endOfTheGame = ![self checkTheEndOfThreeCardModeGame];
}
@end
