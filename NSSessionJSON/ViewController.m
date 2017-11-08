//
//  ViewController.m
//  NSSessionJSON
//
//  Created by Student P_10 on 08/11/17.
//  Copyright © 2017 vaishnavifelix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.namearray = [[NSMutableArray alloc]init];
    self.emailarray = [[NSMutableArray alloc]init];
    
    NSString *str = @"https://api.github.com/repositories/19438/commits";
    NSLog(@"%@",str);
    NSURL *myurl = [NSURL URLWithString:str];
    NSLog(@"%@",myurl);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //NSLog(@"%@",session);
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:myurl completionHandler:^(NSData * _Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error)
        {
            NSHTTPURLResponse *myresponse = (NSHTTPURLResponse *)response;
            
            if(myresponse.statusCode==200)
            {
                if(data)
                {
                    NSLog(@"Data Found");
                    NSLog(@"Data is %@",response);
                    
                    NSArray *myarray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    
                    if(error)
                    {
                        NSLog(@"Error :%@",error.localizedDescription);
                    }
                    else
                    {
                        NSLog(@"Myarray : %@",myarray);
                        for(NSDictionary *tempcommit in myarray)
                        {
                            NSDictionary *commitdic = [tempcommit valueForKey:@"commit"];
                            
                            NSLog(@"CommitDic : %@",commitdic);
                            
            
                            NSDictionary *authordic = [commitdic valueForKey:@"author"];
                                
                            
                                    NSString *nm = [authordic valueForKey:@"name"];
                                    
                                    [_namearray addObject:nm];
                                    
                                    NSString *em = [authordic valueForKey:@"email"];
                                    
                                    [_emailarray addObject:em];
                            
                            }
                        
                                }
                        NSLog(@"Output :   %@  %@", _namearray,_emailarray );
                            }
                            }
                else
                {
                    NSLog(@"Data not found");
                }
            
        
                
            
        
}];
[dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
