//
//  CardView.m
//  SuperCard
//
//  Created by Lexor on 25.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];  // перерисовка view после изменения
    NSLog(@"CARD IS FACe UP");
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define CornerRadius 10.0

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width/CornerRadius];
    
    [roundedRect addClip];// ? каким то образом отделяет и делает невидимыми части выходящие за пределы roundedRect
    
    [[UIColor whiteColor]setFill]; // устанавливаем цвет для последующей операции заливки
    UIRectFill(self.bounds); // C функция которая заливает цветом заданную область
    
//    if (self.faceUp)
//    {
//        roundedRect.lineWidth = self.bounds.size.width/100 * 4;
//        [[UIColor colorWithRed:1 green:0.3 blue:0.6 alpha:1]setStroke];
//        [roundedRect stroke];
//
//        NSLog(@"FACE UP IN CARD view");
//    }
//    else
//    {
//        [[UIColor blackColor]setStroke]; // устанавливаем цвет для "границы"
//        [roundedRect stroke]; // отрисовка "границы"
//    }
    
    [[UIColor blackColor]setStroke]; // устанавливаем цвет для "границы"
    [roundedRect stroke]; // отрисовка "границы"

}

-(void)setup
{
    //do initialization here
}

-(void)awakeFromNib  // метод который вызывается автоматически после инициализации объектов из NIB-файла,
{                    //используется для конфигурирования объекта после создания аутлетов и actions
    [self setup];
}


@end
