# MVVMDemo
学习MVVM

欢迎访问我的[博客](http://www.jianshu.com/u/84694439bd88)，共同学习交流

> 不确定，MVVM是不是为了解决MVC中臃肿的C，
> 但是，它的确完美解决掉了MVC中臃肿的C。

1. MVC
C同时拥有M和V，作为两者之间的桥梁，注定要导致它的臃肿。
![mvc](http://upload-images.jianshu.io/upload_images/3246932-232c58e5ce39d5d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. MVVM
单向拥有，完全解耦，自然简单、便于维护、容易理解
![mvvm](http://upload-images.jianshu.io/upload_images/3246932-15e7ca8bdd7652f7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 参考文献
  * [巧哥的观点](http://www.infoq.com/cn/articles/rethinking-mvc-mvvm)有点老，但是辩证的看，还是能有收获
  * [我对MVC的理解](http://www.jianshu.com/p/6602b4b40712)个人观点，欢迎讨论
  * [喵神翻译的一本书](https://www.gitbook.com/book/kevinhm/functionalreactiveprogrammingonios/details)上面的两张图也出自这里
4. 介绍两者的文章、博客、书籍很多，这里不多说，直接上[代码](https://github.com/lych0317/MVVMDemo)
  > 介绍一下这个小需求:对，就这么简单
  > 1. 从服务端返回User数据（包括：id(int)、name(string)、age(int)、university(string)、sex(int)）
  > 2. 在界面上展示User数据（包括：姓名(string)、大学(string)、性别(string)）
  > 3. 要求性别转换（1->男；2->女），大学最长显示三个字符

  * User
  
    ```
    #import <Foundation/Foundation.h>
       
    @interface User : NSObject
       
    @property (nonatomic, assign) NSInteger identifier;
    @property (nonatomic, copy) NSString *name;
    @property (nonatomic, assign) NSInteger age;
    @property (nonatomic, copy) NSString *university;
    @property (nonatomic, assign) NSInteger sex;
       
    @end
    ```
       
    ```
    #import "User.h"
       
    @implementation User
       
    @end
    ```
   
  * Model
  
    ```
    #import <Foundation/Foundation.h>
    #import "User.h"
    
    @interface Model : NSObject
    
    @property (nonatomic, assign, readonly, getter=isLoading) BOOL load;
    @property (nonatomic, strong, readonly) User *user;
    
    - (void)fetchUser;
    
    @end
    ```
    
    ```
    #import "Model.h"
    
    @interface Model ()
    
    @property (nonatomic, strong) User *user;
    @property (nonatomic, assign, getter=isLoading) BOOL load;
    
    @end
    
    @implementation Model
    
    - (void)fetchUser
    {
        // 模拟网络请求，或者数据库访问
        self.load = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            User *user = [[User alloc] init];
            user.identifier = 1;
            user.name = @"李远超";
            user.age = 28;
            user.university = @"山东工商学院";
            user.sex = 1;
            self.load = NO;
            self.user = user;
        });
    }
    
    @end
    ```

  * ViewModel
  
    ```
    #import <Foundation/Foundation.h>
    
    @interface ViewModel : NSObject
    
    @property (nonatomic, copy, readonly) NSString *name;
    @property (nonatomic, copy, readonly) NSString *university;
    @property (nonatomic, copy, readonly) NSString *sex;
    @property (nonatomic, assign, readonly, getter=isLoading) BOOL load;
    
    - (void)fetchUser;
    
    @end
    ```
    
    ```
    #import "ViewModel.h"
    #import "Model.h"
    #import <ReactiveObjC.h>
    
    @interface ViewModel ()
    
    @property (nonatomic, copy) NSString *name;
    @property (nonatomic, copy) NSString *university;
    @property (nonatomic, copy) NSString *sex;
    @property (nonatomic, assign, getter=isLoading) BOOL load;
    
    @property (nonatomic, strong) Model *model;
    
    @end
    
    @implementation ViewModel
    
    - (instancetype)init
    {
        self = [super init];
        if (self) {
            _model = [[Model alloc] init];
    
            RAC(self, name) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
                return user.name;
            }];
            RAC(self, university) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
                NSString *university = user.university;
                if (user.university.length > 3) {
                    university = [university substringToIndex:3];
                }
                return university;
            }];
            RAC(self, sex) = [[RACObserve(_model, user) skip:1] map:^id _Nullable(User *user) {
                return user.sex == 1 ? @"男" : @"女";
            }];
            RAC(self, load) = [RACObserve(_model, load) skip:1];
        }
        return self;
    }
    
    - (void)fetchUser
    {
        [self.model fetchUser];
    }
    
    @end
    ```
    
  * ViewController
  
    ```
    #import <UIKit/UIKit.h>
    
    @interface ViewController : UIViewController
    
    @end
    ```
    
    ```
    #import "ViewController.h"
    #import "ViewModel.h"
    #import <ReactiveObjC.h>
    
    @interface ViewController ()
    
    @property (nonatomic, strong) ViewModel *viewModel;
    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
    @property (weak, nonatomic) IBOutlet UILabel *universityLabel;
    @property (weak, nonatomic) IBOutlet UILabel *sexLabel;
    @property (weak, nonatomic) IBOutlet UILabel *loadLabel;
    
    @end
    
    @implementation ViewController
    
    - (void)viewDidLoad {
        [super viewDidLoad];
        self.viewModel = [[ViewModel alloc] init];
    
        RAC(self.nameLabel, text) = RACObserve(self.viewModel, name);
        RAC(self.universityLabel, text) = RACObserve(self.viewModel, university);
        RAC(self.sexLabel, text) = RACObserve(self.viewModel, sex);
        RAC(self.loadLabel, text) = [RACObserve(self.viewModel, load) map:^id _Nullable(NSNumber *value) {
            return [value boolValue] ? @"loading" : @"normal";
        }];
    }
    
    - (IBAction)fetchDataAction:(UIButton *)sender
    {
        [self.viewModel fetchUser];
    }
    
    @end
    ```
