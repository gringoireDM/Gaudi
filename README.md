<p align="center">
<img src="./GaudiLogo.png" alt="MERLin"/>
</p>

**Gaudí** is a framework for theme management in UIKit. It allows to easily swap themes in runtime, revert theming applied through `UIAppearance` proxies.

Gaudí also provides a DSL for `UIAppearance` rules and `NSAttributedString`.

This framework uses semantic colors names to better adapt to [dark mode](https://developer.apple.com/documentation/xcode/supporting_dark_mode_in_your_interface) and other possible themes living within the same app.

## What's wrong with explicit color names?

Nothing, except that reading `red` ones would expect as result a color that is a shade of red, while reading `primary` there are no expectations to fail. 

This framework aims to make theming easy. If you are using a `black` color for a text it would be strange to see `black` actually be mapped to a white color in a dark mode theme. For this reason i decided to adopt Apple recommendations about using Semantic colors, not only to support Dark Mode, but also to allow different themes to work together maintaining a layer of semantic abstraction from the theme color and the actual rendered color.

## Semantic colors

Work with your designer to get these right. Like apple recommends don't take shortcuts and don't change the semantic meaning of the semantic color. **Gaudí**'s `SemanticColor` enum provides a clear hint about what that color atually is:

```swift
public enum SemanticColor: CaseIterable {
    case label(LabelColor)
    case fill(FillColor)
    case background(BackgroundColor)
    case groupedBackground(GroupedContentBackgroundColor)
    case separator(SeparatorColor)
}
```

Each one of these `LabelColor`, `FillColor`, `BackgroundColor`, `GroupedContentBackgroundColor` have different specific semantic color such as `primary`, `secondary`, `tertiary` and so on.

Don't use a `LabelColor` as a fill color. This will introduce entropy in your project. Work closely with your designer to adhere to this specification. When in your code you will be using just `SemanticColor`s in the correct way, to re-skin your app will be as easy as change 20 lines of code. You will also be able to A/B test the different theme by creating a new theme object with the new colors. 
