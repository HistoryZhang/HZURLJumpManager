HZURLJumpManager
================

###This is something interested about NSURL and ViewController Jump.

We can push a viewcontroller like this:

```
NSURL *url = [NSURL URLWithString:@"hzjump://go?url=Test"];
            [[HZURLJumpManager share] pushToURL:url fromNavigationController:self.navigationController];
```

Or present like this:

```
[[HZURLJumpManager share] presentToURLString:@"hzjump://go?url=Test" fromViewController:self];
```

If you like,just push like this:

```
[[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=Test&push=yes" fromController:self.navigationController];
```

You just need do follow steps:

* Create a class Subclass of `HZBaseViewController` like `HZTestViewController`
* Create a new ViewController in Storyboard, set the `Custom Class` be `HZTestViewController` and the `Storyboard ID` like `kTestVcIdf`
* Add a dictionary in `HZURLJumpConfig.plist` with follow key and value

Key|Value
:---:|:---:
hz.module.controller.name | HZTestViewController
hz.module.name | Test
hz.module.sb.idf | kTestVcIdf
hz.module.sb.name | Main

* Use the URL protocol to jump the ViewController.You should set the url like this:`hzjump://go?url=Test&push=yes&key=value`.

If you use the `push` or `present` function, ignore `push=yes`;

If you use the `jump` function, set `push=yes` for `push` action, otherwise for `present` action;

`key=value` will be in the `moduleObject` dictionary;

ps:This project is based on the `Storyboard` and `ARC`.