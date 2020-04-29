//
//  FBCamera.swift
//  FBKit
//
//  Created by Felipe Correia on 28/03/20.
//  Copyright © 2020 Felip38rito. All rights reserved.
//

import Vision
import AVFoundation
import Foundation

/**
 FBKit scheme for use and control the camera
 */
@available(iOS 11.0, *)
open class FBCamera: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    
    var session: AVCaptureSession
    var photoOutput : AVCapturePhotoOutput
    var delegate: FBCameraDelegate
    var findFaces: Bool = false
    
    var sequenceHandler = VNSequenceRequestHandler()
    
    public init(delegate: FBCameraDelegate, preset: AVCaptureSession.Preset = .photo, holdPermanentListeners: Bool = false) {
        self.delegate = delegate
        self.session = AVCaptureSession()
        self.photoOutput = AVCapturePhotoOutput()
        
        // init NSObject...
        super.init()
        
        AVCaptureDevice.requestAccess(for: .video) { (success) in
            if success {
                
                DispatchQueue.main.async {
                    self.delegate.accessGranted()
                }
                /// Com permissao garantida, inicializamos a classe corretamente
                
                self.session.sessionPreset = preset
                
                
                if self.session.canAddOutput(self.photoOutput) {
                    self.session.addOutput(self.photoOutput)
                } else {
                    // tratamento de erro personalizado para saida...
                    print("FBCamera: Problem - Generic error session.canAddOutput returned false")
                }
                
                if holdPermanentListeners {
                    self.addPermanentListeners()
                }
                
            } else {
                DispatchQueue.main.async {
                    self.delegate.accessDenied()
                }
            }
        }
    }
    
    /**
    Configura o input da camera, que deve possuir uma posicao (back ou front) e um tipo de mídia para o target
     - Parameters:
        - position: Posição da câmera (back ou front)
        - mediaType: Tipo de mídia a ser capturada
    */
    open func addInput(position: AVCaptureDevice.Position, mediaType: AVMediaType = .video) {
        let deviceDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: mediaType, position: position)
        
        if let device = deviceDiscovery.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if session.canAddInput(deviceInput) {
                    session.addInput(deviceInput)
                }
            }
        }
    }
    
    open func takePhoto(settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    /**
     Inicializa o processo da camera
     */
    open func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            #if targetEnvironment(simulator)
            /// Não podemos utilizar camera nos simuladores, certo? :)
            #else
            self.session.startRunning()
            #endif
        }
    }
    
    /**
     Para a sessao de captura da camera
    */
    open func stop() {
        session.stopRunning()
    }
    
    /**
     Faz com que a preview exiba o que
     a camera esta vendo em uma view
     - Parameters:
        - preview: Uma view para exibir a captura real time da câmera
     */
    open func show(at preview: UIView, resize: AVLayerVideoGravity = .resizeAspectFill, frame: CGRect = UIScreen.main.bounds) {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer.frame = frame
        previewLayer.cornerRadius = preview.layer.cornerRadius
        previewLayer.masksToBounds = true
        previewLayer.videoGravity = resize
        previewLayer.contentsGravity = .bottom
        
        preview.layer.addSublayer(previewLayer)
    }
    
    /**
    Diz a nossa classe para procurar rostos e avisar o delegate quando encontrar
    */
    open func lookForFaces() {
        self.findFaces = true
        
        addEnterFrameDelegate()
    }
    
    private func addPermanentListeners() {
        // Adiciona o listener de
        NotificationCenter.default.addObserver(self, selector: #selector(willResignInactive), name: UIApplication.willResignActiveNotification , object: nil)
        // adiciona o listener de
        NotificationCenter.default.addObserver(self, selector: #selector(reopened), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc private func willResignInactive() {
        stop()
    }
    
    @objc private func reopened() {
        start()
    }
    
    /// Captura o evento "enter frame" do video da camera e chama captureOutput do delegate informado
    private func addEnterFrameDelegate() {
        print("Try to add delegate")
        
        let dataOutputQueue = DispatchQueue(
            label: "video data queue",
            qos: .userInitiated,
            attributes: [],
            autoreleaseFrequency: .workItem)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        // Conexao com o video, pra informar que sera captado em retrato
        let videoConnection = videoOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        } else {
            print("FBCamera log: Can't add the output for delegate video")
        }
    }
    
    open func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let metadata = photo.fileDataRepresentation() else { return }
        guard let uiimage = UIImage(data: metadata) else { return }
        
        delegate.didTake(photo: uiimage)
    }
    
    open func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Vamos tentar identificar rostos com este handler
        // arquivo de buffer da imagem
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let ciimage = CIImage(cvPixelBuffer: imageBuffer)
        let uiimage = UIImage(ciImage: ciimage)
        
        delegate.didTake(frame: uiimage)
        
        guard findFaces else { return }
        
        let detectFaceRequest = VNDetectFaceLandmarksRequest(completionHandler: detectedFace)
        
        do {
            try sequenceHandler.perform( [detectFaceRequest], on: imageBuffer, orientation: .leftMirrored)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func detectedFace(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNFaceObservation] else { return }
        guard let result = results.first else { return }
        
        delegate.foundFace(with: result)
    }
}

@available(iOS 11.0, *)
public protocol FBCameraDelegate {
    func accessGranted()
    func accessDenied()
    func didTake(photo: UIImage)
    func didTake(frame: UIImage)
    func foundFace(with: VNFaceObservation)
}

@available(iOS 11.0, *)
public extension FBCameraDelegate {
    func accessGranted(){ }
    func accessDenied(){ }
    func didTake(photo: UIImage){ }
    func didTake(frame: UIImage){ }
    func foundFace(with: VNFaceObservation) { }
}
