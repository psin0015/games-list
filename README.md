# Games List

The Games List app displays a list of games retrieved from the internet.

## Design Considerations

- MVVM architecture is chosen for the project to improve project code clarity and testability. If the project size was large and had a lot of components, then other design patterns like VIPER would have been better.
- As the list returned by the API is large (~1800 elements), lazy loading and caching of the image was needed to improve startup performance.
- A separate Network client class was created as the app requires more than one API call. It would also help in testing.
- Custom Cells were created for table view in a separate folder to increase code modularisation and reusability in the future.
- Separate file containing app constants is created to avoid code duplication. 

## Further App improvements
### The app can be further improved by adding the following features:
- Writing Unit test cases using mock API data.
- Writing more UI test cases.
- Implementing a search functionality in the table view.
- Storing of the game list in persistent storage, and only calling the API when the user refreshes the list using pull to refresh or a similar function.
- Implementing a logic to display a partial number of games in the table view initially and increasing the games list upon user scroll.
- Displaying more insightful information in the table view list by retrieving it from API.
