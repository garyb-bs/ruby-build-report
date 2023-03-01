# build-report
BrowserStack test execution report

This repository creates an HTML file tabular test execution report of the BrowserStack Automate Build.

How to use the repository?

- Ensure you have Ruby (2.x or 3.x) setup on your machine.
    In the root directory of the repository, run the install command
    `bundle install`

- SET BROWSERSTACK Environment variables
    ```
    export BROWSERSTACK_USERNAME=<YOUR_BROWSERSTACK_USERNAME>
    export BROWSERSTACK_ACCESS_KEY=<YOUR_BROWSERSTACK_ACCESS_KEY> 
    ```

    Note: For Windows machine, you would use the `set` command instead of `export`.

- Create build HTML report for a BrowserStack Automate build
    `ruby get_session_details.rb <BROWSERSTACK_BUILD_ID>`

- The build report file `output.html` will get created in the root directory of the repository.
