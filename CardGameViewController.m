//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Lexor on 27.03.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *storyLable;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game; // свойство модели игры
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;

@end

@implementation CardGameViewController

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
        self.game = [[CardMatchingGame alloc]initWhitCardCount:self.cardButtons.count
                                                     usingDeck:[[PlayingDeck alloc]init]];
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
    UIImage *cardBack = [UIImage imageNamed:@"cardBack.jpg"];
    UIImage *cardTop = [UIImage imageNamed:@"cardTop.jpg"];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:fon]];
    for (UIButton *button in self.cardButtons)
    {
        [button setBackgroundImage:cardBack forState:UIControlStateNormal];
        [button setBackgroundImage:cardTop forState:UIControlStateSelected];
        [button setBackgroundImage:cardTop forState:UIControlStateDisabled];
    }
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
        _game = [[CardMatchingGame alloc]initWhitCardCount:self.cardButtons.count
                                                 usingDeck:[[PlayingDeck alloc]init]];// Deck создаем на лету, количество кард равно количеству кард-кнопок на view
        _game.endOfTheGame = YES;
    }
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}


- (IBAction)flipCard:(UIButton *)sender
{
    self.gameModeControl.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]]; // модель занимается переворачиванием
    [self updateUI]; // каждай раз как переворачиваем карту надо обновить интерфейс
}

-(void)updateUI // метод обновления интерфейся для синхронизации изменений в модели
{
    for (UIButton *cardButton in self.cardButtons) // проходим по массиву кнопок-кард
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];  // получаем карту для каждой кнопки
        [cardButton setTitle:card.content forState:UIControlStateSelected]; 
        [cardButton setTitle:card.content forState:UIControlStateSelected | UIControlStateDisabled];// устанавливаем Title = полученной карте из модели для состояний
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.5 : 1.0;
        
    }
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
