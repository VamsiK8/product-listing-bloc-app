# 🛍 Product Listing App (Flutter + BLoC)

A Flutter application that fetches and displays products from a public API using **flutter_bloc** for state management.

API Used:
https://fakestoreapi.com/products

---

## 🚀 Features

### 📦 Product Listing
- Fetch products from API
- Display product image, title, and price
- Proper state handling:
  - Initial
  - Loading
  - Loaded
  - Error
- Pull-to-refresh support
- Pagination (load more on scroll)
- Search functionality

### 📄 Product Detail Screen
- Product image
- Title
- Description
- Price
- Rating

### 🛒 Cart Feature
- Add to cart
- Remove from cart
- Prevent duplicate products
- Cart badge count in AppBar
- Dedicated Cart screen
- Separate CartBloc for cart management

---

## 🏗 Architecture

This project follows a **feature-based clean architecture** and proper separation of concerns.
```plaintext
lib/
 ├── main.dart
 │
 ├── core/
 │    ├── constants/
 │    ├── utils/
 │
 ├── features/
 │
 │    ├── products/
 │    │
 │    │    ├── data/
 │    │    │     ├── models/
 │    │    │     │     └── product_model.dart
 │    │    │     ├── repository/
 │    │    │           └── product_repository.dart
 │    │    │
 │    │    ├── presentation/
 │    │          ├── bloc/
 │    │          │     ├── product_bloc.dart
 │    │          │     ├── product_event.dart
 │    │          │     └── product_state.dart
 │    │          │
 │    │          ├── screens/
 │    │          │     ├── product_list_screen.dart
 │    │          │     └── product_detail_screen.dart
 │    │
 │    ├── cart/
 │         ├── presentation/
 │         │     ├── bloc/
 │         │     │     ├── cart_bloc.dart
 │         │     │     ├── cart_event.dart
 │         │     │     └── cart_state.dart
 │         │     │
 │         │     ├── screens/
 │         │     │     └── cart_screen.dart
 ```

### 🔹 State Management
- flutter_bloc
- Business logic handled inside Bloc
- API logic handled inside Repository
- UI reacts only to state changes
- No API calls inside UI layer

---

## 🔄 State Flow

### Product Flow

UI → ProductBloc → Repository → API  
API → Repository → Bloc → UI

### Cart Flow

UI → CartBloc → Updated State → UI

---

## 📦 Dependencies

- flutter_bloc
- equatable
- http

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the repository

git clone https://github.com/VamsiK8/product-listing-bloc-app.git


### 2️⃣ Navigate to project folder



cd product-listing-bloc-app


### 3️⃣ Install dependencies



flutter pub get


### 4️⃣ Run the application



flutter run


---

## 📌 Assumptions

- FakeStore API returns consistent product structure.
- Pagination implemented using the `limit` parameter.
- Cart data is stored in-memory (not persisted).
- No authentication required.

---

## 🧠 Key Implementation Highlights

- Feature-based folder structure
- Repository pattern
- Separate Blocs for Products and Cart
- ID-based product comparison to prevent duplicates
- ScrollController used only for pagination lifecycle
- Clean separation between UI and business logic

---

## 👨‍💻 Author

Vamsi Kosuri

GitHub: https://github.com/VamsiK8

