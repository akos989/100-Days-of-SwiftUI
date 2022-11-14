//
//  ContentView.swift
//  Instafilter
//
//  Created by Morvai Ákos on 2022. 09. 29..
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    Text("Tap to select a picture")
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                            .disabled(!currentFilter.inputKeys.contains(kCIInputIntensityKey))
                    }
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius) { _ in applyProcessing() }
                            .disabled(!currentFilter.inputKeys.contains(kCIInputRadiusKey))
                    }
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale) { _ in applyProcessing() }
                            .disabled(!currentFilter.inputKeys.contains(kCIInputScaleKey))
                            .padding(.vertical)
                    }
                }
                HStack {
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(inputImage == nil || image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select the filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            if let inputImage = inputImage {
                image = Image(uiImage: inputImage)
            }
            return
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        } else {
            if let inputImage = inputImage {
                image = Image(uiImage: inputImage)
            }
        }
    }
    
    func save() {
        if let processedImage = processedImage {
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
                print("Success")
            }
            
            imageSaver.errorHandler = { error in
                print("error: \(error.localizedDescription)")
            }
            
            imageSaver.writeToPhotoAlbum(image: processedImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
