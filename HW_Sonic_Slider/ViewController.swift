//
//  ViewController.swift
//  HW_Sonic_Slider
//
//  Created by 曹家瑋 on 2023/4/28.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var positionSlider: UISlider!
    @IBOutlet weak var sonicImageView: UIImageView!
    @IBOutlet weak var ringImageView: UIImageView!
    @IBOutlet weak var eggManImageView: UIImageView!
    @IBOutlet weak var secondRingImageView: UIImageView!
    @IBOutlet weak var landscapeImageVIew: UIImageView!
    
    // 重複播放音樂
    var musicLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 重複播放音樂
        let songFileUrl = Bundle.main.url(forResource: "song", withExtension: "mp3")!
        let musicPlayer = AVQueuePlayer()
        let musicItem = AVPlayerItem(url: songFileUrl)
        musicLooper = AVPlayerLooper(player: musicPlayer, templateItem: musicItem)
        musicPlayer.play()
    
        // 設置 ring的gif圖片
        let ringAnimatedImage = UIImage.animatedImageNamed("sonic-ring-sonic-", duration: 1.5)
        ringImageView.image = ringAnimatedImage
        let secondRingAnimatedImage = UIImage.animatedImageNamed("sonic-ring-sonic-", duration: 1.5)
        secondRingImageView.image = secondRingAnimatedImage
        
        // 設置 eggman的gif圖片
        let eggManAnimatedImage = UIImage.animatedImageNamed("Eggman-", duration: 1)
        eggManImageView.image = eggManAnimatedImage
        
        // 設置 Slider 的最小值、最大值和初始值(以sonic的gif張數去設置最大值）
        positionSlider.minimumValue = 0.0
        positionSlider.maximumValue = 7.0
        positionSlider.value = 0.0

    }

    @IBAction func slideAnimation(_ sender: UISlider) {
        
        // 移動速度
        let speed = sender.value * 80.0
        
        // 將 slider 的 value 四捨五入為整數
//        sender.value.round()

        // sonic 與 slider 的逐格動畫(含位移）
        let SonicImageName = String(format: "Sonic-%01d", arguments: [Int(sender.value)])
        sonicImageView.image = UIImage(named: SonicImageName)
        // sonic 移動速度(位移）
        sonicImageView.frame.origin.x = CGFloat(141 + speed * 1.3)
                
        // 背景 與 slider 的逐格動畫
        let landscapeImageName = String(format: "landscape-%01d", arguments: [Int(sender.value)])
        landscapeImageVIew.image = UIImage(named: landscapeImageName)
        
        // 更新 ring 的位置、透明度
        let ringPosition = CGFloat(530 - speed * 0.6)
        ringImageView.frame.origin.x = ringPosition
        ringImageView.alpha = 1 - CGFloat(sender.value/3)
        
        let secondRingPosition = CGFloat(644 - speed * 0.6)
        secondRingImageView.frame.origin.x = secondRingPosition
        secondRingImageView.alpha = 1 - CGFloat(sender.value/4)
                
        // 更新 eggman的移動位置、尺寸大小
        eggManImageView.frame.origin.x = CGFloat(70 + speed * 1.7)
        eggManImageView.frame.size = CGSize(width: CGFloat(70 + 28 * sender.value), height: CGFloat(70 + 28 * sender.value))
        
    }
    
}

