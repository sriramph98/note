//
//  NoteView.swift
//  note
//
//  Created by Sriram P H on 29/11/20.
//

import SwiftUI

struct NoteView: View {

    var note: Note?
    @State var noteText: String
    var uiImage: UIImage

    init(note: Note?){
        self.note = note
        // _noteText will initialize noteText from the `Note` sent to us
        _noteText = State(initialValue: self.note?.noteTitle ?? "")
        let imageData = self.note?.imageData ?? Data()
        
        
        if let image = UIImage(data: imageData) {
              uiImage = image
        } else {
            uiImage = UIImage()
        }
    }

//
    
@State var isShowingImagePicker = false
    
    @State var imageInContainer = UIImage()
    
    
    var body: some View {
        Section {
            
            VStack{
                TextEditor(text: self.$noteText)
                        .padding()
//
                HStack{
                    Image(uiImage: self.uiImage)
                        .resizable()
                        .scaledToFit()


                }
      
                HStack
                {
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                        print("Button performed")
                    },
                    label:{
                        Label("Image", systemImage: "camera")
                            
                        
                    })
                    .sheet(isPresented: $isShowingImagePicker, content: {
                        ImagePickerView(isPresented: self.$isShowingImagePicker,
                                        selectedImage: self.$imageInContainer)
                        
                    })
                                
                    Spacer()
                    Label("Delete", systemImage: "trash")
                }
                .foregroundColor(.accentColor)
                .font(.system(size: 20))
                .labelStyle(IconOnlyLabelStyle())
                .padding()

            }.onTapGesture {
                self.hideKeyboard()}
    
            
        }
        .navigationTitle(self.noteText)
        .navigationBarItems(trailing:
                                Button(action: {
                                    note?.noteTitle = self.noteText
                                    note?.noteText = self.noteText
                                    note?.noteTimeStamp = Date()
                                    note?.imageData = self.imageInContainer.jpegData(compressionQuality: 1) 
                                    

                                },    label:{
                                    Text("Done")
                                })
                                .foregroundColor(.accentColor)

        )
    }

}




//
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: nil)
    }
}
