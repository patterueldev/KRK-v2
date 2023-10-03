// The Swift Programming Language
// https://docs.swift.org/swift-book

public struct KRKCommon {
    private static var manager: DependencyManager?
    
    public static func buildDependencyManager() -> DependencyManager {
        if self.manager == nil {
            self.manager = DependencyManager()
        }
        self.registerDependencies()
        return self.manager!
    }
    
    static func registerDependencies() {
        guard let manager = self.manager else { return }
        manager.register(type: EstablishConnectionUseCase.self) {
            DefaultEstablishConnectionUseCase(repository: $0.resolve())
        }
    }
    
    // MARK: Preview
    
    public static func previewDependencyManager() -> DependencyManager {
        if self.manager == nil {
            self.manager = DependencyManager()
        }
        self.registerPreviewDependencies()
        return self.manager!
    }
    
    static func registerPreviewDependencies() {
        guard let manager = self.manager else { return }
        manager.register(type: EstablishConnectionUseCase.self) {
            DefaultEstablishConnectionUseCase(repository: $0.resolve())
        }
        manager.register(type: EstablishConnectionRepository.self) { _ in
            PreviewEstablishConnectionDataSource()
        }
    }
    
    private init() { fatalError("KRKCommon should not be initialized") }
}

