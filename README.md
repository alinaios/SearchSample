**BDD Specifications for Search and History Feature**

_**Story N1: User wants to search anything**_

Narrative:
As a user,
I want the app to allow me to search for breweries
So I can explore results (dynamically from a public API)

**Scenario 1: Search with active internet connection**
Given the user has an active internet connection
And the user has entered a valid search term
When the user initiates the search
Then the app should fetch matching results from the public API
And display a maximum of 5 results below the search field


_**Story N2: User wants to preview previously saved search results**_

Narrative:
As a user,
I want the app to persist my selected search queries with timestamps,
So I can view my search history even after restarting the app

**Scenario 1: Save selected search with timestamp**

Given the user has performed a search
And selects a result from the list
When the selection is made
Then the app should save the search term with the current timestamp

**Scenario 2: Show search history below the search field**

Given the user has saved previous searches
When the search view is opened
Then the app should display the search history below the search field
And show each query with its timestamp

Scenario 3: Persist search history across sessions
Given the user has previously selected search queries
When the app is closed and reopened
Then the search history should still be visible in the same order


_**Offline Scenarios**_

Scenario 4: Show cached results if offline
Given the user has no internet connection
And there is a cached version of the previous search results
When the user enters the same search term
Then the app should display the latest cached results

**Scenario 5: Show error if offline and no cache**

Given the user has no internet connection
And there is no cached data available for the search term
When the user initiates a search
Then the app should display an error message indicating that results cannot be retrieved


Flow chart of Search and History Feature



















