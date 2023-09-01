//
//  ErrorViewController.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 26.08.2023.
//

import Foundation
import UIKit
import AVFoundation

class ErrorViewController: UIViewController {
    
    private var errorView = ErrorView()
    private var player: AVAudioPlayer?
    
    override func loadView() {
        super.loadView()
        setupErrView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        errorView.configureScrollingLabel()
        errorView.configureImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopSound()
    }
    
    private func setupErrView() {
        errorView.delegate = self
        errorView.configureUI()
        self.view = errorView
    }
}


extension ErrorViewController: ErrorViewDelegate {
    
    func tapToTryAgain() {
        
    }
    
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "rw", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            if let player = player, player.isPlaying {
                player.stop()
                player.currentTime = 0
            }

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.delegate = self

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        player?.stop()
        player = nil
    }
}

extension ErrorViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.dismiss(animated: true)
    }
}
