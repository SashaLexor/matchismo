//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

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

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // ABSTRACT
}

- (IBAction)startNewGame
{
    UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"Start new game" message:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Yes", nil];
    [newGameMessage show];
    
    
}

-(Deck *)createDeck /// TEMP ABSTRACT 
{
    return nil;
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
    //UIImage *fon = [UIImage imageNamed:@"fon.jpg"];
    
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



- (IBAction)flipCard:(UIButton *)sender
{
    int index = 0; /// TEMP
    
    self.gameModeControl.enabled = NO;
    [self.game flipCardAtIndex:index]; // модель занимается переворачиванием
    [self updateUI]; // каждай раз как переворачиваем карту надо обновить интерфейс
}

-(void)updateUI // метод обновления интерфейся для синхронизации изменений в модели
{
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.storyLable.text = [self.game.story lastObject];
    
    if (!self.game.endOfTheGame)
    {
        UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"End of the Game" message:[NSString stringWithFormat:@"%@",self.scoreLable.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [newGameMessage show];

    }
    
   // NSLog(@"Game mode is %@", self.game.threeCardMode ? @"3 card" : @"2 card");
    
}

@end
