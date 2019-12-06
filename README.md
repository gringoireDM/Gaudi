<p align="center">
<img src="./GaudiLogo.png" alt="MERLin"/>
</p>

**Gaudí** is a framework for theme management in UIKit. It allows to easily swap themes in runtime, revert theming applied through `UIAppearance` proxies.

Gaudí also provides a DSL for `UIAppearance` rules and `NSAttributedString`.

This framework uses semantic colors names to better adapt to [dark mode](https://developer.apple.com/documentation/xcode/supporting_dark_mode_in_your_interface) and other possible themes living within the same app.

## What's wrong with explicit color names?

Nothing, except that reading `red` ones would expect as result a color that is a shade of red, while reading `primary` there are no expectations to fail. 

This framework aims to make theming easy. If you are using a `black` color for a text it would be strange to see `black` actually be mapped to a white color in a dark mode theme. For this reason i decided to adopt Apple recommendations about using Semantic colors, not only to support Dark Mode, but also to allow different themes to work together maintaining a layer of semantic abstraction from the theme color and the actual rendered color.
