# I-Heart-Ice-Cream

## Project Description
I-Heart-Ice-Cream is a Salesforce demo site with two AGILE iterations. The first utilizes Visualforce pages while the second is a revamp using Aura Components.

## Technologies Used
- Salesforce scratch orgs
- VSCode with SFDX extensions
- Git and GitHub


## Features
List of features ready and TODOs for future development
- Apex controllers for managing server-side data and computations.
- Visualforce pages for order menus, allergy information, popular flavor rankings, and job applications.
- Aura components that build off of the previous Visualforce pages and produce a cleaner site.

To-do list:
- Unit testing needs to be updated to fit our latest changes and additions.
- The customer support portal currently has a bug where cases submitted by customers are not logged to our Salesforce organization.

## Getting Started
1. First, use the following link to clone our GitHub repository and Salesforce files: https://github.com/Th3Pope/Project-1-Salesforce---Ice-Cream-Shop.git

2. If not already present on your system, install VSCode (or another editor of your choice) that supports an SFDX plugin.  

3. Create a scratch org based of the shape defined by config/project-scratch-def.json. An official video tutorial from Salesforce support can be found [here](https://www.youtube.com/watch?v=29C1TJTWauo) regarding how to do this.

## Usage
1. Once the scratch org is created, don't forget to push all of our custom components and objects into it. This can be done by running the 'sfdx force:source:push' command in your development terminal. 

2. Assuming you have set your scratch org's name or alias as the default, you should now be able to open it using the 'sfdx force:org:open' command in your development terminal. This will open the org's setup page in your preferred web browser.

3. Our Visualforce pages and Aura components should now be accessible from the Salesforce Developer Console located in the drop-down menu opened by clicking on the lightning gear icon in the top-right corner of the setup page. Each Visualforce page can be previewed directly and we have built corresponding harness applications in order to preview our Aura Components.

## Contributors
- Lynn Olson
- David Kinney
- Theodore Mitchell
- Jason Campbell
