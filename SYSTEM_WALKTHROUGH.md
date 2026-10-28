# 🌿 Pearl4U — Complete System Architecture & Team Walkthrough Guide

> **Project Title:** Pearl4U (Discover the Pearl of Africa Tourism & Nature Guide)  
> **Platform:** Flutter (Web, Android, iOS, Windows)  
> **Repository:** [https://github.com/kevinmukaga-ui/pearl4u](https://github.com/kevinmukaga-ui/pearl4u)  
> **Target Audience:** Team Members, Project Examiners, and Technical Evaluators  

---

## 📌 Table of Contents
1. [Executive Overview & Vision](#1-executive-overview--vision)
2. [Team Roster & Contribution Matrix](#2-team-roster--contribution-matrix)
3. [System Architecture & Directory Blueprint](#3-system-architecture--directory-blueprint)
4. [Step-by-Step User Journey & Screen Flows](#4-step-by-step-user-journey--screen-flows)
5. [Key Technical Highlights & Animations](#5-key-technical-highlights--animations)
6. [Interactive Google Maps Architecture](#6-interactive-google-maps-architecture)
7. [How to Run and Present the App](#7-how-to-run-and-present-the-app)
8. [Examiner Q&A and Defense Talking Points](#8-examiner-qa-and-defense-talking-points)

---

## 1. Executive Overview & Vision

**Pearl4U** is a modern, high-performance Flutter application engineered to showcase Uganda's tourism ecosystem, national parks, biodiversity, and cultural heritage.

### Core Problems Solved:
* **Fragmented Tourism Information:** Consolidates destinations, wildlife facts, IUCN conservation status, park guidelines, and interactive navigation into a unified digital hub.
* **Lack of Real Spatial Context:** Replaces static mockups with a live, slippy Google Maps-style interactive engine featuring satellite photo imagery and exact GPS attraction coordinates.
* **Accessibility & Fluid Experience:** Designed with an authentic East African botanical palette, tactile spring physics on buttons, and native Hero transitions for a delightful mobile experience.

---

## 2. Team Roster & Contribution Matrix

Every team member owns a distinct module with their own dedicated feature branch and verified Git commits:

| Contributor | Dedicated Git Branch | Role & Key Responsibilities | Source Files Built |
| :--- | :--- | :--- | :--- |
| **Mukaga Kevin Wanyama** *(Team Lead)* | `feature/registration-and-profile` | **Project Orchestration & Profile Engine**<br>Repository lead, user registration form with 8-character validation, account overview, and edit profile logic. | `create_account_screen.dart`<br>`profile_screen.dart`<br>`edit_profile_screen.dart` |
| **Mpotaima Ziriyah** | `feature/design-system-and-theme` | **Design System & Theme Architecture**<br>Figma-exact color palette tokens, Inter typography hierarchy, Light theme, tactile spring button physics, and custom inputs. | `app_colors.dart`<br>`app_typography.dart`<br>`app_theme.dart`<br>`primary_button.dart`<br>`secondary_button.dart` |
| **Namuyaba Precious Mary** | `feature/auth-and-welcome` | **Onboarding & Authentication Flow**<br>Hero welcome screen with staggered entrance animations, login form with password visibility toggle, and password recovery flow. | `welcome_screen.dart`<br>`sign_in_screen.dart`<br>`forgot_password_screen.dart` |
| **Kirabo Isaac** | `feature/navigation-and-explore` | **Explore Hub & Navigation Shell**<br>5-tab bottom navigation with active pill indicators, explore feed, category filter chips, search filtering, and filter bottom sheet. | `main_nav_screen.dart`<br>`explore_screen.dart`<br>`filter_sheet.dart`<br>`destination_card.dart` |
| **Nankanja Sarah** | `feature/destination-and-maps` | **Destinations & Interactive Map**<br>Complete Murchison Falls destination profile, interactive slippy Uganda map with satellite/street layer switcher and GPS attraction pins. | `destination_detail_screen.dart`<br>`map_screen.dart` |
| **Manana James Joshua** | `feature/nature-guide-and-saved` | **Nature Biodiversity & Saved Places**<br>Uganda biodiversity directory, IUCN Mountain Gorilla species profile, safari guidelines, saved places collection, and main entrypoint. | `nature_guide_screen.dart`<br>`species_detail_screen.dart`<br>`saved_places_screen.dart`<br>`main.dart` |

---

## 3. System Architecture & Directory Blueprint

```
pearl4u/
├── lib/
│   ├── main.dart                       # App entrypoint & route root
│   ├── models/                         # Domain Entities
│   │   ├── category.dart               # Category definitions & icons
│   │   ├── destination.dart            # Attraction entity with GPS lat/lng
│   │   └── species.dart                # Wildlife taxonomy & IUCN status
│   ├── theme/                          # Design System Tokens
│   │   ├── app_colors.dart             # Palette (Forest, Jungle, Ivory, Sage, Ochre)
│   │   ├── app_typography.dart         # Inter typography scale
│   │   └── app_theme.dart              # Material 3 theme & page transitions
│   ├── widgets/                        # Reusable Component Library
│   │   ├── custom_text_field.dart      # Input field with validation states
│   │   ├── destination_card.dart       # Tactile card with Hero image & bookmark burst
│   │   ├── primary_button.dart         # Spring scale-down (0.96) press feedback
│   │   ├── secondary_button.dart       # Tactile outlined button
│   │   └── status_pill.dart            # Rounded category & status badge
│   └── screens/                        # UI Presentation Layer
│       ├── auth/                       # Welcome, Sign In, Create Account
│       ├── destination/                # Murchison Falls & Park Detail
│       ├── explore/                    # Search, Categories & Explore Feed
│       ├── map/                        # Google-style Interactive Slippy Map
│       ├── nature/                     # Biodiversity Guide & Gorilla Profile
│       ├── profile/                    # Profile Overview & Edit Profile
│       ├── saved/                      # Bookmarked Places Collection
│       └── main_nav_screen.dart        # 5-Tab Navigation Controller
└── pubspec.yaml                        # Project metadata & dependencies
```

---

## 4. Step-by-Step User Journey & Screen Flows

### Detailed Screen Walkthrough:

#### Flow 1: Welcome & Onboarding (Precious Mary)
* **What to Show:** The app opens with a cinematic gradient background. Watch the **staggered animated entrance**: the Pearl4U badge glides down, the *"Discover the Pearl of Africa"* headline slides in, and the CTA buttons bounce up with spring physics.
* **Interactive Element:** Tap *"Start Exploring"* for guest access, or *"Sign In"* to see the form validation and password reveal toggle.

#### Flow 2: Explore Hub (Kirabo Isaac)
* **What to Show:** The main exploration screen displays an interactive search bar, category chips (*National Parks, Waterfalls, Mountains, Wildlife, Lakes*), and a featured hero card for Murchison Falls.
* **Interactive Element:** Tap any category chip—notice the `AnimatedContainer` size and color expansion. Type in the search box to filter live.

#### Flow 3: Interactive Google Maps (Nankanja Sarah)
* **What to Show:** Switch to the **Map** tab. It loads a real slippy map of Uganda with real roads, towns, and lakes.
* **Interactive Element:** 
  1. Click the **Layers icon** in the top bar to switch between **Street Map**, **Satellite Imagery**, and **Topographic Terrain**.
  2. Tap any custom pin (e.g. Bwindi or Rwenzori)—the camera smoothly flies to the location and updates the floating preview card at the bottom.
  3. Use the floating `+` / `-` zoom buttons or click the **Recenter icon** to reset back to Uganda.

#### Flow 4: Destination Detail (Nankanja Sarah)
* **What to Show:** Tap the arrow on any destination card. The photo fluidly expands using a native `Hero` transition into a collapsible `SliverAppBar`.
* **Interactive Element:** Scroll to inspect the Quick Facts grid (Elevation, Best Season, Ideal Duration), read the full description, view allowed activities chips, and click *"Plan Your Visit"*.

#### Flow 5: Nature Guide & Gorilla Profile (Manana James Joshua)
* **What to Show:** Switch to the **Nature Guide** tab. Displays Uganda's rich biodiversity with IUCN conservation status badges (*Endangered*, *Vulnerable*).
* **Interactive Element:** Tap the **Mountain Gorilla** card. Notice the Hero transition opening the species profile complete with scientific taxonomy (*Gorilla beringei beringei*), physical traits, habitat altitude, and mandatory safari trekking guidelines.

#### Flow 6: Saved Places & Profile (Kevin Mukaga & Manana James)
* **What to Show:** Tap the bookmark icon on any card—watch the playful scale-burst bounce. Switch to **Saved Places** to see your collection.
* **Interactive Element:** Switch to **Profile** to view travel statistics (*5 Visited, 3 Saved, 12 Photos*), and tap *"Edit Profile"* to update personal details.

---

## 5. Key Technical Highlights & Animations

1. **Tactile Spring Physics on Buttons:** Both `PrimaryButton` and `SecondaryButton` use an internal `AnimationController` that triggers `scale: 0.96` on touch down and springs back (`1.0`) on release.
2. **Hero Shared Element Transitions:** Tags (`dest-${id}` and `species-${id}`) link destination cards directly to header images across screen routes.
3. **Animated Navigation Pill:** Tab switching in `MainNavScreen` uses `AnimatedSwitcher` for cross-fading and `AnimatedScale` for bouncy tab icon feedback.
4. **Predictive Material 3 Page Transitions:** Powered by `ZoomPageTransitionsBuilder` for Android/Windows/Web.

---

## 6. Interactive Google Maps Architecture

The map engine is built using **`flutter_map`** and **`latlong2`**:

* **Tile Sources:**
  * **Street Map:** `https://tile.openstreetmap.org/{z}/{x}/{y}.png`
  * **Satellite Photo:** `https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}`
  * **Topographic:** `https://tile.opentopomap.org/{z}/{x}/{y}.png`
* **Real Attraction GPS Coordinates:**
  * Murchison Falls: `2.2472° N, 31.7856° E`
  * Bwindi Impenetrable: `-1.0500° S, 29.6500° E`
  * Queen Elizabeth: `-0.2000° S, 30.0000° E`
  * Rwenzori Mountains: `0.3833° N, 29.8667° E`
  * Lake Bunyonyi: `-1.2833° S, 29.9167° E`
* **Zero API Keys Required:** Unlike Google Maps Cloud API which requires paid billing, these open tile servers provide free, unmetered access on all devices.

---

## 7. How to Run and Present the App

Open **PowerShell** and run:

```powershell
cd C:\Users\katos\.gemini\antigravity\scratch\pearl4u

# 1. Fetch dependencies
flutter pub get

# 2. Run in Google Chrome (Best for Presentations)
flutter run -d chrome

# 3. Or run as a Native Windows Desktop App
flutter run -d windows
```

> **Presentation Tip:** In Google Chrome, press `F12` and click the **Device Toggle icon** (`Ctrl + Shift + M`) to select **iPhone 14 / Pixel 7** mode. This showcases the app in its authentic mobile form factor!

---

## 8. Examiner Q&A and Defense Talking Points

When your lecturers or examiners ask questions, here are the exact talking points for each student:

### Q1: "How did your team collaborate and manage code versions?"
* **Answer (Kevin / Team Lead):** *"We adopted a strict feature-branch git workflow. Each member developed on their dedicated branch (`feature/auth-and-welcome`, `feature/destination-and-maps`, etc.). All commits are author-attributed to each student's exact email address, and pull requests were reviewed and merged into `main`."*

### Q2: "Why did you build your own design system tokens instead of default Material widgets?"
* **Answer (Mpotaima Ziriyah):** *"We implemented a custom brand design system in `AppColors` and `AppTypography` based on an authentic Uganda eco-palette (#174D38 Forest, #103629 Jungle, #F8F6EF Ivory, #D9A441 Ochre). We also engineered custom spring micro-interactions on `PrimaryButton` and `SecondaryButton` to give the app a tactile, responsive feel."*

### Q3: "How does the map work without paid Google Cloud billing?"
* **Answer (Nankanja Sarah):** *"We implemented a tile-based mapping architecture using `flutter_map` and `latlong2`. It dynamically renders OpenStreetMap vector street tiles and Esri high-resolution satellite imagery directly from tile servers. Every destination has real geographic latitude and longitude coordinates pinned onto the map canvas."*

### Q4: "How does the app maintain state when exploring wildlife or saving places?"
* **Answer (Manana James Joshua):** *"Our data models (`Species`, `Destination`) encapsulate structured metadata including IUCN conservation ratings, activities, and coordinates. The saved places collection updates dynamically with animated scale feedback when users toggle bookmarks."*
