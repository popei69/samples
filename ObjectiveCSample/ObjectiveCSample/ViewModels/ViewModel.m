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
@property (nonatomic, strong) NSArray<SongDisplay *> *items;

@end

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = @[];
        self.fetcher = [[SongFetcher alloc] initWithClient:[[NetworkService alloc] init] parser:[[SongParser alloc] init]];
    }
    return self;
}

- (void)getSongsWithSuccess:(void (^)(NSArray<SongDisplay *> * _Nonnull))successCompletion error:(void (^)(NSError * _Nonnull))errorCompletion {
    
    __weak ViewModel *weakSelf = self;
    [self.fetcher fetchSongsWithSuccess:^(NSArray<Song *> *songs) {
        
        NSMutableArray * items = [[NSMutableArray alloc] init];
        for (Song *song in songs) {
            [items addObject:[[SongDisplay alloc] initWithSong:song]]; 
        }
        [weakSelf setItems:items];
        successCompletion(items);
    } error:errorCompletion];
}

- (NSUInteger)numberOfItems {
    return self.items.count;
}

- (NSUInteger)numberOfSections {
    return 1;
}

- (SongDisplay *)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.items.count) {
        return nil;
    }
    return self.items[indexPath.row];
}
@end
