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
        playSound()
    }
}


extension ErrorViewController: ErrorViewDelegate {
    
    func tapToTryAgain() {
        
    }
    
    func closeButtonTapped() {
        goBack()
    }
}

private extension ErrorViewController {
    
    func setupErrView() {
       errorView.delegate = self
       errorView.configureUI()
       self.view = errorView
   }
    
    func goBack() {
        self.dismiss(animated: true)
        errorView.resetAnimations()
        stopSound()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "rw", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.delegate = self

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    func stopSound() {
        if let player = player {
            player.stop()
            player.currentTime = 0
        }
    }
}

extension ErrorViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        goBack()
    }
}
