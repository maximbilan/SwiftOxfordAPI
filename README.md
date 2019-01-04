# SwiftOxfordAPI
A framework to consume the <a href="https://developer.oxforddictionaries.com/documentation">Oxford Dictionaries API</a> written in Swift.

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
<pre>
SwiftOxfordAPI.shared.start(appId: "APP_ID_HERE", appKey: "APP_KEY_HERE")
</pre>

## Using

## License

<i>SwiftOxfordAPI</i> is available under the MIT license. See the LICENSE file for more info.
