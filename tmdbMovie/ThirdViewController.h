//
//  ThirdViewController.h
//  tmdbMovie
//
//  Created by Rafay on 11/9/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connector.h"
@interface ThirdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *lblBio;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceofBirth;
@property(strong,nonatomic)Connector *connectorClass;

@end
