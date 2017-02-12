//
//  ViewController.swift
//  Howl
//
//  Created by Jonathon Shen on 2/11/17.
//  Copyright © 2017 jonashen. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var speechToTextDisplay: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var wolfImage: UIImageView!
    @IBOutlet weak var howlTitle: UITextView!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // provides an audio input to speech recognizer
    private var recognitionTask: SFSpeechRecognitionTask? // gives result of the request made
    private let audioEngine = AVAudioEngine() // provides audio input
    
    // User must allow app to use input audio + speech recognition; knows what language is being spoken
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wolfImage.transform = CGAffineTransform(rotationAngle: 1)
        
        // disable microphone until speech recognizer is activated
        recordButton.isEnabled = false
        
        // set the speech recognizer delegate to self
        //        speechRecognizer.delegate = self
        
        // request authorization of Speech Recognition
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            // Check if Speech Recognition is authorized
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.recordButton.isEnabled = isButtonEnabled
            }
        }
        
        speechToTextDisplay.isSelectable = false
        howlTitle.isEditable = false
    }
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("HOWL", for: .normal)
            // Segue-way into the next screen
            self.performSegue(withIdentifier: "stopRecording", sender: self)
            recordButton.setImage(UIImage(named: "microphone_yellow.png"), for: UIControlState.normal)
            recordButton.updateConstraints()
        } else {
            startRecording()
            recordButton.setTitle("Stop", for: .normal)
            recordButton.setImage(UIImage(named: "microphone_black.png"), for: UIControlState.normal)
            speechToTextDisplay.text = ""
        }
    }
    
    func startRecording() {
        
        // Cancel any current tasks
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // Create an audiosession for audio recording and activate it
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        // Used to pass audio data to Apple Servers
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        // check if audioEngine (your device) has audio input for recording
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        // Check if instantiated
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        // Report partial results as the user speaks
        recognitionRequest.shouldReportPartialResults = true
        
        // start recognition by calling the task method
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            // check if recognition is final
            var isFinal = false
            
            // set the textDisplay on the app to display the transcription
            if result != nil {
                
                self.speechToTextDisplay.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            // no error or final, stop the audio engine; enable the recordbutton again
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
            }
        })
        
        // Add audio input to recognitionRequest; SpeechFramework will start recognizing immediately
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    // Make sure speech recognition is available; we change availability if it is
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            recordButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let DestViewController : ViewController2 = (segue.destination as? ViewController2)!
//        DestViewController.parsedString = textField.text
//    }
}

