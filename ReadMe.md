# Weather Forecast App - Roomvu Challenge Task

## Description
    The Weather Forecast App is a simple iOS application that allows users to search for a location and display the current weather conditions, as well as a 5-day forecast for that location. The app integrates the OpenWeatherMap API to retrieve weather data.

## Features
    Location Search: Users can enter a location in the search bar. The app uses the CLGeocoder function from the Core Location framework to convert the location into geographic coordinates.
    Current Weather Display: The app displays the current weather conditions of the searched location, including temperature, weather description, humidity, and wind speed.
    5-Day Weather Forecast: The app also provides a 5-day weather forecast for the searched location, showing the date, weather icon, and temperature for each day.

## Error Handling 
    The app handles scenarios where the entered location is not found or there is an error in retrieving the weather data, displaying appropriate error messages to the user.

## How to Run
    Open the project in Xcode.
    Select the desired simulator or device.
    Click the Run button or press ⌘R.
    
## Unit Testing
    Unit tests are written to ensure the correctness of the data retrieval and parsing logic. To run the tests, select the test target and press ⌘U.

## Documentation
    This document provides a brief overview of the app’s functionality, how to run it, and any additional considerations or requirements.
    
## Additional Considerations
    Make sure you have the correct API key for the OpenWeatherMap API. The key should be stored securely and not included in the version control system.

## Endpoints Used
    Weather Icon Endpoint: https://openweathermap.org/img/wn/{IconCode}.png
    Current Weather Endpoint: https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    5 day / 3 Hour Forecast Endpoint: https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
    Direct geocoding Endpoint: http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}

## Refrences
    Current Weather Data Documents: https://openweathermap.org/current
    5 day / 3 Hour Forecast Documents: https://openweathermap.org/forecast5
    Direct geocoding Documents: https://openweathermap.org/api/geocoding-api

## Design
    The design for the search screen presents a simple list of city names with a location icon behind them. After each city’s selection, the app navigates back and refreshes the content.
