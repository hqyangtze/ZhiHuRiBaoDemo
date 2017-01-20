# ZhiHuRiBaoDemo
借助网上公开的知乎日报API,自己模仿知乎日报APP写了首页和详情页，还待完善...

<div>
项目使用到的第三方库目前有：
<br>
<img src = "./Des Images/third_part_frameworks.png">
<ol>
<li>网络使用<strong>AFNetworking</strong>,加上猿题库开源的<strong>YTKNetwork</strong>，使得具体设计业务请求的代码比较简洁；</li>
<li>JSON转Model使用的是<strong>YYModel</strong>,其使用十分方便，特别是对于我这样的小项目，具体的使用看框架的介绍已经足够；</li>
<li>上垃加载，下拉加载刷新我使用的是<strong>MJRefresh</strong>,对于具体的样式，项目中是对UIScrollView进行扩展，这样保证加载样式的一致性同时减少重复代码；具体可以参照UIScrollView+Refresh.h/m文件</li>
<li>关于图片加载肯定是使用<strong>SDWebImage</strong>,就不多讲啦</li>
<li>加载提示，我选用的是<strong>MBProgressHUD</strong>,这个库本来就是需要自己去定义风格的，感觉我自定义的风格并不好。</li>
<li>关于界面控件的布局，一般小的子模块控件，项目中我采取的是xib，同时对于模块间的布局我使用的是<strong>Masonry</strong>,之前在项目开发中，我一直还没有使用过<strong>Masonry</strong>,这次主要是熟悉；</li>
</ol>
</div>
整个项目相对而言来讲是比较简单的，但是，我争取认真对待每一行代码。