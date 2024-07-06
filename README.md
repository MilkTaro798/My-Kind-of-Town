# My Kind of Town

My Kind of Town is a map-based iOS application that highlights interesting landmarks in Chicago. It utilizes MapKit for displaying points of interest on the map and various Foundation classes for managing the associated data for each location. The app is designed to adapt to different screen sizes and orientations.

## Features

- Displays a full-screen map view with custom points of interest in Chicago
- Excludes default Apple-provided points of interest
- Includes a partially transparent HUD (heads-up display) view to show details of a selected point of interest
- Allows users to mark a place as a favorite using a star button
- Provides a "Favorite Places" button to view a list of the user's favorite places
- Implements a custom protocol for communication between the map view and favorites view
- Utilizes adaptive layout techniques for optimal viewing in both portrait and landscape orientations
- Persists user's favorite places using UserDefaults

## Screenshots

<p float="left">
  <img src="https://github.com/MilkTaro798/My-Kind-of-Town/blob/main/Simulator%20Screenshot-1.png" width="30%" />
  <img src="https://github.com/MilkTaro798/My-Kind-of-Town/blob/main/Simulator%20Screenshot-2.png" width="30%" /> 
  <img src="https://github.com/MilkTaro798/My-Kind-of-Town/blob/main/Simulator%20Screenshot-3.png" width="30%" />
</p>

<img src="https://github.com/MilkTaro798/My-Kind-of-Town/blob/main/Simulator%20Screenshot-4.png" width="60%" />

## Project Structure

- `MapViewController`: Displays the main map view and handles user interactions
- `FavoritesViewController`: Displays a list of the user's favorite places
- `Place`: A custom `MKPointAnnotation` subclass for representing points of interest
- `PlaceMarkerView`: A custom `MKMarkerAnnotationView` subclass for styling the map markers
- `DataManager`: A singleton class for handling data processing and storage
- `PlacesFavoritesDelegate`: A custom protocol for communication between `MapViewController` and `FavoritesViewController`

## Author

- Name: Yutong Sun
- Email: milktaro798@gmail.com

## Credits

- Map icon: https://iconduck.com/icons/48313/map
- Tutorial reference: https://www.youtube.com/watch?v=P7NzSWVIlWI
- Swipe-to-delete functionality: https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells