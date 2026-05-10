

# Dusto Provider

Dusto Provider is the service-side application built with Flutter, designed for automotive workshops, mechanics, and roadside assistance teams. It enables service providers to manage incoming requests, track active jobs, and communicate directly with vehicle owners.

---

### 🚀 Key Features

* **Job Management:** Receive, accept, or decline service requests and roadside assistance calls in real-time.
* **Service Dashboard:** Overview of daily appointments, ongoing repairs, and completed tasks.
* **Live Navigation:** Integrated GPS to locate customers for on-site repairs or towing services.
* **Digital Inspection:** Tools to upload photos and notes about vehicle condition for transparent customer reporting.
* **Invoice Generation:** Create and send digital cost estimates and final bills directly to the user.
* **Earnings Tracker:** Monitor daily and monthly revenue with detailed transaction history.

### 🛠 Tech Stack

* Framework: Flutter
* State Management: BLoC (Business Logic Component)
* Location Services: Google Maps API for real-time customer tracking.
* Messaging: In-app chat for direct coordination with vehicle owners.

### 📁 Project Architecture

The provider app focuses on high availability and real-time data sync:

* Presentation Layer: Feature-driven UI for order queues, map views, and profile management using BLoC.
* Domain Layer: Logic for service availability toggles, status transitions, and price calculations.
* Data Layer: API integration for job synchronization and real-time location broadcasts.

### 🏁 Quick Start

#### Prerequisites

* Flutter SDK (Latest stable version)
* Physical device for GPS and camera testing

#### Setup

1. Clone the repo:
`git clone [https://github.com/SGBhowmick/gusto-provider.git](https://github.com/SGBhowmick/gusto-provider.git)`
2. Install dependencies:
`flutter pub get`
3. Run the app:
`flutter run`

---

*Helping service experts reach more customers.*
