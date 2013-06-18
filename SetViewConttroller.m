//
//  SetViewConttrollerViewController.m
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "SetViewConttroller.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "SetCardCollectionViewCell.h"

@interface SetViewConttroller ()

@property (nonatomic) SetDeck *deck;
@property (nonatomic) NSInteger startingCardCount;

@end

@implementation SetViewConttroller

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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    SetCard *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}


-(void)updateCell:(UICollectionViewCell *)cell usingCard:(SetCard *)card
{
    
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]])
    {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]])
        {
            SetCard *setCard = (SetCard *)card;
            setCardView.amount = setCard.amount;
            setCardView.shape = setCard.shape;
            setCardView.shade = setCard.shade;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.faceUp;
            setCardView.alpha = setCard.isUnPlayable ? 0.3 : 1.0 ;
            
        }
    }
}



-(NSInteger)startingCardCount
{
    return 12;
}

-(SetGame *)game
{
    if (!_game)
    {
        _game = [[SetGame alloc]initWhitCardCount:self.startingCardCount usingDeck:self.deck];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self updateUI];
}

-(void)updateUI // метод обновления интерфейся для синхронизации изменений в модели
{
    // Update code using collectionViewCell
        
        for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
        {
            NSIndexPath *path = [self.cardCollectionView indexPathForCell:cell];
            SetCard *card = [self.game cardAtIndex:path.item];
            [self updateCell:cell usingCard:card];
            
            if (card.isUnPlayable)
            {
                [self.game.cards removeObjectAtIndex:path.item];
                
                if (self.deck.cards.count != 0)
                {
                    [self.game.cards insertObject:[self.deck drawRandomCard] atIndex:path.item];
                    [self updateUI];
                }
                else
                {
                    // Delete cell from collectionView
                    //[self.cardCollectionView deleteItemsAtIndexPaths:@[path]];
                }
                
                // need animatio
                
            }
        }
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
    if ([self.game showSet].count == 0)
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
        self.game = [[SetGame alloc]initWhitCardCount:12 usingDeck:self.deck];
        [self updateUI];
    }
}


- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *index = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    
    if (index)
    {
        [self.game flipCardAtIndex:index.item]; // модель занимается переворачиванием
        [self updateUI]; // каждай раз как переворачиваем карту надо обновить интерфейс
    }
    
    
}
- (IBAction)showSet:(UIButton *)sender
{
    if ([self.game showSet].count == 0)
    {
        UIAlertView *newGameMessage = [[UIAlertView alloc]initWithTitle:@"End of the Game" message:[NSString stringWithFormat:@"%@",self.scoreLable.text] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [newGameMessage show];
    }
    else
    {
        for (NSNumber *number in [self.game showSet])
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:[number intValue] inSection:0];
            UICollectionViewCell *cell = [self.cardCollectionView cellForItemAtIndexPath:path];
            NSLog(@"%@",path);
            if ([cell isKindOfClass:[SetCardCollectionViewCell class]])
            {
                SetCardCollectionViewCell *setCell = (SetCardCollectionViewCell *)cell;
                setCell.setCardView.faceUp = YES;
            }

        }

    }
}

@end
