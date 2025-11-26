# Cart Modification Feature Requirements

## 1. Feature Description and Purpose

The Cart Modification feature enables users of the Sandwich Shop Flutter app to manage the contents of their cart before checkout. Users can adjust the quantity of each sandwich or remove items. Editing sandwich details (such as bread type or size) is not supported on the cart page; users must add a new item from the order screen if they wish to change sandwich options. This feature aims to provide a flexible and user-friendly shopping experience, ensuring users can easily correct mistakes or change their order without starting over.

---

## 2. User Stories

### 2.1. Adjust Quantity

- **As a user**, I want to increase or decrease the quantity of a sandwich in my cart, so I can order the exact number I want.
- **As a user**, I want the cart to automatically remove an item if I decrease its quantity below 1, so my cart never contains items with zero or negative quantity.

### 2.2. Remove Item

- **As a user**, I want to remove a sandwich from my cart with a single action, so I can quickly update my order if I change my mind.

### 2.3. Feedback and UI Responsiveness

- **As a user**, I want the cart and total price to update immediately when I make changes, so I always see an accurate summary of my order.
- **As a user**, I want to receive feedback (such as a snackbar) when I remove or update an item, so I know my action was successful.
- **As a user**, I want to see a clear message if my cart is empty, so I know I need to add items before checking out.

---

## 3. Acceptance Criteria

### 3.1. Quantity Adjustment

- [ ] Each cart item displays "+" and "–" buttons for quantity adjustment.
- [ ] Tapping "+" increases the quantity by 1.
- [ ] Tapping "–" decreases the quantity by 1.
- [ ] If the quantity is reduced below 1, the item is removed from the cart.
- [ ] The total price updates automatically and accurately.
- [ ] The UI updates immediately to reflect changes.

### 3.2. Remove Item

- [ ] Each cart item has a "Remove" button (e.g., trash icon).
- [ ] Tapping "Remove" deletes the item from the cart.
- [ ] The total price updates accordingly.
- [ ] A snackbar or similar feedback is shown when an item is removed.

### 3.3. General UI and Behavior

- [ ] All changes are reflected immediately in the UI.
- [ ] The cart's total price is always accurate.
- [ ] The cart handles empty states gracefully (e.g., displays a message if empty).
- [ ] The UI prevents negative quantities.
- [ ] User feedback is provided for all cart modification actions.

---

## 4. Subtasks

1. Implement "+" and "–" quantity adjustment buttons for each cart item.
2. Implement logic to remove an item if its quantity is reduced below 1.
3. Add a "Remove" button for each cart item.
4. Ensure the total price and UI update immediately after any change.
5. Provide user feedback (snackbar) for remove and update actions.
6. Handle empty cart states with a clear message.

---

## 5. Profile Screen (New)

The app will include a simple Profile screen where users can enter/view their name, email, and phone number. No authentication or persistence is required for now — the screen only keeps state while it's open and shows confirmation feedback when the user taps "Save".

### User Stories
- As a user, I want to enter my name, email, and phone number so I can view or edit my basic profile details.
- As a user, I want feedback (snackbar) when I save my profile so I know the action succeeded.

### Acceptance Criteria
- [ ] A Profile screen exists with text fields for name, email, and phone.
- [ ] Fields have testable keys/labels.
- [ ] A "Save" button shows a snackbar confirming the save.
- [ ] No backend/authentication/persistence is required for this exercise.
- [ ] The screen is accessible from the app (a link will be added to the Order screen in the next exercise).

### AI Prompt (used to implement this feature)
"Add a Profile screen to the Flutter app with text fields for name, email, and phone, a Save button that shows a snackbar (no persistence), and expose test keys for each field and the save action. Also add a widget test that enters text into the fields and verifies the snackbar appears after tapping Save."

---

## 6. Navigation Drawer (New)

Add a reusable navigation Drawer that exposes the app's main destinations (Order, Cart, Profile, About). The drawer should be accessible from screens that include it. Where possible reuse a single Drawer widget to avoid duplicating UI code.

### User Stories
- As a user, I want a consistent navigation panel accessible from screens so I can move between Order, Cart, Profile, and About quickly.
- As a developer, I want a single reusable Drawer widget so I don't repeat navigation code across screens.

### Acceptance Criteria
- [ ] A reusable AppDrawer widget exists and contains navigation items for Order, Cart, Profile, and About.
- [ ] Screens include the AppDrawer via their Scaffold.drawer property (at least Cart and Profile are updated).
- [ ] Drawer items have testable keys.
- [ ] Tapping a drawer item navigates to the correct route.
- [ ] Widget tests cover opening the drawer and verifying its menu items.

### Notes on implementation and responsiveness
- Drawer widgets are provided to a Scaffold via the drawer property. The AppBar will automatically show the menu icon when a drawer is present.
- To reduce redundancy, create one AppDrawer widget and include it in screens via drawer: const AppDrawer().
- For responsive behavior you can show a permanent NavigationRail or a side menu at wider screen widths and the Drawer for mobile widths (this can be implemented later by conditionally selecting Drawer vs a side rail based on MediaQuery width).

### AI Prompt (used to implement this feature)
"Add a reusable AppDrawer widget to the Flutter app with navigation ListTiles for Order, Cart, Profile, and About (each with test keys). Include the drawer on Cart and Profile screens. Register '/cart' and '/profile' routes in main.dart. Write widget tests that open the drawer and verify menu items exist."