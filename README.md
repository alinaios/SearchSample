#**BDD Specifications for Search and History Feature**

---

## 📘 **Story N1: User Wants to Search for Breweries**

**Narrative**  
_As a user,_  
_I want the app to allow me to search for breweries,_  
_So I can explore results dynamically from a public API._

### ✅ Scenario 1: Search with Active Internet Connection

- **Given** the user has an active internet connection  
- **And** the user has entered a valid search term  
- **When** the user initiates the search  
- **Then** the app should fetch matching results from the public API  
- **And** display a maximum of 5 results below the search field  

---

## 🕘 **Story N2: User Wants to Preview Previously Saved Search Results**

**Narrative**  
_As a user,_  
_I want the app to persist my selected search queries with timestamps,_  
_So I can view my search history even after restarting the app._

### ✅ Scenario 1: Save Selected Search with Timestamp

- **Given** the user has performed a search  
- **And** selects a result from the list  
- **When** the selection is made  
- **Then** the app should save the search term with the current timestamp  

### ✅ Scenario 2: Show Search History Below the Search Field

- **Given** the user has saved previous searches  
- **When** the search view is opened  
- **Then** the app should display the search history below the search field  
- **And** show each query with its timestamp  

### ✅ Scenario 3: Persist Search History Across Sessions

- **Given** the user has previously selected search queries  
- **When** the app is closed and reopened  
- **Then** the search history should still be visible in the same order  

---

## 📴 **Offline Scenarios**

### ⏳ Scenario 4: Show Cached Results if Offline

- **Given** the user has no internet connection  
- **And** there is a cached version of the previous search results  
- **When** the user enters the same search term  
- **Then** the app should display the latest cached results  

### ⏳ Scenario 5: Show Error if Offline and No Cache

- **Given** the user has no internet connection  
- **And** there is no cached data available for the search term  
- **When** the user initiates a search  
- **Then** the app should display an error message indicating that results cannot be retrieved  

---

