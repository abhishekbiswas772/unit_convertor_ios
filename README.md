# Unit Converter iOS App

A modern, SwiftUI-based unit converter application for iOS that supports length, weight, and temperature conversions.

## Project Origin

This project idea came from [roadmap.sh - Unit Converter Project](https://roadmap.sh/projects/unit-converter)

## Features

- **Three Conversion Categories**
  - Length (millimeter, centimeter, meter, kilometer, inch, foot, yard, mile)
  - Weight (milligram, gram, kilogram, ounce, pound)
  - Temperature (Celsius, Fahrenheit, Kelvin)

- **Modern iOS Design**
  - Card-based UI with rounded corners and shadows
  - Support for Light and Dark mode
  - Responsive layout with ScrollView
  - SF Symbols integration
  - Disabled button states for better UX

- **Real-time Conversion**
  - Accurate conversion algorithms
  - Support for decimal values
  - Clean result display showing both input and output

## Screenshots

The app features a clean, intuitive interface with:
- Segmented control for category selection
- Input field with numeric keyboard
- Dropdown pickers for unit selection
- Large, easy-to-read results
- Reset functionality for quick new conversions

## Technical Details

### Built With
- **SwiftUI** - Modern declarative UI framework
- **Swift 5+** - Programming language
- **iOS 16+** - Minimum deployment target

### Architecture
- **Item.swift** - Contains enums for units and conversion functions
- **ContentView.swift** - Main UI and conversion logic
- **unit_convertorApp.swift** - App entry point

### Conversion Logic

**Length Conversions**
- All conversions use meters as the base unit
- Supports metric (mm, cm, m, km) and imperial (inch, foot, yard, mile) units

**Weight Conversions**
- All conversions use kilograms as the base unit
- Supports metric (mg, g, kg) and imperial (ounce, pound) units

**Temperature Conversions**
- Uses Celsius as intermediate unit
- Direct conversion formulas:
  - Celsius ↔ Fahrenheit: `F = (C × 9/5) + 32`
  - Celsius ↔ Kelvin: `K = C + 273.15`

## Testing

The project includes comprehensive test coverage:

### Unit Tests (23 tests)
- Length conversion tests
- Weight conversion tests
- Temperature conversion tests
- Edge cases (zero values, large numbers, negative temperatures)

### UI Tests (14 tests)
- Conversion flow tests for all three categories
- Navigation and tab switching
- Reset functionality
- Button state validation
- Performance tests

### Launch Tests (7 tests)
- Launch verification in light/dark mode
- Screenshot generation for all tabs
- UI element validation

## Installation

1. Clone the repository
2. Open `unit_convertor.xcodeproj` in Xcode
3. Select your target device or simulator
4. Press `Cmd + R` to build and run

## Requirements

- Xcode 15.0+
- iOS 16.0+
- macOS 13.0+ (for development)

## Usage

1. **Select Category** - Choose between Length, Weight, or Temperature using the segmented control
2. **Enter Value** - Type the value you want to convert
3. **Select Units** - Choose the source and destination units from the dropdowns
4. **Convert** - Tap the Convert button to see your result
5. **Reset** - Use "Convert Another" to start a new conversion

## Project Structure

```
unit_convertor/
├── unit_convertor/
│   ├── ContentView.swift          # Main UI components
│   ├── Item.swift                 # Data models and conversion logic
│   ├── unit_convertorApp.swift    # App entry point
│   └── Assets.xcassets/           # App icons and images
├── unit_convertorTests/
│   └── unit_convertorTests.swift  # Unit tests
├── unit_convertorUITests/
│   ├── unit_convertorUITests.swift           # UI tests
│   └── unit_convertorUITestsLaunchTests.swift # Launch tests
└── README.md
```

## License

This project is created for educational purposes as part of the roadmap.sh project challenges.

## Acknowledgments

- Project inspiration: [roadmap.sh](https://roadmap.sh/projects/unit-converter)
- Built with SwiftUI and modern iOS development practices
