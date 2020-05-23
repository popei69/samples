//
//  Song.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "Song.h"

@implementation Song

- (instancetype)initWithTitle:(NSString*)title artistName:(NSString*)artistName albumCover:(NSString*)albumCover
{
    self = [super init];
    if (self) {
        self.title = title;
        self.artistName = artistName;
        self.albumCover = albumCover;
    }
    return self;
}

- (nullable NSURL*)albumCoverUrl {
    return [NSURL URLWithString:self.albumCover];
}

@end
