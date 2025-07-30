# SearchSample

The **SearchSample** project is built with modularity and flexibility in mind. It is composed of four main components that are designed to work independently from one another. This architecture allows seamless replacement of parts such as the UI framework, data persistence method, or data source strategy—without affecting the rest of the system.

---

- [**Endpoint**] (https://api.openbrewerydb.org/v1/breweries/search?query=sample)

---

- [**FIGMA Design**] (https://www.figma.com/design/4FGFIDr1xZVpO1Fr3SFOx4/Untitled?node-id=0-1&m=dev&t=cxovaN2pAAI2RrWd-1)

---

## [Architecture Overview](https://docs.google.com/document/d/1-pWnOQf_OAxln_FOGvzy_XcgY_TTnej4uOH7b6qrysE/edit?tab=t.0)

SearchSample is made up of the following components:

### 1. `SearchFeature` (Core Logic Layer)
- Defines key protocols and models (`BreweryItem`)
- Includes:
  - `BreweryItemdataLoader` protocol for remote/local fetching
  - `BreweryItemsStore` protocol for persistence
  - ViewModel that uses the above protocols
  - Fallback class for offline search

### 2. `SearchFeatureAPI` (Remote Data Layer)
- Implements `DataLoading` for fetching from a remote server
- Uses the Open Brewery DB API

### 3. `SearchFeatureCache` (Persistence Layer)
- Implements `DataStorage` using **SwiftData**
- Can be easily swapped with Core Data, Realm, etc.

### 4. `SearchFeatureiOS` (UI Layer)
- Built using **SwiftUI**
- Includes:
  - A design system (fonts, styling, extensions)
  - Composable SwiftUI views

---

##  [BDD Specifications](https://docs.google.com/document/d/1-pWnOQf_OAxln_FOGvzy_XcgY_TTnej4uOH7b6qrysE/edit?tab=t.v8i0bnettmb4)

---

## [Flow Chart](https://docs.google.com/document/d/1-pWnOQf_OAxln_FOGvzy_XcgY_TTnej4uOH7b6qrysE/edit?tab=t.y5i5vabngnw5#heading=h.k9o9xovoq9ol))

---

## Design Philosophy

- **UI-agnostic**: SwiftUI can be replaced with UIKit without affecting logic or data layers.
- **Flexible fetching**: Can switch from remote API to local JSON or mock data.
- **Storage abstraction**: Easily switch between SwiftData, Core Data, Realm, or others.

---

## 📁 Folder Structure (Optional)

```plaintext
SearchSample/
├── SearchFeature/
├── SearchFeatureAPI/
├── SearchFeatureCache/
└── SearchFeatureiOS/
