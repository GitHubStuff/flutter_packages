# widget_size

Get the height/width (aka Size) of a widget

### This should be used sparingly during development as these calls add overhead to rendering

## Usage

```dart
Size textSize;
WidgetSize(
  onChange: (Size size) {
    setState(() {
      textSize = size;
    });
  },
  child: Text(
    "Size - $textSize",
    textAlign: TextAlign.center,
  ),
),
```

The 'Text' widget is a child of 'WidgetSize' and will publish it's size as the 'onChange' updates the information.

## Special Note

Be kind to each other.
