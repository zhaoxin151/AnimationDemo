/*
 * Copyright (c) 2014-2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
        completion()
    }
}

class ViewController: UIViewController {

  // MARK: IB outlets

  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!

  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!

  // MARK: further UI

  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]

  var statusPosition = CGPoint.zero

  // MARK: view controller methods
  override func viewDidLoad() {
    super.viewDidLoad()

    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true

    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)

    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)

    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
    
//    animationContainerView = UIView(frame: view.bounds)
//    animationContainerView.frame = view.bounds
//    view.addSubview(animationContainerView);
    statusPosition = status.center
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    heading.center.x -= view.bounds.width
    username.center.x -= view.bounds.width
    password.center.x -= view.bounds.width
    
    //设置云彩的alpha位0.0
    cloud1.alpha = 0.0
    cloud2.alpha = 0.0
    cloud3.alpha = 0.0
    cloud4.alpha = 0.0
    
    //button
    loginButton.center.y += 30
    loginButton.alpha = 0.0
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    UIView.animate(withDuration: 0.5) {
      self.heading.center.x += self.view.bounds.width
    }
  
//    //延迟0.5秒
//    UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
//       self.username.center.x += self.view.bounds.width
//    }, completion:nil)
//
//    //.repeat 重复动画，从一直起始位置开始
//    //.autoreverse 到结束位置后，从结束位置范围到起始位置。如果跟.repeat一起，来回动画。如果自己的话，从结束位置范围起始位置，再在结束位置出现
//    //.cureEaseIn 没有加速度和减速度 ,匀速走
//    //.curveEaseIn 有加速度，在匀速
//    //.curveEaseOut 有减速度
//    //.curveEaseInOut 先加速再匀速再减速
//    //password 延迟0.3秒
//    UIView.animate(withDuration: 0.5, delay: 0.4, options:[], animations: {
//      self.password.center.x += self.view.bounds.width
//    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
      self.password.center.x += self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
      self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    //云彩的动画
    UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
      self.cloud1.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
      self.cloud2.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
      self.cloud3.alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 1.1, options: [], animations: {
      self.cloud4.alpha = 1.0
    }, completion: nil)
    
    //button
    //usingSpringWithDamping参数来设置一个阻尼的动画，从0.0-1.0, 参数值越小， 弹性值越大
    //initialSpringVelocity控制动画的初始速度。代表弹簧动能的大小，快慢
    UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 0.1, initialSpringVelocity: 10.0, options: [], animations: {
      self.loginButton.center.y -= 30.0
      self.loginButton.alpha = 1.0
    }, completion: nil)
    
    
    //Transform
    //create new view
//    let newView = UIImageView.init(image: UIImage.init(named: "banner"))
//    newView.center = animationContainerView.center
    
    //add the new view via transition
    //transitionFlipFromBottom 从底部翻转过来的视图
    //transitionFlipFromLeft  从左边翻转
    //transitionFlipFromRight 从右边翻转
    //transitionCurlUp  //从上面往上翻页
    //transitionCurlDown  //从下面往上翻页
    //transitionCrossDissolve  //渐渐出来
    //transitionFlipFromTop   //从上面出来
//    UIView.transition(with: animationContainerView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
//        self.animationContainerView.addSubview(newView)
//    }, completion: {_ in
//    })
    
    //remove the view via transition ,父view的转换 remove 子view
//    UIView.transition(with: self.animationContainerView, duration: 3.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
//        newView.removeFromSuperview()
//    }, completion: nil)

    
    //hide the view via transition 子view自己转换，hide
//    UIView.transition(with: newView, duration: 3.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
//        newView.isHidden = true
//    }, completion: nil)
    
    //两个平级之间的view的转换
//    UIView.transition(from: oldView, to: newView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], completion: nil)
    
  }

  // MARK: further methods

  @IBAction func login() {
    view.endEditing(true)
    
    //点击button，给个回复
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80.0
    }, completion: { _ in
      self.showMessage(index: 0)
    })
    
    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y += 60.0
      self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
      
      //添加进度指示器
//      self.spinner.center = CGPoint(x: 40.0,
//                                    y: self.loginButton.frame.size.height/2
//      )
//      self.spinner.alpha = 1.0
        
        self.spinner.center = CGPoint(x: -20.0,
                                      y: 16.0
        )
        self.spinner.alpha = 0.0
    }, completion: nil)
    
  }

  // MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextField = (textField === username) ? password : username
    nextField?.becomeFirstResponder()
    return true
  }
    
    //MARK: Private Method
    func showMessage(index: Int) -> Void {
        label.text = messages[index]
        
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }, completion: { _ in
            delay(2.0, completion: {
                if index < self.messages.count - 1{
                    self.removeMessage(index: index)
                }else {
                    //reset form
                }
            })
        })
    }

    //删除message
    func removeMessage(index: Int) -> Void {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
        }, completion: { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            
            self.showMessage(index: index+1)
        })
    }
    
    func resetForm() -> Void {
        UIView.transition(with: self.status, duration: 0.2, options: [.curveEaseOut, .transitionCurlUp], animations: {
            self.status.isHighlighted = true
            self.status.center = self.statusPosition
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
                
            }, completion: nil)
        })
    }
}
