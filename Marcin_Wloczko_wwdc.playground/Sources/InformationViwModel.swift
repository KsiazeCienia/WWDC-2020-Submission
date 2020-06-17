import SwiftUI

public final class InformationViewModel: ObservableObject {
    @Published var title: String
    @Published var description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}




