# Daily Quote App

This is a Flutter application that displays daily quotes fetched from a JSON file. The app features the ability to copy quotes to the clipboard and an elevated button to display the next quote.

## Features

- Fetches quotes from a JSON file
- Displays the quote on the screen
- Allows copying the quote to the clipboard
- Elevated button to display the next quote

## Getting Started

To run this app locally, follow these steps:

1. Clone the repository:

```
git clone https://github.com/Piyu-Pika/codsoft_quote_modle.git
```

2. Navigate to the project directory:

```
cd codsoft_quote_modle
```

3. Install the required dependencies:

```
flutter pub get
```

4. Run the app:

```
flutter run
```

## Dependencies

This app uses the following dependencies:

- `flutter/material.dart`: The Material Design library for building user interfaces.
- `flutter/services.dart`: Provides low-level services for interacting with the operating system, such as the clipboard.

## JSON File Structure

The app expects a JSON file with the following structure:

\`\`\`json
[
 {
   "quote": "Quote 1",
   "author": "Author 1"
 },
 {
   "quote": "Quote 2",
   "author": "Author 2"
 },
 ...
]
\`\`\`

Each object in the JSON array should have a `quote` and an `author` property.

## Contributing

If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
