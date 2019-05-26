# Babylon Health Engineering Demo

### Pods Used

  - RxSwift/RxCocoa
  - Alamofire / RxAlamofire - Networking
  - SnapKit - Autolayout DSL (my personal favorite), to avoid using the verbose built in API, and to avoid using equally annnoying storyboards..
  - RealmSwift / RxRealm - Persistence
  - RxRealmDataSources - Just a simple way of linking a Realm DB changeset to a UITableView. I hadn't actually tried this pod before, and while it certainly has it's limitations, it was sufficient for these purposes
  - Toast-Swift - A small Toast library. I prefer the look of the toast in the MaterialComponents pod, but that pod adds EVERYTHING in the MDC library, which was simply too much for such a small, non Material UI, so I found this to be a suitable alternative. Just a bit bored with UIAlertViewControllers, so preferred the toast way.
  - NSObject-Rx - Just a nice pod that allows you to avoid writing `let disposeBag = DisposeBag` in every single ViewController!

### Installation

Clone / download the repo. Navigate to the repo and run

```sh
pod install
```

### Notes

My focus for the demo was on utilizing RxSwift. I have about two years of Reactive programming, though I admit I am completely self taught, and likely still have a lot left to learn! I also did about six months of ReactiveCocoa, but I much prefer the RxSwift API - it feels much more swifty to me. I also had noble intentions to add some reasonable robust testing, but I won't lie - I've never used Rx for testing in a production environment. Sadly it was never a priority for the lead at my last job. Still, while I learned some fascinating things about RxBlocking et all this weekend, I ultimately felt I didn't have the time necessary to write 'proper' rx testing code. Todo!