//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingDeck.h"
#import "PlayingCardView.h"
#import "PlayingCardCollectionViewCell.h"

@interface CardGameViewController () <UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *storyLable;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game; // свойство модели игры
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;

@end

@implementation CardGameViewController


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

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
    
    NSLog(@"%@",card);
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


- (IBAction)startNewGame
{
    UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"Start new game" message:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Yes", nil];
    [newGameMessage show];
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.gameModeControl.enabled = YES;
        self.game = [[CardMatchingGame alloc]initWhitCardCount:self.startingCardCount
                                                     usingDeck:[self createDeck]];
        self.game.endOfTheGame = YES;
        if (self.gameModeControl.selectedSegmentIndex == 0)
        {
            self.game.threeCardMode = NO;
            NSLog(@"2 card mode");
        }
        else
        {
            NSLog(@"3 card mode");
            self.game.threeCardMode = YES;
        }
                     
        [self updateUI];
    }
}


-(void)viewDidLoad
{
    self.gameModeControl.enabled = YES;
    [self updateUI];
}
- (IBAction)switchGameMode:(id)sender
{
    if (self.gameModeControl.selectedSegmentIndex == 0)
    {
        self.game.threeCardMode = NO;
        NSLog(@"2 card mode");
    }
    else
    {
        NSLog(@"3 card mode");
        self.game.threeCardMode = YES;
    }

}

-(CardMatchingGame *)game // layzy instantiation of game property
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc]initWhitCardCount:self.startingCardCount
                                                 usingDeck:[self createDeck]];// Deck создаем на лету, количество кард равно количеству кард-кнопок на view
        _game.endOfTheGame = YES;
    }
    return _game;
}



- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *index = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (index)
    {
                
        self.gameModeControl.enabled = NO;
        [self.game flipCardAtIndex:index.item]; // модель занимается переворачиванием
        [self updateUI]; // каждай раз как переворачиваем карту надо обновить интерфейс
    }
    
}

-(void)updateUI // метод обновления интерфейся для синхронизации изменений в модели
{
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.storyLable.text = [self.game.story lastObject];
    
    NSLog(@"Update UI");
    
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *path = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:path.item];
        [self updateCell:cell usingCard:card];
    }
    
    if (!self.game.endOfTheGame)
    {
        UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"End of the Game" message:[NSString stringWithFormat:@"%@",self.scoreLable.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [newGameMessage show];

    }
    
    
}

@end
