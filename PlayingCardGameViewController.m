//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Lexor on 05.06.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingDeck.h"
#import "PlayingCardCollectionViewCell.h"

@interface PlayingCardGameViewController ()

@property (nonatomic) int startingCardCount; // ABSTRACT

@end

@implementation PlayingCardGameViewController

 -(int)startingCardCount
{
    return 20;
}

-(Deck *)createDeck
{
    return [[PlayingDeck alloc]init];
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]])
    {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.faceUp;
            playingCardView.alpha = playingCard.isUnPlayable ? 0.3 : 1.0 ;
        }
    }
}
@end
