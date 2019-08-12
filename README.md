# RAC-MVVM--Demo
学习一下RAC + MVVM开发模式，写了一个Demo


简单功能介绍，[简书地址](https://www.jianshu.com/p/f7f6051ed6fc)

/**在LoginView里:**/

* 1.用RAC把输入账号和输入密码的TextField和ViewModel的属性(accountStr,passwordStr)进行绑定。(实时监测信号变化)

* 2.用RAC监听(iconUrlStr)根据输入不同账号内容来显示不同头像。(输入内容只有 0, 012, 0123, 01234 这四种图片对应)

* 3.用RAC监听登录按钮可编辑状态。 按钮可点击事件。（事件响应，RACCommand只需执行 - (RACSignal *)execute:(id)input 方法就可以开始并执行）\n\n4.用RAC监听菊花加载显示。(skip:1 方法是跳过第一步的意思)

/**在LoginViewModel里面:**/

* 1.VM里面头像图片的属性(iconUrlStr)和输入账号的TextField的输入框进行映射绑定。（功能：对图片URL进行处理）

* 2.VM里检测属性(accountStr,passwordStr)，用来判断登录按钮是否可以高亮或点击。

* 3.VM里面属性(loginStatusSubject)用来检测登录的状态。

* 4.RACCommand用来实现请求的响应，具体请查看代码。

/**Login整理功能:**/

* 1.输入框，输入 0, 012, 0123, 01234 这四种数字头像一一对应。

* 2.账号密码判断，必须都为01234，才可以登录成功。

* 3.俩个输入框必须都有输入才可以点击登录按钮。

* 4.登录中显示登录状态。菊花加载显/隐。

/**个人信息页面也是通过RAC绑定，监听属性实现，具体详看代码**/

[简书地址地址](https://www.jianshu.com/p/f7f6051ed6fc)
