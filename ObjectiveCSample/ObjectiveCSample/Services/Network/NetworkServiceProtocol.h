//
//  NetworkServiceProtocol.h
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef NetworkServiceProtocol_h
#define NetworkServiceProtocol_h

@protocol NetworkServiceProtocol <NSObject>

- (void)getUrl:(NSURL*)url withSuccess:(void (^)(NSData *response))successCompletion error:(void (^)(NSError * error))errorCompletion;

@end


#endif /* NetworkServiceProtocol_h */
