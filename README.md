<p align="center">
<img src="./GaudiLogo.png" alt="MERLin"/>
</p>

**Gaudí** is a framework for theme management in UIKit. It allows to easily swap themes in runtime, revert theming applied through `UIAppearance` proxies.

Gaudí also provides a DSL for `UIAppearance` rules and `NSAttributedString`.

This framework uses semantic colors names to better adapt to [dark mode](https://developer.apple.com/documentation/xcode/supporting_dark_mode_in_your_interface) and other possible themes living within the same app.

# Index
* [What's wrong with explicit color names?](#whats-wrong-with-explicit-color-names)
    * [Semantic colors](#semantic-colors)
    * [Custom Semantic colors](#custom-semantic-colors)
* [How to create a theme](#how-to-create-a-theme)
    * [Appearance Rule Set](#appearance-rule-set)
    * [Setting up the theme](#setting-up-the-theme)
    * [Changing the theme](#changing-the-theme)
    * [Themed](#themed)
* [Supporting Dark Mode with Gaudí](#supporting-dark-mode-with-gaud%C3%AD)
    * [ThemedWindow](#themedwindow)
    * [Dynamic colors](#dynamic-colors)

# What's wrong with explicit color names?

Nothing, except that reading `red`, one would expect as result a color that is a shade of red, while reading `primary` there are no expectations.

This framework aims to make theming easy. If you are using a `black` color for a text it would be strange to see `black` actually be rendered as a white color in a dark mode theme. For this reason i decided to adopt Apple recommendations about using Semantic colors, not only to support Dark Mode, but also to allow different themes to work together maintaining a layer of semantic abstraction from the theme color and the actual rendered color.

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

## Custom Semantc colors

If the colors specializations for each category are not enough, you can create your own custom color using the special `custom` case of each color enum. To avoid repetitions in your code I recommend to extend the category and define a static var like this:

```swift
public extension LabelColor {
    static var myCustomSemanticColor: LabelColor {
        return .custom(color: .color(fromHex: "#123456"))
    }
}
```

# How to create a theme

Creating a theme is as simple as creating a class conforming the protocol `ThemeProtocol`.

```swift
public protocol ThemeProtocol: class {
    var appearanceRules: AppearanceRuleSet { get }
        
    // MARK: Colors
    
    func color(forSemanticColor semanticColor: SemanticColor) -> UIColor
    
    // MARK: Fonts
    
    func font(forStyle style: FontStyle) -> UIFont
    func fontSize(forStyle style: FontStyle) -> CGFloat
    func kern(forStyle style: FontStyle) -> CGFloat
}
```

The only requirements for the `ThemeProtocol` are a mapping function from `SemanticColor` to `UIColor` and the equivalent mapping functions for `FontStyle`.

## Appearance Rule Set

An appearance rule set is a set of appearance rules obtained by using `UIAppearance` proxies.

```swift
AppearanceRuleSet {
    // UINavigationBar rules
    UINavigationBar[\.barTintColor, self.color(forSemanticColor: .background(.primary))]
    UINavigationBar[\.titleTextAttributes, [
        .font: self.font(forStyle: .caption(attribute: .regular)),
        .foregroundColor: self.color(forSemanticColor: .label(.primary))
        ]
    ]
    
    // UITabBar rules
    UITabBar[\.barTintColor, self.color(forSemanticColor: .background(.primary))]
    UITabBarItem[\.badgeColor, self.color(forSemanticColor: .fill(.primary))]
    UITabBarItem[
        get: { $0.titleTextAttributes(for: .selected) },
        set: { $0.setTitleTextAttributes($1, for: .selected) }
        value: [
            NSAttributedString.Key.font: self.font(forStyle: .caption(attribute: .regular)),
            NSAttributedString.Key.foregroundColor: self.color(forSemanticColor: .label(.primary))
        ]
    ]
}
```

This is an appearance rule set that customize the appearance of all the navigation bars, all the tab bars and tab bar items of the app. The DSL allows to create a rule by using `KeyPath` to the customizabe property of the `UIAppearance` object.

You can also group them with nested `AppearanceRuleSet`s:

```swift
AppearanceRuleSet {
    AppearanceRuleSet {
        UINavigationBar[\.barTintColor, self.color(forSemanticColor: .background(.primary))]
        UINavigationBar[\.titleTextAttributes, [
            .font: self.font(forStyle: .caption(attribute: .regular)),
            .foregroundColor: self.color(forSemanticColor: .label(.primary))
            ]
        ]
    }
            
    AppearanceRuleSet {
        UITabBar[\.barTintColor, self.color(forSemanticColor: .background(.primary))]
        UITabBarItem[\.badgeColor, self.color(forSemanticColor: .fill(.primary))]
        UITabBarItem[
            get: { $0.titleTextAttributes(for: .selected) },
            set: { $0.setTitleTextAttributes($1, for: .selected) }
            value: [
                NSAttributedString.Key.font: self.font(forStyle: .caption(attribute: .regular)),
                NSAttributedString.Key.foregroundColor: self.color(forSemanticColor: .label(.primary))
            ]
        ]
    }
}

```

the Appearance Rule DSL also support if and else statements.

Appearance Rule Sets are reversible. This means that you can revert your theme to default settings in runtime. 

If you don't need Global Appearance for your theme you can use the `.empty` appearance rule set.

## Setting up the theme
Once your Theme object is created, you are ready to use it. Assign your Theme to the ThemeContainer in your AppDelegate.

```swift
func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ThemeContainer.currentTheme = YourTheme()
}
```

**Gaudí** provides many UIKit extensions to easily access colors and fonts, and to easily configure labels, buttons and Strings (`NSAttributedString`). For example to setup a title label you can use

```swift
label.applyLabelStyle(.title(.regular), semanticColor: .label(.primary))
```

This will change the font (and size) and the color for the text of the `UILabel`. To obtain a color for a semantic color you can also use the UIColor extension: `UIColor.semanticColor(.fill(.primary))`

## Changing the theme

Similarly to the initialization of the default theme, from any point in your code you can switch the theme by using the `ThemeContainer.currentTheme` variable.

`ThemeContainer.currentTheme = YourOtherTheme()`

When this happens, Gaudí will automatically revert the previous theme `UIAppearance` rules, then will apply the new ones and call `applyTheme` on all `Themed` view controllers.

## Themed

For Gaudí to work properly in a multi theme app it's required to implement the `Themed` protocol in your themed view controllers. Without this protocol implementation, any existing instance of your non themed view controller will not change its appearance when the theme changes.

Put all your appearance customizations in the required `applyTheme` functions. For `UITableView`/`UICollectionView` cells, if you are customizing their appearance in the respective data source methods, then a simple `reloadData` in the `applyTheme` function will refresh their colors and fonts.

# Supporting Dark Mode with Gaudí

With Gaudí supporting Dark mode is extremely simple. There two different ways of supporting dark mode with this framework:

1. Implementing two different Themes and switching them when the `userInterfaceStyle` trait collection changes.
2. Implementing one unique Theme that returns dynamic colors.

We will explain now how to implement both.

## ThemedWindow

If you decide to go down the road of having two separate themes and switch them in runtime as needed, Gaudí offers a custom `UIWindow` that does just that. Initialise in your app delegate an instance of `ThemedWindow` by passing to it your Light mode theme and your dark mode theme.

Gaudí will take care of switching between the two themes as needed in runtime.

## Dynamic colors

If you decide to have one unique Theme for supporting both light and dark mode, then you will have to return dynamic colors in your Theme `color(forSemanticColor:)` mapping function. This framework offers convenience initializers for `UIColor` to support this use case:

`UIColor(lightColor: ..., darkColor: ...)`

and

`UIColor(lightColorHex: "#123456", darkColorHex: "#654321")`

