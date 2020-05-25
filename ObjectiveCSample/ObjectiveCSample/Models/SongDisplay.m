//
//  SongDisplay.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 25/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "SongDisplay.h"
#import "Song.h"

@interface SongDisplay()

@property (nonatomic, readwrite, nullable) NSString *title;
@property (nonatomic, readwrite, nullable) NSString *subtitle;
@property (nonatomic, readwrite, nullable) UIImage *coverImage;
@property (nonatomic, readwrite, nullable) NSString *coverUrlString;

@end

@implementation SongDisplay


- (instancetype)initWithSong:(Song*)song {
    self = [super init];
    if (self) {
        self.title = song.title;
        self.subtitle = song.artistName;
        self.coverUrlString = song.albumCover;
    }
    return self;
}
@end
