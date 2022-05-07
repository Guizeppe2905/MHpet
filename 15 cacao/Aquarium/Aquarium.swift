//
//  HeadingsAnimation.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 28.04.2022.
//
// swiftlint: disable: type_body_length
// swiftlint: disable: colon
// swiftlint: disable: function_body_length
// swiftlint: disable: cyclomatic_complexity
// swiftlint: disable: legacy_random
import UIKit
import Foundation

class AquariumViewController: UIViewController {
    var numberOfFishes: Int = 0
    let alertButton = UIButton()
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 300, y: 80, width: 100, height: 100))
        button.setTitle("Играть", for: .normal)
        button.backgroundColor = .systemFill
        button.contentMode = .center
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    private lazy var label1: UILabel = {
      let label1 = UILabel(frame: CGRect(x: 30, y: 730, width: 200, height: 40))
        label1.text = "#пойманные рыбы: \(numberOfFishes)"
        label1.textColor = .systemFill
        label1.contentMode = .bottomLeft
        label1.layer.cornerRadius = 10
        label1.textColor = .white
        label1.font = UIFont.boldSystemFont(ofSize: 16)
        return label1
     }()
    lazy var fish: UIImageView = {
        let image = UIImage(named: "fish")
        let view = UIImageView(image: image)
        view.frame = CGRect( x: 50, y: 80, width: 100, height: 100)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var fish1: UIImageView = {
        let image1 = UIImage(named: "fish1")
        let fish1 = UIImageView(image: image1)
        fish1.frame = CGRect( x: 150, y: 490, width: 100, height: 100)
        fish1.contentMode = .scaleAspectFit
        return fish1
    }()
    lazy var fish2: UIImageView = {
        let image2 = UIImage(named: "fish2")
        let view2 = UIImageView(image: image2)
        view2.frame = CGRect( x: 150, y: 300, width: 100, height: 100)
        view2.contentMode = .scaleAspectFit
        return view2
    }()
    lazy var fish3: UIImageView = {
        let image3 = UIImage(named: "fish3")
        let view3 = UIImageView(image: image3)
        view3.frame = CGRect( x: 200, y: 600, width: 100, height: 100)
        view3.contentMode = .scaleAspectFit
        return view3
    }()
    lazy var fish4: UIImageView = {
        let image4 = UIImage(named: "fish4")
        let view4 = UIImageView(image: image4)
        view4.frame = CGRect( x: 60, y: 250, width: 100, height: 100)
        view4.contentMode = .scaleAspectFit
        return view4
    }()
    lazy var fish5: UIImageView = {
        let image5 = UIImage(named: "fish5")
        let view5 = UIImageView(image: image5)
        view5.frame = CGRect( x: 300, y: 350, width: 100, height: 100)
        view5.contentMode = .scaleAspectFit
        return view5
    }()

    var isFishCatched = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        setupFishes()
        view.addSubview(label1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_ :)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.addSubview(button)
        button.addTarget(self,
                         action: #selector(didTapButton),
                         for: .touchUpInside)
    }
    @objc func didTapButton() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.button.transform = CGAffineTransform(translationX: 280, y: 30)
            self.button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
  resetFishes()
      }
    private func setupFishes() {
        view.addSubview(fish)
        view.addSubview(fish1)
        view.addSubview(fish2)
        view.addSubview(fish3)
        view.addSubview(fish4)
        view.addSubview(fish5)
    }
    func functionSelector() {
        var randomIndex = Int()
        let numberOfFunctions = 4
        randomIndex = Int.randomOutOf(max: numberOfFunctions)
                switch randomIndex {
                case 0: moveRight()
                case 1: moveLeft()
                case 2: moveBottom()
                case 3: moveTop()
                default: break
                }
     }
    func moveRight() {
        let randomX = CGFloat.random(in: 10...350)
        let randomY = CGFloat.random(in: 80...700)
        let fishes = [fish, fish1, fish2, fish3, fish4, fish5]
        let randomFishes = [fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement()]
        for fish0 in randomFishes {
          UIView.animate(withDuration: 3.0,
                         delay: 0.5,
                         options: [.curveEaseInOut, .allowUserInteraction],
                         animations: {
              fish0!.center = CGPoint(x: randomX, y: randomY)
          },
                         completion: { _ in
                      self.moveLeft()
       })
 }
    }
   func moveLeft() {
       let randomX = CGFloat.random(in: 10...350)
       let randomY = CGFloat.random(in: 80...700)
       let fishes = [fish, fish1, fish2, fish3, fish4, fish5]
       let randomFishes = [fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement()]
       for fish0 in randomFishes {
      UIView.animate(withDuration: 3.0,
                     delay: 0.5,
                     options: [.curveEaseInOut, .allowUserInteraction],
                     animations: {
          fish0!.center = CGPoint(x: randomX, y: randomY)
      },
                     completion: { _ in
          print("fish moved left!")
                    self.moveBottom()
     })
   }
   }
    func moveBottom() {
        let randomX = CGFloat.random(in: 10...350)
        let randomY = CGFloat.random(in: 80...700)
        let fishes = [fish, fish1, fish2, fish3, fish4, fish5]
        let randomFishes = [fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement(),
                            fishes.randomElement()]
        for fish0 in randomFishes {
            UIView.animate(withDuration: 3.0,
                           delay: 0.5,
                           options: [.curveEaseInOut, .allowUserInteraction],
                           animations: {
                fish0!.center = CGPoint(x: randomX, y: randomY)
            },
                           completion: { _ in
                            print("fish moved bottom!")
                            self.moveTop()
           })
   }
    }
   func moveTop() {
       let randomX = CGFloat.random(in: 50...350)
       let randomY = CGFloat.random(in: 80...700)
       let fishes = [fish, fish1, fish2, fish3, fish4, fish5]
       let randomFishes = [fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement(),
                           fishes.randomElement()]
       for fish0 in randomFishes {
         UIView.animate(withDuration: 3.0,
                        delay: 0.5,
                        options: [.curveEaseInOut, .allowUserInteraction],
                        animations: {
             fish0!.center = CGPoint(x: randomX, y: randomY) },
                        completion: nil
         )}
   }
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        let fishes = [fish, fish1, fish2, fish3, fish4, fish5]
        for fish in fishes {
        if fish == fishes[0] {
        let tapLocation = gesture.location(in: fishes[0].superview)
     if (fishes[0].layer.presentation()?.frame.contains(tapLocation))! {

       self.isFishCatched = true
         numberOfFishes += 1
         label1.text = "#Fishes: \(numberOfFishes)"
         countFishes()
         view.reloadInputViews()
         UIView.animate(withDuration: 0.5) { [weak self] in
             guard self != nil else { return }
             fishes[0].alpha = 0.01
             }
     }
            } else if fish == fishes[1] {
            let tapLocation = gesture.location(in: fishes[1].superview)
            if (fishes[1].layer.presentation()?.frame.contains(tapLocation))! {

            self.isFishCatched = true
            numberOfFishes += 1
            label1.text = "#Fishes: \(numberOfFishes)"
            countFishes()
            view.reloadInputViews()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard self != nil else { return }
                fishes[1].alpha = 0.01
                     }
             }
            } else if fish == fishes[2] {
            let tapLocation = gesture.location(in: fishes[2].superview)
            if (fishes[2].layer.presentation()?.frame.contains(tapLocation))! {
            self.isFishCatched = true
            numberOfFishes += 1
            label1.text = "#Fishes: \(numberOfFishes)"
            countFishes()
            view.reloadInputViews()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard self != nil else { return }
                fishes[2].alpha = 0.01
                     }
             }
            } else if fish == fishes[3] {
            let tapLocation = gesture.location(in: fishes[3].superview)
            if (fishes[3].layer.presentation()?.frame.contains(tapLocation))! {
            self.isFishCatched = true
            numberOfFishes += 1
            label1.text = "#Fishes: \(numberOfFishes)"
            countFishes()
            view.reloadInputViews()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard self != nil else { return }
                fishes[3].alpha = 0.01
                             }
            }
            } else if fish == fishes[4] {
            let tapLocation = gesture.location(in: fishes[4].superview)
            if (fishes[4].layer.presentation()?.frame.contains(tapLocation))! {
            self.isFishCatched = true
            numberOfFishes += 1
            label1.text = "#Fishes: \(numberOfFishes)"
            countFishes()
            view.reloadInputViews()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard self != nil else { return }
                fishes[4].alpha = 0.01
                             }
                     }
            } else if fish == fishes[5] {
            let tapLocation = gesture.location(in: fishes[5].superview)
            if (fishes[5].layer.presentation()?.frame.contains(tapLocation))! {
            self.isFishCatched = true
            numberOfFishes += 1
            label1.text = "#Fishes: \(numberOfFishes)"
            view.reloadInputViews()
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard self != nil else { return }
                fishes[5].alpha = 0.01
                                     }
                             }
                } else {
                print("error") }
     }
    }
    private func countFishes() {
        if numberOfFishes >= 6 {
            numberOfFishes = 0
            label1.text = "#Fishes: \(numberOfFishes)"
            alarmReset()
        }
    }
    private func alarmReset() {
        let alert = UIAlertController(
            title: "Вы поймали всех рыб",
            message: "Хотите попробовать снова?",
            preferredStyle: .alert)
        alert.view.backgroundColor = .systemFill
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: { _ in
                self.resetFishes()
            }))
        self.present(alert, animated: true, completion: nil)}
    private func resetFishes() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish.alpha = 1
            }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish1.alpha = 1
            }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish2.alpha = 1
            }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish3.alpha = 1
            }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish4.alpha = 1
            }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.fish5.alpha = 1
            }
        self.functionSelector()
        self.moveTop()
        }
    }
private extension Int {
    static func randomOutOf(max:Int) -> Int {
        return Int(arc4random() % UInt32(max))
    }
}
