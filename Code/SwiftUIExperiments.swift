import SwiftUI
import Combine
import SwiftObserver
import CombineObserver

/*
Code below demonstrates how to:
 1. let view observe individual properties / publishers
 2. store "transforms" of other publishers (here: in view model)
 3. turn SwiftObserver's Observables into Combine Publishers
 4. bind state properties directly to publishers and observables
 5. declare Text views directly with a publisher (without having to manage a state property) using `UpdatingText`, while still being able to modify the text view
 */

/** other insights:
 * It is possible to create a binding to an observed object's property with the dollar sign:
 `$observedObject.property`. But that will only fire on changes of the property if the property is also @Published.
 * When accessing an @EnvironmentObject that wasn't provided, an app will crash.
 * a view can have multiple environment objects if they are of different types
 * i assume there can only be one @EnvironmentObject of one type, since different instances could not be distinguished ...
 * `.onChange(...)` can actually observe regular properties (that are neither published nor state related), probably through key value observing under the hood
 */

public struct TestView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Text("number: \(number)")
                .bind($number, to: viewModel.$number)

            Text("doubledNumber: \(doubledNumber)")
                .bind($doubledNumber, to: viewModel.doubled)

            Text("text: " + text)
                .bind($text, to: viewModel.uppercased)

//            Text("model number: \(modelNumber)")
//                .bind($modelNumber, to: viewModel.modelNumber)
            
            UpdatingText(viewModel.modelNumberString)
            
//            Text("Observable: " + observableText)
//                .bind($observableText, to: viewModel.observable)
            
            UpdatingText(viewModel.observable.publisher()) { $0.bold() }
            
//            Text("Observable: " + viewModel.observable.latestMessage)
//                .onReceive(viewModel.observable.publisher().dropFirst()) { _ in
//                    updater.triggerUpdate()
//                }
            
            Spacer()
            
            Button {
                viewModel.number += 1
                viewModel.text += "!"
                viewModel.model.number.value += 1
                viewModel.model.text.value += "😊"
            } label: {
                Text("Edit Data")
            }
        }
    }
    
    @State private var number = -1
    @State private var doubledNumber = -1
    @State private var text = "noooo"
    @State private var modelNumber = -1
    
    let viewModel = TestViewModel()
}

class TestViewModel: Combine.ObservableObject {
    
    @Published var regularBool = false
    
    // Combine Publishers
    lazy private(set) var uppercased = $text.map { $0.uppercased() }
    @Published var text = "huhu"
    
    lazy private(set) var doubled = $number.map { $0 * 2 }
    @Published var number = 1
    
    lazy private(set) var modelNumberString = model.number.publisher().map { "\($0.new)" }
    
    // Pure SwiftObserver Observables
    lazy private(set) var observable = model.text.new().map { "model text: " + $0 }
    
    let model = TestModel()
}

class TestModel {
    let number = Var(123)
    let text = Var("✅")
}
