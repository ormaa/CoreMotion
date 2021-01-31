# CoreMotion
CoreMotion sample using SwiftUI and Combines to get update on UI.

I decided to update an old project done for test purpose.
I used SwiftUI , which is really nice feature from Apple.

I tried to implement something like an MVVM pattern : the Binding of SwiftUI is perfect for that.
I did not used combine here, as I don't really need it for that simple project.

My architecture is really simple :
I have only one screen, with a Main view : ContentView
the ContentView is built with several graphical component, and some text are updated by Binging using a ViewModel.

The ViewModel is using a DataModel, in order to be clean.
The DataModel, here, use directly a CoreMotion helper, but we could imaging having datas coming from elsewhere.

in CoreMotion, I get some interesting things, but not all :
device angle, activity status ( walkign running etc), number of steps, and distance

about distance, I still think it is a bit complex to use it in actual state.

the project use Xcode 12, Swift 5.

I hope you will enjoy.
Olivier



