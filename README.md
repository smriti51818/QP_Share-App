# 📘 Campus Question Papers

A simple Flutter app for sharing college question papers locally. Perfect for students to organize and browse question papers by semester, regulation, and subject.

## ✨ Features

- ✅ **Student Login** - Simple login with name and roll/register number
- ✅ **Upload Question Papers** - Add papers with subject, semester, regulation, exam type, and year
- ✅ **Browse Papers** - View all uploaded question papers in a clean card layout
- ✅ **Filter Papers** - Filter by Semester, Regulation, or Subject
- ✅ **Delete Papers** - Remove papers you no longer need
- ✅ **User Profile** - View logged-in user information
- ✅ **Logout** - Easy logout functionality
- ✅ **Local Storage** - All data saved locally using SharedPreferences
- ✅ **No Backend Required** - Works completely offline

## 🏗 Project Structure

```
lib/
 ├── main.dart                    # App entry point with routing
 ├── models/
 │   ├── question_paper.dart     # Question paper data model
 │   └── user.dart               # User/Student data model
 ├── screens/
 │   ├── login_screen.dart       # Login screen with name and roll number
 │   └── home_screen.dart        # Main screen with filters and list
 └── widgets/
     ├── paper_list.dart         # Widget to display paper cards
     ├── add_paper.dart          # Form to add new papers
     └── filter_section.dart     # Filter dropdowns widget
```

## 📦 Dependencies

- `file_picker` - For selecting PDF files
- `shared_preferences` - For saving data locally

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device / iOS simulator

### Installation Steps

1. **Clone or download this project**

2. **Navigate to project directory**
   ```bash
   cd QP_Share
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

   Or use your IDE:
   - **VS Code**: Press `F5` or click "Run and Debug"
   - **Android Studio**: See detailed instructions below

## 🎯 Running in Android Studio

### Step 1: Open the Project
1. Launch **Android Studio**
2. Click **"Open"** or **"File" → "Open"**
3. Navigate to your project folder (`QP_Share`) and select it
4. Click **"OK"** to open the project
5. Wait for Android Studio to index the project and sync Gradle files

### Step 2: Install Flutter & Dart Plugins (if not already installed)
1. Go to **"File" → "Settings"** (or **"Android Studio" → "Preferences"** on Mac)
2. Navigate to **"Plugins"**
3. Search for **"Flutter"** and install it (this will also install the Dart plugin)
4. Click **"Apply"** and restart Android Studio if prompted

### Step 3: Configure Flutter SDK
1. Go to **"File" → "Settings" → "Languages & Frameworks" → "Flutter"**
2. Set the **Flutter SDK path** (e.g., `C:\src\flutter` on Windows or `/Users/username/flutter` on Mac)
3. Click **"Apply"** and **"OK"**

### Step 4: Install Dependencies
1. Open the **Terminal** in Android Studio (bottom panel or **View → Tool Windows → Terminal**)
2. Run the following command:
   ```bash
   flutter pub get
   ```
3. Wait for dependencies to be installed

### Step 5: Set Up Android Emulator or Connect Physical Device

**Option A: Using Android Emulator**
1. Click the **Device Manager** icon in the toolbar (or **Tools → Device Manager**)
2. Click **"Create Device"** if you don't have an emulator
3. Select a device (e.g., Pixel 5) and click **"Next"**
4. Download a system image (e.g., Android 13) and click **"Next"**
5. Click **"Finish"** to create the emulator
6. Click the **Play** button next to your emulator to start it
7. Wait for the emulator to boot completely

**Option B: Using Physical Android Device**
1. Enable **Developer Options** on your Android device:
   - Go to **Settings → About Phone**
   - Tap **"Build Number"** 7 times
2. Enable **USB Debugging**:
   - Go to **Settings → Developer Options**
   - Enable **"USB Debugging"**
3. Connect your device via USB cable
4. Accept the **"Allow USB Debugging"** prompt on your device
5. Verify connection: In terminal, run `flutter devices` - your device should appear

### Step 6: Run the App
1. Make sure your emulator is running or your physical device is connected
2. Select your device from the device dropdown (top toolbar, next to the run button)
3. Click the green **"Run"** button (▶️) in the toolbar, or press **Shift + F10**
4. Alternatively, right-click on `lib/main.dart` and select **"Run 'main.dart'"**
5. Wait for the app to build and launch on your device/emulator

### Step 7: Verify the App is Running
- The app should launch and show the **Login Screen**
- You can now test all features of the app

### Troubleshooting Android Studio Issues

**Issue: "Flutter SDK not found"**
- Solution: Install Flutter SDK and set the path in Android Studio settings

**Issue: "No devices found"**
- Solution: Start an emulator or connect a physical device with USB debugging enabled

**Issue: "Gradle sync failed"**
- Solution: Go to **File → Invalidate Caches → Invalidate and Restart**

**Issue: "Build failed"**
- Solution: Run `flutter clean` in terminal, then `flutter pub get`, then try running again

**Issue: "Dependencies not found"**
- Solution: Run `flutter pub get` in the terminal

## 📱 How to Use

### Login

1. When you first open the app, you'll see the **Login Screen**
2. Enter your details:
   - **Name**: Your full name (e.g., "John Doe")
   - **Roll Number / Register Number**: Your roll number or register number (e.g., "21CS001" or "REG12345")
3. Tap the **"Login"** button
4. You'll be taken to the home screen where you can manage question papers
5. Your login information is saved locally - you won't need to login again unless you logout

### Logout

1. Tap the **user icon** (account circle) in the top right corner of the home screen
2. Select **"Logout"** from the menu
3. Confirm logout in the dialog
4. You'll be returned to the login screen

### Viewing User Information

1. Tap the **user icon** in the top right corner
2. Your name and roll number will be displayed at the top of the menu

### Adding a Question Paper

1. Tap the **+ (plus)** floating action button at the bottom right
2. Fill in the form:
   - **Subject Name**: Enter the subject (e.g., "Data Structures")
   - **Semester**: Select from dropdown (Sem 1 to Sem 8)
   - **Regulation**: Select regulation (R2019, R2021, R2023, R2024)
   - **Exam Type**: Choose Mid, End, or Model
   - **Year**: Enter the year (e.g., 2022)
   - **PDF File**: Tap "Select PDF File" to choose a PDF from your device
3. Tap **"Add Paper"** button
4. The paper will appear in the list!

### Filtering Papers

Use the filter section at the top:
- **Semester**: Filter by specific semester
- **Regulation**: Filter by regulation
- **Subject**: Filter by subject name

Select "All" from any dropdown to clear that filter.

### Deleting a Paper

1. Find the paper you want to delete in the list
2. Tap the **delete icon** (trash) on the paper card
3. Confirm deletion in the dialog

## 🎨 UI Features

- **Material Design 3** - Modern, clean interface
- **Card Layout** - Easy-to-read paper cards with badges
- **Empty State** - Helpful message when no papers match filters
- **Color-coded Badges** - Visual indicators for semester, regulation, and exam type
- **Responsive** - Works on phones and tablets

## 💾 Data Storage

- All question paper metadata is saved in **SharedPreferences**
- PDF files are referenced by their local file path
- Data persists between app restarts
- No internet connection required

## 🛠 Technical Details

- **State Management**: `setState` (beginner-friendly)
- **Null Safety**: Enabled
- **Platform Support**: Android, iOS, Windows, macOS, Linux
- **File Support**: PDF files only

## 📝 Question Paper Fields

Each question paper includes:
- **Subject Name** (String)
- **Semester** (e.g., Sem 1, Sem 2)
- **Regulation** (e.g., R2019, R2021)
- **Exam Type** (Mid / End / Model)
- **Year** (e.g., 2022)
- **PDF File Path** (local storage path)

## 🐛 Troubleshooting

### App won't run
- Make sure Flutter is installed: `flutter doctor`
- Run `flutter pub get` to install dependencies
- Check that you have a device/emulator connected: `flutter devices`

### File picker not working
- Make sure you've granted storage permissions on your device
- On Android, check app permissions in Settings

### Data not persisting
- SharedPreferences should save automatically
- If data is lost, check device storage space

## 📚 Learning Resources

This app is designed for beginners to learn:
- Flutter basics (Widgets, State, Navigation)
- Form handling and validation
- File picking
- Local data storage
- Filtering and searching
- Material Design UI

## 🔮 Future Enhancements (Optional)

- PDF viewer integration
- Search functionality
- Export/Import data
- Categories/Tags
- Favorites/Bookmarks
- Share papers with other apps

## 📄 License

This project is open source and available for educational purposes.

## 👨‍💻 For Students

This codebase is written with:
- Clear comments explaining each section
- Simple, readable function names
- Beginner-friendly patterns
- No complex state management
- Straightforward logic flow

Perfect for learning Flutter development! 🎓

---

**Happy Learning!** 🚀

#   Q P _ S h a r e - A p p 
 
 
