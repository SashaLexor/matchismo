//
//  SetViewConttrollerViewController.m
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "SetViewConttroller.h"
#import "SetDeck.h"

@interface SetViewConttroller ()

@property (nonatomic) SetDeck *deck;

@end

@implementation SetViewConttroller

-(SetGame *)game
{
    if (!_game)
    {
        _game = [[SetGame alloc]initWhitCardCount:24 usingDeck:self.deck];
    }
    return _game;
}

-(SetDeck *)deck
{
    if (!_deck)
    {
        _deck = [[SetDeck alloc]init];
    }
    return _deck;
}

+(NSArray *)validColor
{
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
}

+(NSArray *)validShape
{
    return @[@"■", @"▲", @"●"];
}

-(NSAttributedString *)contentOfCardAtIndex:(int) index
{
    float alpha = 0.0;
    NSMutableString *str = [NSMutableString stringWithString:[SetViewConttroller validShape][[self.game cardAtIndex:index].shape]];
    
    for (int i = 1; i < [self.game cardAtIndex:index].amount; i++)
    {
        str = [[str stringByAppendingString:[SetViewConttroller validShape][[self.game cardAtIndex:index].shape]]mutableCopy];
    }
    
    if ([self.game cardAtIndex:index].shade == 0) alpha = 0.0;
    if ([self.game cardAtIndex:index].shade == 1) alpha = 0.2;
    if ([self.game cardAtIndex:index].shade == 2) alpha = 1.0;
    
        
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName : [[SetViewConttroller validColor][[self.game cardAtIndex:index].color]colorWithAlphaComponent:alpha], NSStrokeWidthAttributeName : @-8,NSStrokeColorAttributeName : [SetViewConttroller validColor][[self.game cardAtIndex:index].color]}]; // need setter for shape property
    return content;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self updateUI];
    
    UIImage *cardTop = [UIImage imageNamed:@"setCardSelected"];
    UIImage *cardBack = [UIImage imageNamed:@"setCard"];

    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:fon]];
    for (UIButton *button in self.arrayOfButtons)
    {
        [button setBackgroundImage:cardTop forState:UIControlStateSelected];
        [button setBackgroundImage:cardBack forState:UIControlStateNormal];
        [button setBackgroundImage:cardBack forState:UIControlStateDisabled];
    }
}

-(void)updateUI // метод обновления интерфейся для синхронизации изменений в модели
{
    int indexOfCardButton;
    for (UIButton *cardButton in self.arrayOfButtons) // проходим по массиву кнопок-кард
    {
        SetCard *card = [self.game cardAtIndex:[self.arrayOfButtons indexOfObject:cardButton]];
        
        indexOfCardButton = [self.arrayOfButtons indexOfObject:cardButton];  // получаем карту для каждой кнопки
        
        [cardButton setAttributedTitle:[self contentOfCardAtIndex:indexOfCardButton] forState:UIControlStateNormal];

        [cardButton setAttributedTitle:[self contentOfCardAtIndex:indexOfCardButton] forState:UIControlStateSelected];
        [cardButton setAttributedTitle:[self contentOfCardAtIndex:indexOfCardButton] forState:UIControlStateSelected | UIControlStateDisabled];// устанавливаем Title = полученной карте из модели для состояний
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = card.isUnPlayable ? 0.2 : 1.0;
        
     
        
    }
    
    NSLog(@"Numder of cards = %d",indexOfCardButton + 1);
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.storyLable.attributedText = [self.game.story lastObject];
    
    if (self.game.endOfTheGame)
    {
        UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"End of the Game" message:[NSString stringWithFormat:@"%@",self.scoreLable.text] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [newGameMessage show];
        
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
        self.deck = [[SetDeck alloc]init];
        self.game = [[SetGame alloc]initWhitCardCount:24 usingDeck:self.deck];
        [self updateUI];
    }
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.arrayOfButtons indexOfObject:sender]]; // модель занимается переворачиванием
    [self updateUI]; // каждай раз как переворачиваем карту надо обновить интерфейс

    
}
@end
