# SwiftOxfordAPI
A framework to consume the <a href="https://developer.oxforddictionaries.com/documentation">Oxford Dictionaries API</a> written in Swift.</br>
🍟🍉🍋🍇🍌

## Installation
<b>CocoaPods:</b>
<pre>
pod 'SwiftOxfordAPI'
</pre>
<b>Carthage:</b>
<pre>
github "maximbilan/SwiftOxfordAPI"
</pre>
<b>Swift Package Manager:</b>
<pre>
dependencies: [
    .package(url: "https://github.com/maximbilan/SwiftOxfordAPI", from: "0.1"))
]
</pre>
<b>Manual:</b>
<pre>
Copy <i>SwiftOxfordAPI.swift</i> to your project.
</pre>

## Initialization

First of all you have to generate API ID and APP key.
And then use the following code:
```swift
SwiftOxfordAPI.shared.start(appId: "APP_ID_HERE", appKey: "APP_KEY_HERE")
```

## Using

Right now the framework is supported only two requests: `entries` and `translation`.
For example:
```swift
SwiftOxfordAPI.shared.entries(language: "en", word: "queen", region: "us", filters: "grammaticalFeatures=singular,past;lexicalCategory=noun") { [weak self] (data, error) in
    self?.handleResponse(data, error)
}
```

```swift
SwiftOxfordAPI.shared.translation(sourceLanguage: "en", word: "queen", targetLanguage: "es") { [weak self] (data, error) in
    self?.handleResponse(data, error)
}
```

## To do:

Unfortunately, I stopped working on this repository because I don't need it for the moment.
It's not difficult to expand the methods, there is a list below of services which were already implemented. So, If you need more, please create a pull request with implemented services, I'll accept it.

- [x] Entries
- [x] Translation
- [ ] Sentences
- [ ] Lemmatron
- [ ] Thesaurus
- [ ] LexiStats
- [ ] Search
- [ ] Wordlist
- [ ] Utility

## License

<i>SwiftOxfordAPI</i> is available under the MIT license. See the LICENSE file for more info.
