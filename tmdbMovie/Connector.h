//
//  Connector.h
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Connector : UIViewController
//------movie--//
@property (strong,nonatomic)NSString *IdBeingPassed;
@property (strong,nonatomic)NSString *movieNameBeingPassed;
@property (strong,nonatomic)NSString *posterPathBeingPassed;
@property(strong,nonatomic)NSNumber *voteBeingPassed;
@property(strong,nonatomic)NSString *desBeingPassed;
//--------Actor----//
@property(strong,nonatomic)NSString *bioBeingPassed;
@property(strong,nonatomic)NSString *posterActorBeingPassed;
@property(strong,nonatomic)NSNumber *actorID;
@end
