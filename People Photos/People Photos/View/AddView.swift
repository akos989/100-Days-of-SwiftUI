//
//  AddView.swift
//  People Photos
//
//  Created by Morvai Ákos on 2022. 10. 27..
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var image: Image?
    
    @State private var inputImage: UIImage?
    @State private var personName = ""
    
    var saveButtonDisabled: Bool {
        inputImage == nil || personName.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Text("Tap to select photo")
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image("unknownImage")
                            .resizable().scaledToFit()
                    }
                }
                .frame(width: 200, height: 200)
                Spacer()
                Form {
                    Section {
                        TextField("Name of person", text: $personName)
                    }
                    Button("Save") {
                        if !personName.isEmpty, let inputImage = inputImage {
                            let person = Person(context: moc)
                            person.name = personName
                            let imageName = UUID().uuidString
                            person.imageName = imageName
                            
                            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                                let url = getDocumentsDirectory().appendingPathComponent(imageName)
                                try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
                                try? moc.save()
                                
                                dismiss()
                            }
                        }
                    }
                    .disabled(saveButtonDisabled)
                }
            }
            .navigationTitle("Add new person")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveImageToDirectoryWith(name: String) {
        
    }
    
//    public var image: UIImage {
//        get {
//            if let imageName = imageName {
//                let imageUrl = getDocumentsDirectory().appendingPathComponent(imageName)
//                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
//                    return image
//                }
//            }
//            guard let noPictureImage = UIImage(named: "unknownImage") else { fatalError("'unkownImage' not found in assets") }
//            return noPictureImage
//        }
//        set {
//            if let jpegData = newValue.jpegData(compressionQuality: 0.8) {
//                <#statements#>
//            }
//        }
//    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
