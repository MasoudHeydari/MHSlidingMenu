# MHSlidingMenu
MHSlidingMenu is cool component you can use in your projects.
If you are intrested in to implement `MHSlidingMenu` like Uber or Twitte, you can follow these below easy steps to use this cool feature in your projects:

## Usage
* Copy and paste files of `Controller/Base` on your project.
* Use `MHBaseSlidingController` controller as your `rootViewController` in `AppDelegate.swift`. use below function to configure rootViewController.

```swift
    private func setupApplication() {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return }
        
        let baseController = PrimaryViewController()
        let menuController = MenuController()
        
        let config = MHSlidingCofig(direction: .RTL, mode: .slideIn, statusbarStyleWhenMenuIsOpen: .default, menuWidth: 310)
        
        
        let rootViewController = MHBaseSlidingController(baseController: baseController, menuController: menuController, config: config)
        window.makeKeyAndVisible()
        window.rootViewController = rootViewController
        window.backgroundColor = .white
    }
```
**baseController** is a controller you want to show it when app run as first time.

**menuController** is a controller you want to show it as `Menu` in left/right side.  

**config** is a instance of `MHSlidingCofig` has these below properies:

  - **`direction:`** threre two direction you can use. left to right OR right to left.
  
  - **`mode:`** threre two modes you can use. slideIn OR slidOut.
  
  - **`statusbarStyleWhenMenuIsOpen:`** style that you prefer for your status bar when menu is open.
  
  - **`menuWidth:`** an obvious propertiy :D
  

> *`NOTE:`* Don't forget to call `setupApplication()` in `AppDeligate.swift` file.

* In `MHBaseSlidingController` class there are three public functions you can use them.

  - `showNewViewController(_ newController: UIViewController, completion: (() -> Void)? = nil)`
        show new controller in main screen.
        
  - `openMenu()`
        open the menu.
        
  - `closeMenu()`
        close the menu.
       
To use these functions in your controllers, follow below guide:

```swift
   guard let rootViewController = (UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController) else { return }
   rootViewController.openMenu()
```

Or

```swift
   guard let rootViewController = (UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController) else { return }
   rootViewController.showNewViewController(NewViewController())
```
         
 #
* `MHBaseSlidingController` class has a `delegate` property that has four functions:
  
 
 ```swift
  @objc protocol BaseSlidingControllerDelegate: class {
    func menuDidOpen()
    func menuDidClose()
    
    func menuWillOpen()
    func menuWillClose()
  }
  ```
  
  Every controller can conform `MHBaseSlidingControllerDelegate` protocol and to set `delegate` property of `MHBaseSlidingController` class, use below code:
  
  ```swift
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? MHBaseSlidingController else { return }
    rootViewController.delegate = self
  ```
  
  ## Screenshots
  
  <img src="https://github.com/MasoudHeydari/MHSlidingMenu/blob/master/assets/MHSlidingMenu.gif" width="350"/>
  <img src="https://github.com/MasoudHeydari/MHSlidingMenu/blob/master/assets/screen1.png" width="400" />
  <img src="https://github.com/MasoudHeydari/MHSlidingMenu/blob/master/assets/screen2.png" width="400"/>
  
  ## Contant Me
  * Masoud Heydari 
    - *Gmail* - m.heydari4883@gmail.com
    - *Telegram* - [@m_heydari4883](https://t.me/m_heydari4883)
  
  
  
  
  

