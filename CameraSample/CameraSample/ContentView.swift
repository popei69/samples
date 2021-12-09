//
//  ContentView.swift
//  Recoord
//
//  Created by Benoit Pasquier on 25/1/21.
//

import AVFoundation
import CoreMediaIO
import Combine
import SwiftUI

class PlayerView: NSView {
    
    private weak var settings: UserSettings?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private lazy var cancellables = Set<AnyCancellable>()

    init(captureSession: AVCaptureSession, settings: UserSettings? = nil) {
        self.settings = settings
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        super.init(frame: .zero)

        setupLayer()
    }

    func setupLayer() {

        previewLayer?.frame = self.frame
        previewLayer?.contentsGravity = .resizeAspectFill
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.connection?.automaticallyAdjustsVideoMirroring = false
        
        layer = previewLayer
        
        settings?.$isMirroring
            .subscribe(on: RunLoop.main)
            .sink { [weak self] isMirroring in
                self?.previewLayer?.connection?.isVideoMirrored = isMirroring 
            }
            .store(in: &cancellables)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class PlayerContainerView: NSViewRepresentable {
    typealias NSViewType = PlayerView

    let settings: UserSettings
    let captureSession: AVCaptureSession

    init(captureSession: AVCaptureSession, settings: UserSettings) {
        self.captureSession = captureSession
        self.settings = settings
    }

    func makeNSView(context: Context) -> PlayerView {
        return PlayerView(captureSession: captureSession, settings: settings)
    }

    func updateNSView(_ nsView: PlayerView, context: Context) { }
}

enum PlayerAction {
    case play
    case pause
}

class ContentViewModel: ObservableObject {

    @Published var isGranted: Bool = false
    var captureSession: AVCaptureSession!
    private var cancellables = Set<AnyCancellable>()

    init() {
        captureSession = AVCaptureSession()
        setupBindings()
    }

    func setupBindings() {
        $isGranted
            .sink { [weak self] isGranted in
                if isGranted {
                    self?.prepareCampera()
                } else {
                    self?.stopSession()
                }
            }
            .store(in: &cancellables)

        NotificationCenter.default
            .publisher(for: NSNotification.Name.AVCaptureDeviceWasConnected)
            .sink { [weak self] notification in
                print("new device \(notification)")
                if let device = notification.object as? AVCaptureDevice {
                    self?.startSessionForDevice(device)
                }
            }
            .store(in: &cancellables)
    }

    func checkAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                self.isGranted = true

            case .notDetermined: // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async {
                            self?.isGranted = granted
                        }
                    }
                }

            case .denied: // The user has previously denied access.
                self.isGranted = false
                return

            case .restricted: // The user can't grant access due to restrictions.
                self.isGranted = false
                return
        @unknown default:
            fatalError()
        }
    }

    func startSession() {
        guard !captureSession.isRunning else { return }
        captureSession.startRunning()
    }

    func stopSession() {
        guard captureSession.isRunning else { return }
        captureSession.stopRunning()
    }

    func prepareCampera() {
        captureSession.sessionPreset = .high

        if let device = AVCaptureDevice.default(for: .video) {
            startSessionForDevice(device)
        }
    }

    func startSessionForDevice(_ device: AVCaptureDevice) {
        do {
            let input = try AVCaptureDeviceInput(device: device)
            addInput(input)
            startSession()
        }
        catch {
            print("Something went wrong - ", error.localizedDescription)
        }
    }

    func addInput(_ input: AVCaptureInput) {
        guard captureSession.canAddInput(input) == true else {
            return
        }
        captureSession.addInput(input)
    }
}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()
    @EnvironmentObject var settings: UserSettings

    init() {
        viewModel.checkAuthorization()
    }

    var body: some View {
        PlayerContainerView(captureSession: viewModel.captureSession, settings: settings)
                .clipShape(shape)
    }
    
    var shape: some Shape {
        switch settings.shape {
        case .circle:
            return AnyShape(Circle())
        case .rectangle:
            return AnyShape(RoundedRectangle(cornerRadius: 25.0))
        }
    }
}

struct AnyShape: Shape {
    init<S: Shape>(_ wrapped: S) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }

    private let _path: (CGRect) -> Path
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
