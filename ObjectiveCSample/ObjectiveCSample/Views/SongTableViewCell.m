//
//  SongTableViewCell.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "SongTableViewCell.h"
#import "SongDisplay.h"

@implementation SongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplay:(nullable SongDisplay *)display {

    [self.titleLabel setText:display.title];
    [self.artistLabel setText:display.subtitle];
    
    // TODO load image
//    [self.coverImageView setImage:nil];
    [self.coverImageView setBackgroundColor:UIColor.darkGrayColor];
}

@end
