//
//  SongFetcher.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "SongFetcher.h"


@interface SongFetcher()

@property (nonatomic, strong) id<SongParserProtocol> parser;
@property (nonatomic, strong) id<NetworkServiceProtocol> networkClient;

@end

@implementation SongFetcher

- (instancetype)initWithClient:(nonnull id<NetworkServiceProtocol>)client parser:(id<SongParserProtocol>)parser 
{
    self = [super init];
    if (self) {
        self.parser = parser;
        self.networkClient = client;
    }
    return self;
}



- (void)fetchSongsWithSuccess:(void (^)(NSArray<Song *> *))successCompletion error:(void (^)(NSError *))errorCompletion { 
    
    NSURL * url = [NSURL URLWithString:@"https://mysongs..."];
    
    __weak SongFetcher * weakSelf = self;
    void (^networksResponse)(NSData *) = ^(NSData *data){ 
        [weakSelf.parser parseSongs:data withSuccess:successCompletion error:errorCompletion];
    };
    
    // TODO: improve error handling at each steps
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [weakSelf.networkClient getUrl:url withSuccess:networksResponse error:errorCompletion];
    });
}

@end
