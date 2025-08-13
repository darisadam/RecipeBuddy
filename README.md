# RecipeBuddy <br />

## Version
1.0.0

[![Watch the video](https://img.youtube.com/vi/ow9oIM9iSjM/maxresdefault.jpg)](https://youtu.be/ow9oIM9iSjM)<br />

Video: https://drive.google.com/file/d/166_b8sJLNjBtSsBta3isilyT14-xbCc_/view?usp=sharing<br />
GitHub: https://github.com/darisadam/RecipeBuddy<br />
TestFlight: https://testflight.apple.com/join/4cfU6EVZ (waiting for approval from the App Store)<br />

## How To Run
Download and unzip this application, then run it using Xcode.<br />
or<br />
Download via TestFlight (still pending approval on the App Store)<br />

## Architecture
The development of this application implements the MVVM pattern, where there is a model that contains the entity framework/data objects in the application. This application also implements simple dependency injection using EnvironmentObject.<br />

Furthermore, the ViewModel section functions to store logic and communication channels between data storage, services, and others with the view.<br />

In addition, there are Services that will help ViewModel to obtain information from local files and remote data. There are also Utilities that contain support logic such as calculations, constants, etc.<br />

The View component contains the interface that users see and interact with. Data changes are automatically synchronized by the view using concurrency methods. There are also Reusable views that contain view components used repeatedly across various views.<br />

## Feature
### Level 1:
- Home list: load recipes from bundled recipes.json; show thumbnail, title, tags, and estimated time.
- Detail screen: show image, ingredients, and step-by-step method; allow checking ingredients as obtained (UI state only is fine).
- Search and empty states: search by title or ingredient; display friendly empty/error states.
- Favorites (persisted): toggle favorite in list and detail; persist across launches (UserDefaults).
- Architecture and state: MVVM; use async/await.

### Level 2:
- Sort and filter: sort by time (asc/desc) and filter by tags.
- Offline-first: default to bundled JSON. Add a data-source switch to load from a remote JSON URL (GitHub raw). On failure, gracefully fall back to bundled data.
- Caching: basic image caching.

### Level 3:
- Meal plan and shopping list: let users add recipes to “This Week’s Plan”; generate a consolidated shopping list that merges duplicate ingredients and quantities.
- Share: share the shopping list via the system share sheet.

## Future Development (with More Time)
- User generated content, user can add their custom recipe.
- Using LLM API to generate new recipe with ingredients and step-by-step.
- Categorizing shopping category to make user easier to find products when shopping.
- Convert non-standard weight unit (such as tbsp, etc.) to standard weight unit (such as gram, ml, etc).
- Add shopping list checkbox.
- Separate breakfast, lunch, and dinner inside meal plan.
- Add calorie counter, colaborate or use Calorie API.
- Cloud storage, save data using iCloud.
- Improve UI such as Design, Color, etc.
