# Pearl4U - Discover the Pearl of Africa 🇺🇬

An interactive Flutter tourism discovery and nature guide application built directly from the **Pearl4U Figma Design System**.

---

## 🎨 Design System & Visual Tokens

Pearl4U uses an authentic, nature-inspired visual system extracted from Figma:

| Token | Hex | Role |
| :--- | :--- | :--- |
| **Forest** | `#174D38` | Primary brand actions, buttons, active navigation indicator |
| **Jungle** | `#103629` | Editorial page titles, dark headings, high-contrast surfaces |
| **Ivory** | `#F8F6EF` | Warm app scaffold background |
| **Sage** | `#DCE8DA` | Category tags, quiet highlights, subtle indicators |
| **Ochre** | `#D9A441` | Editorial badges ("FEATURED", "IUCN Endangered"), rating stars |
| **Charcoal** | `#252B27` | Primary body typography and captions |
| **White** | `#FFFFFF` | Cards, text inputs, bottom navigation bar |

---

## 📱 App Structure & Screen Modules

```text
lib/
├── main.dart                                # Application entrypoint
├── models/
│   ├── category.dart                       # Destination categories (Parks, Waterfalls, Lakes, etc.)
│   ├── destination.dart                    # Murchison Falls, Bwindi, Queen Elizabeth, Rwenzori, Bunyonyi
│   └── species.dart                        # Mountain Gorilla, Shoebill, Crested Crane, Tree Lion
├── theme/
│   ├── app_colors.dart                     # 7 Figma color tokens
│   ├── app_typography.dart                 # Inter typography hierarchy
│   └── app_theme.dart                      # Light theme with 4dp rhythm & 16dp radii
├── widgets/
│   ├── custom_text_field.dart              # Rounded form inputs with validation & eye toggle
│   ├── destination_card.dart               # Destination card with image, rating, & bookmark
│   ├── primary_button.dart                 # 52dp Forest action button with loading state
│   ├── secondary_button.dart               # White outlined secondary action button
│   └── status_pill.dart                    # Sage, Ochre, and Forest pill tags
└── screens/
    ├── main_nav_screen.dart                # 5-tab Bottom Navigation Shell
    ├── auth/
    │   ├── welcome_screen.dart             # Onboarding hero screen with Pearl4U sprout
    │   ├── sign_in_screen.dart             # Sign in with password toggle & recovery link
    │   ├── create_account_screen.dart      # Registration form with 8-character validation
    │   └── forgot_password_screen.dart     # Password recovery instructions
    ├── explore/
    │   ├── explore_screen.dart             # Discover Uganda feed, search, and category chips
    │   └── filter_sheet.dart               # Bottom modal filter for regions & types
    ├── destination/
    │   └── destination_detail_screen.dart  # Full Murchison Falls profile & maps handoff
    ├── map/
    │   └── map_screen.dart                 # Interactive Uganda canvas with attraction pins
    ├── nature/
    │   ├── nature_guide_screen.dart        # Biodiversity hub & species directory
    │   └── species_detail_screen.dart      # Mountain Gorilla profile & conservation status
    ├── saved/
    │   └── saved_places_screen.dart        # Saved places collection & empty state
    └── profile/
        ├── profile_screen.dart             # User profile, statistics, and settings
        └── edit_profile_screen.dart        # Edit personal details form
```

---

## 👥 Contributor Attribution & Modules

| Contributor Name | Dedicated Feature Branch | Assigned Module & Deliverables |
| :--- | :--- | :--- |
| **Mukaga Kevin Wanyama** *(Team Lead)* | `feature/registration-and-profile` | **Registration & User Profile**: `CreateAccountScreen`, `ProfileScreen`, `EditProfileScreen`, and project orchestration. |
| **Mpotaima Ziriyah** | `feature/design-system-and-theme` | **Design System Foundations**: Color tokens (`AppColors`), Typography scale (`AppTypography`), Light theme (`AppTheme`), `PrimaryButton`, `SecondaryButton`, `CustomTextField`, `StatusPill`. |
| **Namuyaba Precious Mary** | `feature/auth-and-welcome` | **Authentication & Onboarding**: `WelcomeScreen`, `SignInScreen`, `ForgotPasswordScreen`. |
| **Kirabo Isaac** | `feature/navigation-and-explore` | **Navigation Shell & Explore Feed**: `MainNavScreen`, `ExploreScreen`, `FilterSheet`, `DestinationCard`, and `Category` models. |
| **Nankanja Sarah** | `feature/destination-and-maps` | **Destinations & Interactive Maps**: `DestinationDetailScreen` (Murchison Falls) and `MapScreen` (Uganda interactive pins & preview cards). |
| **Manana James Joshua** | `feature/nature-guide-and-saved` | **Nature Guide & Saved Places**: `NatureGuideScreen`, `SpeciesDetailScreen` (Mountain Gorilla), `SavedPlacesScreen`, `Species` model, and `main.dart`. |

---

## 🚀 How to Run

1. Clone or open the repository:
   ```bash
   cd pearl4u
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run on your preferred target:
   - **Chrome / Web**:
     ```bash
     flutter run -d chrome
     ```
   - **Android / Emulator**:
     ```bash
     flutter run -d android
     ```
   - **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
