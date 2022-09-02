//
//  ViewController.swift
//  Vk_study project
//
//  Created by Victor Garitskyu on 02.09.2022.
//

import UIKit

class LoginFormController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        // клик по любому месту scrollView для скрытия клавиатуры - Жест нажатия
        let hideKeyboadGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboadGesture)
        // * делегаты для переноса фокуса на следующее поле ввода
        self.loginInput.delegate = self
        self.passwordInput.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //Когда пропадает клавиатура
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleText: UILabel!
    
    
    // MARK: - Functions
    // появляется клавиатура
    @objc func keyboardWillShow(notification: Notification) {
        //определяем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue) .cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Отсут снизу UIScrollView равный клавиатуре
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    //Убираем отступ, когда клавиатура исчезает
    @objc func keyboardWasHide(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    //клик в любом  месте scrollView для скрытия клавиатуры
    @objc func hideKeyboard(){
        scrollView.endEditing(true)
    }
    
    // * переход на следующий TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginInput {
            passwordInput.becomeFirstResponder()
        } else {
            loginButtonPressed(self)
        }
        return true
    }
    // MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard loginInput.text == "admin" && passwordInput.text == "admin" else {
            // Создаем контроллер для ошибки
            let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль!", preferredStyle: .alert)
            // Создаем и добавляем кнопку для UIAlertController
            let action = UIAlertAction(title: "Повторить", style: .cancel, handler: nil)
            alert.addAction(action)
            // Показываем UIAlertController
            present(alert, animated: true, completion: nil)
            return
        }
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    
    
    @IBAction func segueToLoginController​(segue:UIStoryboardSegue) {
        // проверка и действия
    }
}

