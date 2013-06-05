//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Lexor on 04.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#define DEFAULT_FACE_CARD_SCALE_FACTOR 1.0

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}


 // следует переопределить этот метод если мы хотим сделать кастомную "отрисовку"
 // An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 // Drawing code
    [super drawRect:rect];
    
    if (self.faceUp)
    {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        } else
        {
          NSLog(@"ERROR: no faceImage %@%@",[self rankAsString], self.suit)  ;
        }
       // [self drawCorners];
    } else {
        [[UIImage imageNamed:@"cardback.png"] drawInRect:self.bounds];
    }
    
    
    
}

-(NSString*)rankAsString
{
    
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}
-(void)drawCorners // отрисовка масти
{
    NSMutableParagraphStyle *paragrafStyle = [[NSMutableParagraphStyle alloc]init]; // класс который отвечает за различные выравнимания при использовании AtributedString
    paragrafStyle.alignment = NSTextAlignmentCenter; // задаем выравнивание по центру
    
    
    UIFont *font = [UIFont systemFontOfSize:self.bounds.size.width * 0.2]; // задаем размер шривта который равен 20% от ширины карты
    NSAttributedString *cornerString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString],self.suit] attributes:@{NSParagraphStyleAttributeName : paragrafStyle , NSFontAttributeName : font}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake(2.0, 2.0);
    textBounds.size = cornerString.size;
    [cornerString drawInRect:textBounds];
    
    [self pushContextAndRotateUpsideDown];
    [cornerString drawInRect:textBounds];
    
    [self popContext];
     
    
}


-(void)pushContextAndRotateUpsideDown // создаем 2ю метку карты (нижний правый угол)
{
    CGContextRef context = UIGraphicsGetCurrentContext(); // получаем текущий context
    CGContextSaveGState(context); // создается копия текущего граффического состояния  и помещается на граф. сост. контекста ?
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height); // смещаем систему координат
    CGContextRotateCTM(context, M_PI); // поворачиваем систему координат на 180
}

-(void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext()); // возвращаем контекс в исходное состояние
}

-(void)setRank:(NSUInteger) rank
{
    _rank = rank;
    [self setNeedsDisplay]; // метод который вызывает перерисовку view
}

-(void) setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(void)setup
{
    //do initialization here
    self.rank = 12;
    self.suit = @"♥";
    self.faceUp = YES;
}

-(void)awakeFromNib  // метод который вызывается автоматически после инициализации объектов из NIB-файла,
{                    //используется для конфигурирования объекта после создания аутлетов и actions
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}


@end
