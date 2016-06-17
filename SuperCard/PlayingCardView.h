//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Devesh Shetty on 17/06/16.
//  Copyright © 2016 Devesh Shetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;
@end
