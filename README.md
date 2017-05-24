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
[巧哥的观点](http://www.infoq.com/cn/articles/rethinking-mvc-mvvm)有点老，但是辩证的看，还是能有收获
[我对MVC的理解](http://www.jianshu.com/p/6602b4b40712)个人观点，欢迎讨论
[喵神翻译的一本书](https://www.gitbook.com/book/kevinhm/functionalreactiveprogrammingonios/details)上面的两张图也出自这里

4. 介绍两者的文章、博客、书籍很多，这里不多说，直接上[代码](https://github.com/lych0317/MVVMDemo)
> 介绍一下这个小需求:对，就这么简单
> 1. 从服务端返回User数据（包括：id(int)、name(string)、age(int)、university(string)、sex(int)）
> 2. 在界面上展示User数据（包括：姓名(string)、大学(string)、性别(string)）
> 3. 要求性别转换（1->男；2->女），大学最长显示三个字符
