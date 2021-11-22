import CoreImage

class ContentViewModel: ObservableObject {
    @Published var error: Error?
    private let cameraManager = CameraManager.shared
    
    // 1
    @Published var frame: CGImage?
    // 2
    private let frameManager = FrameManager.shared
    
    init() {
        setupSubscriptions()
    }
    // 3
    func setupSubscriptions() {
        // 1
        cameraManager.$error
            // 2
            .receive(on: RunLoop.main)
            // 3
            .map { $0 }
            // 4
            .assign(to: &$error)
        
        // 1
        frameManager.$current
            // 2            
            .receive(on:RunLoop.main)
            // 3
            .compactMap { buffer in
                return CGImage.create(from: buffer)
            }
            
            // 4
            .assign(to: &$frame)
        
    }
}

