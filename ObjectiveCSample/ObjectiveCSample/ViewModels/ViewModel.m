//
//  ViewModel.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "ViewModel.h"

#import "SongParser.h"
#import "SongFetcher.h"
#import "NetworkService.h"

@interface ViewModel()

@property (nonatomic, strong) id<SongFetcherProtocol> fetcher;
@property (nonatomic, strong) NSArray<Song *> *songs;

@end

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        ;
        ;
        self.fetcher = [[SongFetcher alloc] initWithClient:[[NetworkService alloc] init] parser:[[SongParser alloc] init]];
    }
    return self;
}

- (void)getSongsWithSuccess:(void (^)(NSArray<Song *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    
    __weak ViewModel *weakSelf = self;
    [self.fetcher fetchSongsWithSuccess:^(NSArray<Song *> *songs) {
        [weakSelf setSongs:songs];
        successCompletion(songs);
    } error:errorCompletion];
}

- (NSUInteger)numberOfItems {
    return self.songs.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (nullable Song *)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.songs.count) {
        return nil;
    }
    return self.songs[indexPath.row];
}
@end
